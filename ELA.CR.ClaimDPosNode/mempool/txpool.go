// Copyright (c) 2017-2019 The Elastos Foundation
// Use of this source code is governed by an MIT
// license that can be found in the LICENSE file.
//

package mempool

import (
	"bytes"
	"encoding/hex"
	"errors"
	"fmt"
	"sync"

	"github.com/elastos/Elastos.ELA/blockchain"
	. "github.com/elastos/Elastos.ELA/common"
	"github.com/elastos/Elastos.ELA/common/config"
	"github.com/elastos/Elastos.ELA/common/log"
	. "github.com/elastos/Elastos.ELA/core/types"
	"github.com/elastos/Elastos.ELA/core/types/outputpayload"
	"github.com/elastos/Elastos.ELA/core/types/payload"
	"github.com/elastos/Elastos.ELA/crypto"
	"github.com/elastos/Elastos.ELA/elanet/pact"
	elaerr "github.com/elastos/Elastos.ELA/errors"
	"github.com/elastos/Elastos.ELA/events"
	"github.com/elastos/Elastos.ELA/vm"
)

type TxPool struct {
	chainParams *config.Params

	sync.RWMutex
	txnList             map[Uint256]*Transaction // transaction which have been verifyed will put into this map
	inputUTXOList       map[string]*Transaction  // transaction which pass the verify will add the UTXO to this map
	sidechainTxList     map[Uint256]*Transaction // sidechain tx pool
	ownerPublicKeys     map[string]struct{}
	nodePublicKeys      map[string]struct{}
	crDIDs              map[Uint168]struct{}
	specialTxList       map[Uint256]struct{} // specialTxList holds the payload hashes of all illegal transactions and inactive arbitrators transactions
	crcProposals        map[Uint256]struct{}
	crcProposalReview   map[string]struct{}
	crcProposalWithdraw map[Uint256]struct{}
	crcProposalTracking map[Uint256]struct{}
	producerNicknames   map[string]struct{}
	crNicknames         map[string]struct{}
	hasCRCAppropriation bool

	tempInputUTXOList       map[string]*Transaction
	tempSidechainTxList     map[Uint256]*Transaction
	tempOwnerPublicKeys     map[string]struct{}
	tempNodePublicKeys      map[string]struct{}
	tempCRDIDs              map[Uint168]struct{}
	tempSpecialTxList       map[Uint256]struct{}
	tempCRCProposals        map[Uint256]struct{}
	tempCRCProposalReview   map[string]struct{}
	tempCRCProposalWithdraw map[Uint256]struct{}
	tempCRCProposalTracking map[Uint256]struct{}
	tempProducerNicknames   map[string]struct{}
	tempCRNicknames         map[string]struct{}
	tempHasCRCAppropriation bool

	txnListSize int
}

//append transaction to txnpool when check ok.
//1.check  2.check with ledger(db) 3.check with pool
func (mp *TxPool) AppendToTxPool(tx *Transaction) elaerr.ELAError {
	mp.Lock()
	defer mp.Unlock()
	err := mp.appendToTxPool(tx)
	if err != nil {
		return err
	}

	go events.Notify(events.ETTransactionAccepted, tx)
	return nil
}

func (mp *TxPool) appendToTxPool(tx *Transaction) elaerr.ELAError {
	txHash := tx.Hash()

	// Don't accept the transaction if it already exists in the pool.  This
	// applies to orphan transactions as well.  This check is intended to
	// be a quick check to weed out duplicates.
	if _, ok := mp.txnList[txHash]; ok {
		return elaerr.Simple(elaerr.ErrTxDuplicate, nil)
	}

	if tx.IsCoinBaseTx() {
		log.Warnf("coinbase tx %s cannot be added into transaction pool", tx.Hash())
		return elaerr.Simple(elaerr.ErrBlockIneffectiveCoinbase, nil)
	}

	chain := blockchain.DefaultLedger.Blockchain
	bestHeight := blockchain.DefaultLedger.Blockchain.GetHeight()
	if errCode := chain.CheckTransactionSanity(bestHeight+1, tx); errCode != nil {
		log.Warn("[TxPool CheckTransactionSanity] failed", tx.Hash())
		return errCode
	}
	references, err := chain.UTXOCache.GetTxReference(tx)
	if err != nil {
		log.Warn("[CheckTransactionContext] get transaction reference failed")
		return elaerr.Simple(elaerr.ErrTxUnknownReferredTx, nil)
	}
	if errCode := chain.CheckTransactionContext(bestHeight+1, tx, references); errCode != nil {
		log.Warn("[TxPool CheckTransactionContext] failed", tx.Hash())
		return errCode
	}
	//verify transaction by pool with lock
	if errCode := mp.verifyTransactionWithTxnPool(tx); errCode != nil {
		mp.clearTemp()
		log.Warn("[TxPool verifyTransactionWithTxnPool] failed", tx.Hash())
		return errCode
	}

	size := tx.GetSize()
	if mp.txnListSize+size > pact.MaxTxPoolSize {
		mp.clearTemp()
		log.Warn("TxPool check transactions size failed", tx.Hash())
		return elaerr.Simple(elaerr.ErrTxPoolOverCapacity, nil)
	}

	mp.commitTemp()
	mp.clearTemp()

	// Add the transaction to mem pool
	mp.txnList[txHash] = tx
	mp.txnListSize += size

	return nil
}

// HaveTransaction returns if a transaction is in transaction pool by the given
// transaction id. If no transaction match the transaction id, return false
func (mp *TxPool) HaveTransaction(txId Uint256) bool {
	mp.RLock()
	_, ok := mp.txnList[txId]
	mp.RUnlock()
	return ok
}

// GetTxsInPool returns a slice of all transactions in the mp.
//
// This function is safe for concurrent access.
func (mp *TxPool) GetTxsInPool() []*Transaction {
	mp.RLock()
	txs := make([]*Transaction, 0, len(mp.txnList))
	for _, tx := range mp.txnList {
		txs = append(txs, tx)
	}
	mp.RUnlock()
	return txs
}

//clean the trasaction Pool with committed block.
func (mp *TxPool) CleanSubmittedTransactions(block *Block) {
	mp.Lock()
	mp.cleanTransactions(block.Transactions)
	mp.cleanSidechainTx(block.Transactions)
	mp.cleanSideChainPowTx()
	mp.cleanCanceledProducerAndCR(block.Transactions)
	mp.Unlock()
}

func (mp *TxPool) cleanTransactions(blockTxs []*Transaction) {
	txsInPool := len(mp.txnList)
	deleteCount := 0
	for _, blockTx := range blockTxs {
		if blockTx.TxType == CoinBase {
			continue
		}

		if blockTx.IsIllegalTypeTx() || blockTx.IsInactiveArbitrators() {
			illegalData, ok := blockTx.Payload.(payload.DPOSIllegalData)
			if !ok {
				log.Error("cancel producer payload cast failed, tx:", blockTx.Hash())
				continue
			}
			hash := illegalData.Hash()
			if _, ok := mp.txnList[blockTx.Hash()]; ok {
				mp.doRemoveTransaction(blockTx.Hash(), blockTx.GetSize())
				deleteCount++
			}
			mp.delSpecialTx(&hash)
			continue
		} else if blockTx.IsNewSideChainPowTx() || blockTx.IsUpdateVersion() {
			if _, ok := mp.txnList[blockTx.Hash()]; ok {
				mp.doRemoveTransaction(blockTx.Hash(), blockTx.GetSize())
				deleteCount++
			}
			continue
		} else if blockTx.IsActivateProducerTx() {
			apPayload, ok := blockTx.Payload.(*payload.ActivateProducer)
			if !ok {
				log.Error("activate producer payload cast failed, tx:",
					blockTx.Hash())
				continue
			}
			mp.delNodePublicKey(BytesToHexString(apPayload.NodePublicKey))
			if _, ok := mp.txnList[blockTx.Hash()]; ok {
				mp.doRemoveTransaction(blockTx.Hash(), blockTx.GetSize())
				deleteCount++
			}
			continue
		}

		inputUtxos, err := blockchain.DefaultLedger.Blockchain.UTXOCache.GetTxReference(blockTx)
		if err != nil {
			log.Infof("Transaction=%s not exist when deleting, %s.",
				blockTx.Hash(), err)
			continue
		}
		for input := range inputUtxos {
			// we search transactions in transaction pool which have the same utxos with those transactions
			// in block. That is, if a transaction in the new-coming block uses the same utxo which a transaction
			// in transaction pool uses, then the latter one should be deleted, because one of its utxos has been used
			// by a confirmed transaction packed in the new-coming block.
			if tx := mp.getInputUTXOList(input); tx != nil {
				if tx.Hash() == blockTx.Hash() {
					// it is evidently that two transactions with the same transaction id has exactly the same utxos with each
					// other. This is a special case of what we've said above.
					log.Debugf("duplicated transactions detected when adding a new block. "+
						" Delete transaction in the transaction pool. Transaction id: %s", tx.Hash())
				} else {
					log.Debugf("double spent UTXO inputs detected in transaction pool when adding a new block. "+
						"Delete transaction in the transaction pool. "+
						"block transaction hash: %s, transaction hash: %s, the same input: %s, index: %d",
						blockTx.Hash(), tx.Hash(), input.Previous.TxID, input.Previous.Index)
				}

				//1.remove from txnList
				mp.doRemoveTransaction(tx.Hash(), tx.GetSize())

				//2.remove from UTXO list map
				for _, input := range tx.Inputs {
					mp.delInputUTXOList(input)
				}

				switch tx.TxType {
				case WithdrawFromSideChain:
					payload, ok := tx.Payload.(*payload.WithdrawFromSideChain)
					if !ok {
						log.Error("type cast failed when clean sidechain tx:", tx.Hash())
						continue
					}
					for _, hash := range payload.SideChainTransactionHashes {
						mp.delSidechainTx(hash)
					}
				case RegisterProducer:
					rpPayload, ok := tx.Payload.(*payload.ProducerInfo)
					if !ok {
						log.Error("register producer payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delOwnerPublicKey(BytesToHexString(rpPayload.OwnerPublicKey))
					mp.delNodePublicKey(BytesToHexString(rpPayload.NodePublicKey))
					mp.delProducerNickname(rpPayload.NickName)
				case UpdateProducer:
					upPayload, ok := tx.Payload.(*payload.ProducerInfo)
					if !ok {
						log.Error("update producer payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delOwnerPublicKey(BytesToHexString(upPayload.OwnerPublicKey))
					mp.delNodePublicKey(BytesToHexString(upPayload.NodePublicKey))
					mp.delProducerNickname(upPayload.NickName)
				case CancelProducer:
					cpPayload, ok := tx.Payload.(*payload.ProcessProducer)
					if !ok {
						log.Error("cancel producer payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delOwnerPublicKey(BytesToHexString(cpPayload.OwnerPublicKey))
				case RegisterCR:
					rcPayload, ok := tx.Payload.(*payload.CRInfo)
					if !ok {
						log.Error("register CR payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delCRDID(rcPayload.DID)
					mp.delPublicKeyByCode(rcPayload.Code)
					mp.delCRNickname(rcPayload.NickName)
				case UpdateCR:
					rcPayload, ok := tx.Payload.(*payload.CRInfo)
					if !ok {
						log.Error("update CR payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delCRDID(rcPayload.DID)
					mp.delCRNickname(rcPayload.NickName)
				case UnregisterCR:
					unrcPayload, ok := tx.Payload.(*payload.UnregisterCR)
					if !ok {
						log.Error("unregisterCR CR payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delCRDID(unrcPayload.DID)
				case CRCProposal:
					cpPayload, ok := tx.Payload.(*payload.CRCProposal)
					if !ok {
						log.Error("CRC proposal payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delCRCProposal(cpPayload.DraftHash)
				case CRCProposalReview:
					crcProposalReview, ok := tx.Payload.(*payload.CRCProposalReview)
					if !ok {
						log.Error("CRCProposalReview payload cast failed, tx:", tx.Hash())
						continue
					}
					key := mp.getCRCProposalReviewKey(crcProposalReview)
					mp.delCRCProposalReview(key)
				case CRCProposalWithdraw:
					crcProposalWithDraw, ok := tx.Payload.(*payload.CRCProposalWithdraw)
					if !ok {
						log.Error("crcProposalWithDraw payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delCRCProposalWithdraw(crcProposalWithDraw.ProposalHash)
				case CRCProposalTracking:
					cptPayload, ok := tx.Payload.(*payload.CRCProposalTracking)
					if !ok {
						log.Error("CRCProposalTracking payload cast failed, tx:", tx.Hash())
						continue
					}
					mp.delCRCProposalTracking(cptPayload.ProposalHash)
				case CRCAppropriation:
					mp.hasCRCAppropriation = false
				}

				deleteCount++
			}
		}
	}
	log.Debug(fmt.Sprintf("[cleanTransactionList],transaction %d in block, %d in transaction pool before, %d deleted,"+
		" Remains %d in TxPool",
		len(blockTxs), txsInPool, deleteCount, len(mp.txnList)))
}

func (mp *TxPool) getCRCProposalReviewKey(proposalReview *payload.
	CRCProposalReview) string {
	return proposalReview.DID.String() + proposalReview.ProposalHash.String()
}

func (mp *TxPool) cleanCanceledProducerAndCR(txs []*Transaction) error {
	for _, txn := range txs {
		if txn.TxType == CancelProducer {
			cpPayload, ok := txn.Payload.(*payload.ProcessProducer)
			if !ok {
				return errors.New("invalid cancel producer payload")
			}
			if err := mp.cleanVoteAndUpdateProducer(cpPayload.OwnerPublicKey); err != nil {
				log.Error(err)
			}
		}
		if txn.TxType == UnregisterCR {
			crPayload, ok := txn.Payload.(*payload.UnregisterCR)
			if !ok {
				return errors.New("invalid cancel producer payload")
			}
			if err := mp.cleanVoteAndUpdateCR(crPayload.DID); err != nil {
				log.Error(err)
			}
		}
	}

	return nil
}

func (mp *TxPool) cleanVoteAndUpdateProducer(ownerPublicKey []byte) error {
	for _, txn := range mp.txnList {
		if txn.TxType == TransferAsset {
		end:
			for _, output := range txn.Outputs {
				if output.Type == OTVote {
					opPayload, ok := output.Payload.(*outputpayload.VoteOutput)
					if !ok {
						return errors.New("invalid vote output payload")
					}
					for _, content := range opPayload.Contents {
						if content.VoteType == outputpayload.Delegate {
							for _, cv := range content.CandidateVotes {
								if bytes.Equal(ownerPublicKey, cv.Candidate) {
									mp.removeTransaction(txn)
									break end
								}
							}
						}
					}
				}
			}
		} else if txn.TxType == UpdateProducer {
			upPayload, ok := txn.Payload.(*payload.ProducerInfo)
			if !ok {
				return errors.New("invalid update producer payload")
			}
			if bytes.Equal(upPayload.OwnerPublicKey, ownerPublicKey) {
				mp.removeTransaction(txn)
				mp.delOwnerPublicKey(BytesToHexString(upPayload.OwnerPublicKey))
				mp.delNodePublicKey(BytesToHexString(upPayload.NodePublicKey))
			}
		}
	}

	return nil
}

func (mp *TxPool) cleanVoteAndUpdateCR(did Uint168) error {
	for _, txn := range mp.txnList {
		if txn.TxType == TransferAsset {
			for _, output := range txn.Outputs {
				if output.Type == OTVote {
					opPayload, ok := output.Payload.(*outputpayload.VoteOutput)
					if !ok {
						return errors.New("invalid vote output payload")
					}
					for _, content := range opPayload.Contents {
						if content.VoteType == outputpayload.CRC {
							for _, cv := range content.CandidateVotes {
								if bytes.Equal(did.Bytes(), cv.Candidate) {
									mp.removeTransaction(txn)
								}
							}
						}
					}
				}
			}
		} else if txn.TxType == UpdateCR {
			crPayload, ok := txn.Payload.(*payload.CRInfo)
			if !ok {
				return errors.New("invalid update CR payload")
			}
			if did.IsEqual(crPayload.DID) {
				mp.removeTransaction(txn)
				mp.delCRDID(crPayload.DID)
			}
		}
	}

	return nil
}

//get the transaction by hash
func (mp *TxPool) GetTransaction(hash Uint256) *Transaction {
	mp.RLock()
	defer mp.RUnlock()
	return mp.txnList[hash]
}

//verify transaction with txnpool
func (mp *TxPool) verifyTransactionWithTxnPool(
	txn *Transaction) elaerr.ELAError {
	if txn.IsSideChainPowTx() {
		// check and replace the duplicate sidechainpow tx
		mp.replaceDuplicateSideChainPowTx(txn)
	} else if txn.IsWithdrawFromSideChainTx() {
		// check if the withdraw transaction includes duplicate sidechain tx in pool
		if err := mp.verifyDuplicateSidechainTx(txn); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolSidechainTxDuplicate, err)
		}
	}

	// check if the transaction includes double spent UTXO inputs
	if err := mp.verifyDoubleSpend(txn); err != nil {
		log.Warn(err)
		return elaerr.Simple(elaerr.ErrTxPoolDoubleSpend, err)
	}

	if err := mp.verifyProducerRelatedTx(txn); err != nil {
		return err
	}

	return mp.verifyCRRelatedTx(txn)
}

//verify producer related transaction with txnpool
func (mp *TxPool) verifyProducerRelatedTx(txn *Transaction) elaerr.ELAError {
	switch txn.TxType {
	case RegisterProducer:
		p, ok := txn.Payload.(*payload.ProducerInfo)
		if !ok {
			err := fmt.Errorf(
				"register producer payload cast failed, tx:%s", txn.Hash())
			log.Error(err)
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateProducer(BytesToHexString(p.OwnerPublicKey),
			BytesToHexString(p.NodePublicKey), p.NickName); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolDPoSTxDuplicate, err)
		}
	case UpdateProducer:
		p, ok := txn.Payload.(*payload.ProducerInfo)
		if !ok {
			err := fmt.Errorf(
				"update producer payload cast failed, tx:%s", txn.Hash())
			log.Error(err)
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateProducer(BytesToHexString(p.OwnerPublicKey),
			BytesToHexString(p.NodePublicKey), p.NickName); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolDPoSTxDuplicate, err)
		}
	case CancelProducer:
		p, ok := txn.Payload.(*payload.ProcessProducer)
		if !ok {
			err := fmt.Errorf(
				"cancel producer payload cast failed, tx:%s", txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateOwner(BytesToHexString(p.OwnerPublicKey)); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolDPoSTxDuplicate, err)
		}
	case ActivateProducer:
		p, ok := txn.Payload.(*payload.ActivateProducer)
		if !ok {
			err := fmt.Errorf(
				"activate producer payload cast failed, tx:%s",
				txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateNode(BytesToHexString(p.NodePublicKey)); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolDPoSTxDuplicate, err)
		}
	case IllegalProposalEvidence, IllegalVoteEvidence, IllegalBlockEvidence,
		IllegalSidechainEvidence, InactiveArbitrators:
		illegalData, ok := txn.Payload.(payload.DPOSIllegalData)
		if !ok {
			err := fmt.Errorf(
				"special tx payload cast failed, tx:%s", txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		hash := illegalData.Hash()
		if err := mp.verifyDuplicateSpecialTx(&hash); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolDPoSTxDuplicate, err)
		}
	}

	return nil
}

//verify CR related transaction with txnpool
func (mp *TxPool) verifyCRRelatedTx(txn *Transaction) elaerr.ELAError {
	switch txn.TxType {
	case RegisterCR:
		p, ok := txn.Payload.(*payload.CRInfo)
		if !ok {
			err := fmt.Errorf(
				"register CR payload cast failed, tx:%s", txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateCRAndProducer(p.DID, p.Code, p.NickName); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	case UpdateCR:
		p, ok := txn.Payload.(*payload.CRInfo)
		if !ok {
			err := fmt.Errorf(
				"update CR payload cast failed, tx:%s", txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateCRAndNickname(p.DID, p.NickName); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	case UnregisterCR:
		p, ok := txn.Payload.(*payload.UnregisterCR)
		if !ok {
			err := fmt.Errorf(
				"unregister CR payload cast failed, tx:%s", txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateCR(p.DID); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	case CRCProposal:
		p, ok := txn.Payload.(*payload.CRCProposal)
		if !ok {
			err := fmt.Errorf(
				"CRC proposal payload cast failed, tx:%s", txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateCRCProposal(p.DraftHash); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	case CRCProposalReview:
		crcProposalReview, ok := txn.Payload.(*payload.CRCProposalReview)
		if !ok {
			err := fmt.Errorf(
				"crcProposalReview  payload cast failed, tx:%s",
				txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateCRCProposalReview(crcProposalReview); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	case CRCProposalWithdraw:
		crcProposalWithdraw, ok := txn.Payload.(*payload.CRCProposalWithdraw)
		if !ok {
			err := fmt.Errorf(
				"crcProposalWithdraw  payload cast failed, tx:%s", txn.Hash())
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateCRCProposalWithdraw(crcProposalWithdraw); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	case CRCProposalTracking:
		cptPayload, ok := txn.Payload.(*payload.CRCProposalTracking)
		if !ok {
			err := fmt.Errorf(
				"crcProposalTracking  payload cast failed, tx:%s", txn.Hash())
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolFailure, err)
		}
		if err := mp.verifyDuplicateCRCProposalTracking(cptPayload); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	case CRCAppropriation:
		if err := mp.verifyDuplicateCRCAppropriation(); err != nil {
			log.Warn(err)
			return elaerr.Simple(elaerr.ErrTxPoolCRTxDuplicate, err)
		}
	}

	return nil
}

//remove from associated map
func (mp *TxPool) removeTransaction(tx *Transaction) {
	//1.remove from txnList
	if _, ok := mp.txnList[tx.Hash()]; ok {
		mp.doRemoveTransaction(tx.Hash(), tx.GetSize())
	}

	//2.remove from UTXO list map
	reference, err := blockchain.DefaultLedger.Blockchain.UTXOCache.GetTxReference(tx)
	if err != nil {
		log.Infof("Transaction=%s not exist when deleting, %s",
			tx.Hash(), err)
		return
	}
	for UTXOTxInput := range reference {
		mp.delInputUTXOList(UTXOTxInput)
	}
}

//check and add to utxo list pool
func (mp *TxPool) verifyDoubleSpend(txn *Transaction) error {
	reference, err := blockchain.DefaultLedger.Blockchain.UTXOCache.GetTxReference(txn)
	if err != nil {
		return err
	}
	inputs := make([]*Input, 0)
	for k := range reference {
		if txn := mp.getInputUTXOList(k); txn != nil {
			return fmt.Errorf("double spent UTXO inputs detected, "+
				"transaction hash: %s, input: %s, index: %d",
				txn.Hash(), k.Previous.TxID, k.Previous.Index)
		}
		inputs = append(inputs, k)
	}
	for _, v := range inputs {
		mp.addInputUTXOList(txn, v)
	}

	return nil
}

func (mp *TxPool) IsDuplicateSidechainTx(sidechainTxHash Uint256) bool {
	mp.RLock()
	_, ok := mp.sidechainTxList[sidechainTxHash]
	mp.RUnlock()
	return ok
}

//check and add to sidechain tx pool
func (mp *TxPool) verifyDuplicateSidechainTx(txn *Transaction) error {
	withPayload, ok := txn.Payload.(*payload.WithdrawFromSideChain)
	if !ok {
		return errors.New("convert the payload of withdraw tx failed")
	}

	for _, hash := range withPayload.SideChainTransactionHashes {
		_, ok := mp.sidechainTxList[hash]
		if ok {
			return errors.New("duplicate sidechain tx detected")
		}
	}
	mp.addSidechainTx(txn)

	return nil
}

func (mp *TxPool) verifyDuplicateProducer(ownerPublicKey string,
	nodePublicKey string, nickName string) error {
	_, ok := mp.ownerPublicKeys[ownerPublicKey]
	if ok {
		return errors.New("this producer in being processed")
	}
	_, ok = mp.nodePublicKeys[nodePublicKey]
	if ok {
		return errors.New("this producer node in being processed")
	}
	_, ok = mp.producerNicknames[nickName]
	if ok {
		return errors.New("this producer nickName in being processed")
	}
	mp.addOwnerPublicKey(ownerPublicKey)
	mp.addNodePublicKey(nodePublicKey)
	mp.addProducerNickname(nickName)
	return nil
}

func (mp *TxPool) verifyDuplicateOwner(ownerPublicKey string) error {
	_, ok := mp.ownerPublicKeys[ownerPublicKey]
	if ok {
		return errors.New("this producer in being processed")
	}
	mp.addOwnerPublicKey(ownerPublicKey)

	return nil
}

func (mp *TxPool) addOwnerPublicKey(publicKey string) {
	mp.tempOwnerPublicKeys[publicKey] = struct{}{}
}

func (mp *TxPool) delOwnerPublicKey(publicKey string) {
	delete(mp.ownerPublicKeys, publicKey)
}

func (mp *TxPool) verifyDuplicateNode(nodePublicKey string) error {
	_, ok := mp.nodePublicKeys[nodePublicKey]
	if ok {
		return errors.New("this producer node in being processed")
	}
	mp.addNodePublicKey(nodePublicKey)

	return nil
}

func (mp *TxPool) addNodePublicKey(nodePublicKey string) {
	mp.tempNodePublicKeys[nodePublicKey] = struct{}{}
}

func (mp *TxPool) delNodePublicKey(nodePublicKey string) {
	delete(mp.nodePublicKeys, nodePublicKey)
}

func (mp *TxPool) verifyDuplicateCRAndNickname(did Uint168,
	nickname string) error {
	err := mp.verifyDuplicateCR(did)
	if err != nil {
		return err
	}
	_, ok := mp.crNicknames[nickname]
	if ok {
		return errors.New("this CR nickname in being processed")
	}
	mp.addCRNickName(nickname)
	return nil
}

func (mp *TxPool) verifyDuplicateCR(did Uint168) error {
	_, ok := mp.crDIDs[did]
	if ok {
		return errors.New("this CR in being processed")
	}
	mp.addCRDID(did)

	return nil
}

func (mp *TxPool) verifyDuplicateCRCProposal(originProposalHash Uint256) error {
	_, ok := mp.crcProposals[originProposalHash]
	if ok {
		return errors.New("this origin CRC proposal in being processed")
	}
	mp.addCRCProposal(originProposalHash)

	return nil
}

func (mp *TxPool) verifyDuplicateCRCProposalWithdraw(crcProposalWithdraw *payload.CRCProposalWithdraw) error {
	_, ok := mp.crcProposalWithdraw[crcProposalWithdraw.ProposalHash]
	if ok {
		return errors.New("this origin crcProposalWithdraw in being processed")
	}
	mp.addCRCProposalWithdraw(crcProposalWithdraw.ProposalHash)

	return nil
}

func (mp *TxPool) verifyDuplicateCRCProposalReview(crcProposalReview *payload.CRCProposalReview) error {

	key := mp.getCRCProposalReviewKey(crcProposalReview)
	_, ok := mp.crcProposalReview[key]
	if ok {
		return errors.New("this origin crcProposalReview in being processed")
	}
	mp.addCRCProposalReview(key)

	return nil
}

func (mp *TxPool) verifyDuplicateCRCProposalTracking(crcProposalTracking *payload.CRCProposalTracking) error {

	_, ok := mp.crcProposalTracking[crcProposalTracking.ProposalHash]
	if ok {
		return errors.New("this origin CRC proposal tracking in being processed")
	}
	mp.addCRCProposalTracking(crcProposalTracking.ProposalHash)

	return nil
}

func (mp *TxPool) verifyDuplicateCRCAppropriation() error {
	if mp.hasCRCAppropriation {
		return errors.New("this CRC appropriation in being processed")
	}
	mp.tempHasCRCAppropriation = true

	return nil
}

func (mp *TxPool) verifyDuplicateCRAndProducer(did Uint168, code []byte, crNickname string) error {
	_, ok := mp.crDIDs[did]
	if ok {
		return errors.New("this CR in being processed")
	}
	_, ok = mp.crNicknames[crNickname]
	if ok {
		return errors.New("this CR crNickname in being processed")
	}
	signType, err := crypto.GetScriptType(code)
	if err != nil {
		return err
	}

	if signType == vm.CHECKSIG {
		pk := hex.EncodeToString(code[1 : len(code)-1])
		if _, ok := mp.ownerPublicKeys[pk]; ok {
			return errors.New("this public key in being" +
				" processed by producer owner public key")
		}

		if _, ok := mp.nodePublicKeys[pk]; ok {
			return errors.New("this public key in being" +
				" processed by producer node public key")
		}
		mp.addOwnerPublicKey(pk)
		mp.addNodePublicKey(pk)
	}

	mp.addCRDID(did)
	mp.addCRNickName(crNickname)

	return nil
}

func (mp *TxPool) addCRDID(did Uint168) {
	mp.tempCRDIDs[did] = struct{}{}
}

func (mp *TxPool) delCRDID(did Uint168) {
	delete(mp.crDIDs, did)
}

func (mp *TxPool) addCRCProposal(originProposalHash Uint256) {
	mp.tempCRCProposals[originProposalHash] = struct{}{}
}

func (mp *TxPool) delCRCProposal(originProposalHash Uint256) {
	delete(mp.crcProposals, originProposalHash)
}

func (mp *TxPool) addProducerNickname(key string) {
	mp.tempProducerNicknames[key] = struct{}{}
}

func (mp *TxPool) delProducerNickname(key string) {
	delete(mp.producerNicknames, key)
}

func (mp *TxPool) addCRNickName(key string) {
	mp.tempCRNicknames[key] = struct{}{}
}

func (mp *TxPool) delCRNickname(key string) {
	delete(mp.crNicknames, key)
}

func (mp *TxPool) addCRCProposalReview(key string) {
	mp.tempCRCProposalReview[key] = struct{}{}
}

func (mp *TxPool) delCRCProposalReview(key string) {
	delete(mp.crcProposalReview, key)
}

func (mp *TxPool) addCRCProposalWithdraw(key Uint256) {
	mp.tempCRCProposalWithdraw[key] = struct{}{}
}

func (mp *TxPool) delCRCProposalWithdraw(key Uint256) {
	delete(mp.crcProposalWithdraw, key)
}

func (mp *TxPool) addCRCProposalTracking(key Uint256) {
	mp.tempCRCProposalTracking[key] = struct{}{}
}

func (mp *TxPool) delCRCProposalTracking(key Uint256) {
	delete(mp.crcProposalTracking, key)
}

func (mp *TxPool) delPublicKeyByCode(code []byte) {
	signType, err := crypto.GetScriptType(code)
	if err != nil {
		return
	}
	if signType == vm.CHECKSIG {
		pk := hex.EncodeToString(code[1 : len(code)-1])
		delete(mp.ownerPublicKeys, pk)
		delete(mp.nodePublicKeys, pk)
	}
}

func (mp *TxPool) addSpecialTx(hash *Uint256) {
	mp.tempSpecialTxList[*hash] = struct{}{}
}

func (mp *TxPool) delSpecialTx(hash *Uint256) {
	delete(mp.specialTxList, *hash)
}

func (mp *TxPool) verifyDuplicateSpecialTx(hash *Uint256) error {
	if _, ok := mp.specialTxList[*hash]; ok {
		return errors.New("this special tx has being processed")
	}
	mp.addSpecialTx(hash)

	return nil
}

// check and replace the duplicate sidechainpow tx
func (mp *TxPool) replaceDuplicateSideChainPowTx(txn *Transaction) {
	var replaceList []*Transaction

	for _, v := range mp.txnList {
		if v.TxType == SideChainPow {
			oldPayload := v.Payload.Data(payload.SideChainPowVersion)
			oldGenesisHashData := oldPayload[32:64]

			newPayload := txn.Payload.Data(payload.SideChainPowVersion)
			newGenesisHashData := newPayload[32:64]

			if bytes.Equal(oldGenesisHashData, newGenesisHashData) {
				replaceList = append(replaceList, v)
			}
		}
	}

	for _, txn := range replaceList {
		txid := txn.Hash()
		log.Info("replace sidechainpow transaction, txid=", txid.String())
		mp.removeTransaction(txn)
	}
}

// clean the sidechain tx pool
func (mp *TxPool) cleanSidechainTx(txs []*Transaction) {
	for _, txn := range txs {
		if txn.IsWithdrawFromSideChainTx() {
			withPayload := txn.Payload.(*payload.WithdrawFromSideChain)
			for _, hash := range withPayload.SideChainTransactionHashes {
				tx, ok := mp.sidechainTxList[hash]
				if ok {
					// delete tx
					if _, ok := mp.txnList[tx.Hash()]; ok {
						mp.doRemoveTransaction(tx.Hash(), tx.GetSize())
					}
					//delete utxo map
					for _, input := range tx.Inputs {
						mp.delInputUTXOList(input)
					}
					//delete sidechain tx map
					payload, ok := tx.Payload.(*payload.WithdrawFromSideChain)
					if !ok {
						log.Error("type cast failed when clean sidechain tx:", tx.Hash())
					}
					for _, hash := range payload.SideChainTransactionHashes {
						mp.delSidechainTx(hash)
					}
				}
			}
		}
	}
}

// clean the sidechainpow tx pool
func (mp *TxPool) cleanSideChainPowTx() {
	for hash, txn := range mp.txnList {
		if txn.IsSideChainPowTx() {
			arbiter := blockchain.DefaultLedger.Arbitrators.GetOnDutyCrossChainArbitrator()
			if err := blockchain.CheckSideChainPowConsensus(txn, arbiter); err != nil {
				// delete tx
				mp.doRemoveTransaction(hash, txn.GetSize())

				//delete utxo map
				for _, input := range txn.Inputs {
					delete(mp.inputUTXOList, input.ReferKey())
				}
			}
		}
	}
}

func (mp *TxPool) addToTxList(tx *Transaction) bool {
	txHash := tx.Hash()
	if _, ok := mp.txnList[txHash]; ok {
		return false
	}

	return true
}

func (mp *TxPool) GetTransactionCount() int {
	mp.RLock()
	defer mp.RUnlock()
	return len(mp.txnList)
}

func (mp *TxPool) getInputUTXOList(input *Input) *Transaction {
	return mp.inputUTXOList[input.ReferKey()]
}

func (mp *TxPool) addInputUTXOList(tx *Transaction, input *Input) {
	id := input.ReferKey()
	mp.tempInputUTXOList[id] = tx
}

func (mp *TxPool) delInputUTXOList(input *Input) {
	id := input.ReferKey()
	delete(mp.inputUTXOList, id)
}

func (mp *TxPool) addSidechainTx(txn *Transaction) {
	witPayload := txn.Payload.(*payload.WithdrawFromSideChain)
	for _, hash := range witPayload.SideChainTransactionHashes {
		mp.tempSidechainTxList[hash] = txn
	}
}

func (mp *TxPool) delSidechainTx(hash Uint256) {
	delete(mp.sidechainTxList, hash)
}

func (mp *TxPool) MaybeAcceptTransaction(tx *Transaction) error {
	mp.Lock()
	defer mp.Unlock()
	return mp.appendToTxPool(tx)
}

func (mp *TxPool) RemoveTransaction(txn *Transaction) {
	mp.Lock()
	txHash := txn.Hash()
	for i := range txn.Outputs {
		input := Input{
			Previous: OutPoint{
				TxID:  txHash,
				Index: uint16(i),
			},
		}

		txn := mp.getInputUTXOList(&input)
		if txn != nil {
			mp.removeTransaction(txn)
		}
	}
	mp.Unlock()
}

func (mp *TxPool) doRemoveTransaction(hash Uint256, txSize int) {
	delete(mp.txnList, hash)
	mp.txnListSize -= txSize
}

func (mp *TxPool) clearTemp() {
	mp.tempInputUTXOList = make(map[string]*Transaction)
	mp.tempSidechainTxList = make(map[Uint256]*Transaction)
	mp.tempOwnerPublicKeys = make(map[string]struct{})
	mp.tempNodePublicKeys = make(map[string]struct{})
	mp.tempSpecialTxList = make(map[Uint256]struct{})
	mp.tempCRDIDs = make(map[Uint168]struct{})
	mp.tempCRCProposals = make(map[Uint256]struct{})
	mp.tempCRCProposalReview = make(map[string]struct{})
	mp.tempCRCProposalWithdraw = make(map[Uint256]struct{})
	mp.tempCRCProposalTracking = make(map[Uint256]struct{})
	mp.tempProducerNicknames = make(map[string]struct{})
	mp.tempCRNicknames = make(map[string]struct{})
	mp.tempHasCRCAppropriation = false
}

func (mp *TxPool) commitTemp() {
	for k, v := range mp.tempInputUTXOList {
		mp.inputUTXOList[k] = v
	}
	for k, v := range mp.tempSidechainTxList {
		mp.sidechainTxList[k] = v
	}
	for k, v := range mp.tempOwnerPublicKeys {
		mp.ownerPublicKeys[k] = v
	}
	for k, v := range mp.tempNodePublicKeys {
		mp.nodePublicKeys[k] = v
	}
	for k, v := range mp.tempCRDIDs {
		mp.crDIDs[k] = v
	}
	for k, v := range mp.tempSpecialTxList {
		mp.specialTxList[k] = v
	}
	for k, v := range mp.tempCRCProposals {
		mp.crcProposals[k] = v
	}
	for k, v := range mp.tempProducerNicknames {
		mp.producerNicknames[k] = v
	}
	for k, v := range mp.tempCRNicknames {
		mp.crNicknames[k] = v
	}
	for k, v := range mp.tempCRCProposalReview {
		mp.crcProposalReview[k] = v
	}
	for k, v := range mp.tempCRCProposalWithdraw {
		mp.crcProposalWithdraw[k] = v
	}
	mp.hasCRCAppropriation = mp.tempHasCRCAppropriation
}

func NewTxPool(params *config.Params) *TxPool {
	return &TxPool{
		chainParams:             params,
		inputUTXOList:           make(map[string]*Transaction),
		txnList:                 make(map[Uint256]*Transaction),
		sidechainTxList:         make(map[Uint256]*Transaction),
		ownerPublicKeys:         make(map[string]struct{}),
		nodePublicKeys:          make(map[string]struct{}),
		specialTxList:           make(map[Uint256]struct{}),
		crDIDs:                  make(map[Uint168]struct{}),
		crcProposals:            make(map[Uint256]struct{}),
		producerNicknames:       make(map[string]struct{}),
		crNicknames:             make(map[string]struct{}),
		crcProposalReview:       make(map[string]struct{}),
		crcProposalWithdraw:     make(map[Uint256]struct{}),
		crcProposalTracking:     make(map[Uint256]struct{}),
		tempInputUTXOList:       make(map[string]*Transaction),
		tempSidechainTxList:     make(map[Uint256]*Transaction),
		tempOwnerPublicKeys:     make(map[string]struct{}),
		tempNodePublicKeys:      make(map[string]struct{}),
		tempSpecialTxList:       make(map[Uint256]struct{}),
		tempCRDIDs:              make(map[Uint168]struct{}),
		tempCRCProposals:        make(map[Uint256]struct{}),
		tempProducerNicknames:   make(map[string]struct{}),
		tempCRNicknames:         make(map[string]struct{}),
		tempCRCProposalReview:   make(map[string]struct{}),
		tempCRCProposalWithdraw: make(map[Uint256]struct{}),
		tempCRCProposalTracking: make(map[Uint256]struct{}),
	}
}
