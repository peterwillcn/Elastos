package blockchain

import (
	"bytes"
	"encoding/hex"
	"errors"
	"fmt"
	"math"
	"sort"
	"strconv"

	"github.com/elastos/Elastos.ELA/common"
	"github.com/elastos/Elastos.ELA/common/config"
	"github.com/elastos/Elastos.ELA/common/log"
	"github.com/elastos/Elastos.ELA/core/contract"
	"github.com/elastos/Elastos.ELA/core/contract/program"
	. "github.com/elastos/Elastos.ELA/core/types"
	"github.com/elastos/Elastos.ELA/core/types/outputpayload"
	"github.com/elastos/Elastos.ELA/core/types/payload"
	"github.com/elastos/Elastos.ELA/crypto"
	. "github.com/elastos/Elastos.ELA/crypto"
	"github.com/elastos/Elastos.ELA/dpos/state"
	"github.com/elastos/Elastos.ELA/elanet/pact"
	. "github.com/elastos/Elastos.ELA/errors"
)

const (
	// MinDepositAmount is the minimum deposit as a producer.
	MinDepositAmount = 5000 * 100000000

	// DepositLockupBlocks indicates how many blocks need to wait when cancel
	// producer was triggered, and can submit return deposit coin request.
	DepositLockupBlocks = 2160

	// MaxStringLength is the maximum length of a string field.
	MaxStringLength = 100

	// InactiveRecoveringHeightLimit is the minimum height an inactive
	// producer can request recovering
	InactiveRecoveringHeightLimit = 720
)

// CheckTransactionSanity verifys received single transaction
func (b *BlockChain) CheckTransactionSanity(blockHeight uint32, txn *Transaction) ErrCode {
	if err := checkTransactionSize(txn); err != nil {
		log.Warn("[CheckTransactionSize],", err)
		return ErrTransactionSize
	}

	if err := checkTransactionInput(txn); err != nil {
		log.Warn("[CheckTransactionInput],", err)
		return ErrInvalidInput
	}

	if err := b.checkTransactionOutput(blockHeight, txn); err != nil {
		log.Warn("[CheckTransactionOutput],", err)
		return ErrInvalidOutput
	}

	if err := checkAssetPrecision(txn); err != nil {
		log.Warn("[CheckAssetPrecesion],", err)
		return ErrAssetPrecision
	}

	if err := checkAttributeProgram(blockHeight, txn); err != nil {
		log.Warn("[CheckAttributeProgram],", err)
		return ErrAttributeProgram
	}

	if err := checkTransactionPayload(txn); err != nil {
		log.Warn("[CheckTransactionPayload],", err)
		return ErrTransactionPayload
	}

	if err := checkDuplicateSidechainTx(txn); err != nil {
		log.Warn("[CheckDuplicateSidechainTx],", err)
		return ErrSidechainTxDuplicate
	}

	// check items above for Coinbase transaction
	if txn.IsCoinBaseTx() {
		return Success
	}

	return Success
}

// CheckTransactionContext verifys a transaction with history transaction in ledger
func (b *BlockChain) CheckTransactionContext(blockHeight uint32, txn *Transaction) ErrCode {
	// check if duplicated with transaction in ledger
	if exist := b.db.IsTxHashDuplicate(txn.Hash()); exist {
		log.Warn("[CheckTransactionContext] duplicate transaction check failed.")
		return ErrTransactionDuplicate
	}

	switch txn.TxType {
	case CoinBase:
		return Success

	case IllegalProposalEvidence:
		if err := b.checkIllegalProposalsTransaction(txn); err != nil {
			log.Warn("[CheckIllegalProposalsTransaction],", err)
			return ErrTransactionPayload
		} else {
			return Success
		}

	case IllegalVoteEvidence:
		if err := b.checkIllegalVotesTransaction(txn); err != nil {
			log.Warn("[CheckIllegalVotesTransaction],", err)
			return ErrTransactionPayload
		} else {
			return Success
		}

	case IllegalBlockEvidence:
		if err := b.checkIllegalBlocksTransaction(txn); err != nil {
			log.Warn("[CheckIllegalBlocksTransaction],", err)
			return ErrTransactionPayload
		}

	case IllegalSidechainEvidence:
		if err := b.checkSidechainIllegalEvidenceTransaction(txn); err != nil {
			log.Warn("[CheckSidechainIllegalEvidenceTransaction],", err)
			return ErrTransactionPayload
		}

	case InactiveArbitrators:
		if err := b.checkInactiveArbitratorsTransaction(txn); err != nil {
			log.Warn("[CheckInactiveArbitrators],", err)
			return ErrTransactionPayload
		}

	case SideChainPow:
		arbitrator := DefaultLedger.Arbitrators.GetOnDutyArbitrator()
		if err := CheckSideChainPowConsensus(txn, arbitrator); err != nil {
			log.Warn("[CheckSideChainPowConsensus],", err)
			return ErrSideChainPowConsensus
		}

	case RegisterProducer:
		if err := b.checkRegisterProducerTransaction(txn); err != nil {
			log.Warn("[CheckRegisterProducerTransaction],", err)
			return ErrTransactionPayload
		}

	case CancelProducer:
		if err := b.checkCancelProducerTransaction(txn); err != nil {
			log.Warn("[CheckCancelProducerTransaction],", err)
			return ErrTransactionPayload
		}

	case UpdateProducer:
		if err := b.checkUpdateProducerTransaction(txn); err != nil {
			log.Warn("[CheckUpdateProducerTransaction],", err)
			return ErrTransactionPayload
		}

	case ActivateProducer:
		if err := b.checkActivateProducerTransaction(txn, blockHeight); err != nil {
			log.Warn("[CheckActivateProducerTransaction],", err)
			return ErrTransactionPayload
		}
	}

	// check double spent transaction
	if DefaultLedger.IsDoubleSpend(txn) {
		log.Warn("[CheckTransactionContext] IsDoubleSpend check failed")
		return ErrDoubleSpend
	}

	references, err := DefaultLedger.Store.GetTxReference(txn)
	if err != nil {
		log.Warn("[CheckTransactionContext] get transaction reference failed")
		return ErrUnknownReferredTx
	}

	if txn.IsWithdrawFromSideChainTx() {
		if err := b.checkWithdrawFromSideChainTransaction(txn, references); err != nil {
			log.Warn("[CheckWithdrawFromSideChainTransaction],", err)
			return ErrSidechainTxDuplicate
		}
	}

	if txn.IsTransferCrossChainAssetTx() {
		if err := b.checkTransferCrossChainAssetTransaction(txn, references); err != nil {
			log.Warn("[CheckTransferCrossChainAssetTransaction],", err)
			return ErrInvalidOutput
		}
	}

	if txn.IsReturnDepositCoin() {
		if err := b.checkReturnDepositCoinTransaction(txn, references); err != nil {
			log.Warn("[CheckReturnDepositCoinTransaction],", err)
			return ErrReturnDepositConsensus
		}
	}

	if err := checkTransactionUTXOLock(txn, references); err != nil {
		log.Warn("[CheckTransactionUTXOLock],", err)
		return ErrUTXOLocked
	}

	if err := checkTransactionFee(txn, references); err != nil {
		log.Warn("[CheckTransactionFee],", err)
		return ErrTransactionBalance
	}

	if err := checkDestructionAddress(references); err != nil {
		log.Warn("[CheckDestructionAddress], ", err)
		return ErrInvalidInput
	}

	if err := checkTransactionDepositUTXO(txn, references); err != nil {
		log.Warn("[CheckTransactionDepositUTXO],", err)
		return ErrInvalidInput
	}

	if err := checkTransactionSignature(txn, references); err != nil {
		log.Warn("[CheckTransactionSignature],", err)
		return ErrTransactionSignature
	}

	if err := checkTransactionCoinbaseOutputLock(txn); err != nil {
		log.Warn("[CheckTransactionCoinbaseLock]", err)
		return ErrIneffectiveCoinbase
	}

	if txn.Version >= TxVersion09 {
		if err := checkVoteProducerOutputs(txn.Outputs, references, getProducerPublicKeys(b.state.GetActiveProducers())); err != nil {
			log.Warn("[CheckVoteProducerOutputs],", err)
			return ErrInvalidOutput
		}
	}

	return Success
}

func checkVoteProducerOutputs(outputs []*Output, references map[*Input]*Output, producers [][]byte) error {
	programHashes := make(map[common.Uint168]struct{})
	for _, v := range references {
		programHashes[v.ProgramHash] = struct{}{}
	}

	pds := make(map[string]struct{})
	for _, p := range producers {
		pds[common.BytesToHexString(p)] = struct{}{}
	}

	for _, o := range outputs {
		if o.Type == OTVote {
			if _, ok := programHashes[o.ProgramHash]; !ok {
				return errors.New("the output address of vote tx should exist in its input")
			}
			payload, ok := o.Payload.(*outputpayload.VoteOutput)
			if !ok {
				return errors.New("invalid vote output payload")
			}
			for _, content := range payload.Contents {
				if content.VoteType == outputpayload.Delegate {
					for _, candidate := range content.Candidates {
						if _, ok := pds[common.BytesToHexString(candidate)]; !ok {
							return fmt.Errorf("invalid vote output payload candidate: %s", common.BytesToHexString(candidate))
						}
					}
				}
			}
		}
	}

	return nil
}

func getProducerPublicKeys(producers []*state.Producer) [][]byte {
	var publicKeys [][]byte
	for _, p := range producers {
		publicKeys = append(publicKeys, p.Info().OwnerPublicKey)
	}
	return publicKeys
}

func checkDestructionAddress(references map[*Input]*Output) error {
	for _, output := range references {
		// this uint168 code
		// is the program hash of the Elastos foundation destruction address ELANULLXXXXXXXXXXXXXXXXXXXXXYvs3rr
		// we allow no output from destruction address.
		// So add a check here in case someone crack the private key of this address.
		if output.ProgramHash == common.Uint168([21]uint8{33, 32, 254, 229, 215, 235, 62, 92, 125, 49, 151, 254, 207, 108, 13, 227, 15, 136, 154, 206, 247}) {
			return errors.New("cannot use utxo in the Elastos foundation destruction address")
		}
	}
	return nil
}

func checkTransactionCoinbaseOutputLock(txn *Transaction) error {
	type lockTxInfo struct {
		isCoinbaseTx bool
		locktime     uint32
	}
	transactionCache := make(map[common.Uint256]lockTxInfo)
	currentHeight := DefaultLedger.Blockchain.GetHeight()
	var referTxn *Transaction
	for _, input := range txn.Inputs {
		var lockHeight uint32
		var isCoinbase bool
		referHash := input.Previous.TxID
		if _, ok := transactionCache[referHash]; ok {
			lockHeight = transactionCache[referHash].locktime
			isCoinbase = transactionCache[referHash].isCoinbaseTx
		} else {
			var err error
			referTxn, _, err = DefaultLedger.Store.GetTransaction(referHash)
			// TODO
			// we have executed DefaultLedger.Store.GetTxReference(txn) before.
			//So if we can't find referTxn here, there must be a data inconsistent problem,
			// because we do not add lock correctly.This problem will be fixed later on.
			if err != nil {
				return errors.New("[CheckTransactionCoinbaseOutputLock] get tx reference failed:" + err.Error())
			}
			lockHeight = referTxn.LockTime
			isCoinbase = referTxn.IsCoinBaseTx()
			transactionCache[referHash] = lockTxInfo{isCoinbase, lockHeight}
		}

		if isCoinbase && currentHeight-lockHeight < config.Parameters.ChainParam.CoinbaseLockTime {
			return errors.New("cannot unlock coinbase transaction output")
		}
	}
	return nil
}

//validate the transaction of duplicate UTXO input
func checkTransactionInput(txn *Transaction) error {
	if txn.IsCoinBaseTx() {
		if len(txn.Inputs) != 1 {
			return errors.New("coinbase must has only one input")
		}
		coinbaseInputHash := txn.Inputs[0].Previous.TxID
		coinbaseInputIndex := txn.Inputs[0].Previous.Index
		//TODO :check sequence
		if !coinbaseInputHash.IsEqual(common.EmptyHash) || coinbaseInputIndex != math.MaxUint16 {
			return errors.New("invalid coinbase input")
		}

		return nil
	}
	if txn.IsIllegalTypeTx() || txn.IsInactiveArbitrators() {
		if len(txn.Inputs) != 0 {
			return errors.New("illegal transactions must has no input")
		}
		return nil
	}

	if len(txn.Inputs) <= 0 {
		return errors.New("transaction has no inputs")
	}
	existingTxInputs := make(map[string]struct{})
	for _, input := range txn.Inputs {
		if input.Previous.TxID.IsEqual(common.EmptyHash) && (input.Previous.Index == math.MaxUint16) {
			return errors.New("invalid transaction input")
		}
		if _, exists := existingTxInputs[input.ReferKey()]; exists {
			return errors.New("duplicated transaction inputs")
		} else {
			existingTxInputs[input.ReferKey()] = struct{}{}
		}
	}

	return nil
}

func (b *BlockChain) checkTransactionOutput(blockHeight uint32,
	txn *Transaction) error {
	if len(txn.Outputs) > math.MaxUint16 {
		return errors.New("output count should not be greater than 65535(MaxUint16)")
	}

	if txn.IsCoinBaseTx() {
		if len(txn.Outputs) < 2 {
			return errors.New("coinbase output is not enough, at least 2")
		}

		if !txn.Outputs[0].ProgramHash.IsEqual(FoundationAddress) {
			return errors.New("First output address should be foundation address.")
		}

		var totalReward = common.Fixed64(0)
		for _, output := range txn.Outputs {
			if output.AssetID != config.ELAAssetID {
				return errors.New("Asset ID in coinbase is invalid")
			}
			totalReward += output.Value
		}

		foundationReward := txn.Outputs[0].Value

		if blockHeight <= b.chainParams.PublicDPOSHeight &&
			common.Fixed64(foundationReward) < common.Fixed64(float64(totalReward)*0.3) {
			return errors.New("Reward to foundation in coinbase < 30%")
		}

		return nil
	}

	if txn.IsIllegalTypeTx() || txn.IsInactiveArbitrators() {
		if len(txn.Outputs) != 0 {
			return errors.New("Illegal transactions should have no output")
		}

		return nil
	}

	if len(txn.Outputs) < 1 {
		return errors.New("transaction has no outputs")
	}
	// check if output address is valid
	for _, output := range txn.Outputs {
		if output.AssetID != config.ELAAssetID {
			return errors.New("asset ID in output is invalid")
		}

		// output value must >= 0
		if output.Value < common.Fixed64(0) {
			return errors.New("Invalide transaction UTXO output.")
		}

		if err := checkOutputProgramHash(blockHeight, output.ProgramHash); err != nil {
			return err
		}

		if txn.Version >= TxVersion09 {
			if err := checkOutputPayload(txn.TxType, output); err != nil {
				return err
			}
		}
	}

	return nil
}

func checkOutputProgramHash(height uint32, programHash common.Uint168) error {
	// main version >= 88812
	if height >= config.DefaultParams.CheckAddressHeight {
		var empty = common.Uint168{}
		if programHash.IsEqual(empty) {
			return nil
		}

		prefix := contract.PrefixType(programHash[0])
		switch prefix {
		case contract.PrefixStandard:
		case contract.PrefixMultiSig:
		case contract.PrefixCrossChain:
		case contract.PrefixDeposit:
		default:
			return errors.New("invalid program hash prefix")
		}

		addr, err := programHash.ToAddress()
		if err != nil {
			return errors.New("invalid program hash")
		}
		_, err = common.Uint168FromAddress(addr)
		if err != nil {
			return errors.New("invalid program hash")
		}

		return nil
	}

	// old version [0, 88812)
	return nil
}

func checkOutputPayload(txType TxType, output *Output) error {
	// OTVote information can only be placed in TransferAsset transaction.
	if txType == TransferAsset {
		switch output.Type {
		case OTVote:
			if contract.GetPrefixType(output.ProgramHash) !=
				contract.PrefixStandard {
				return errors.New("output address should be standard")
			}
		case OTNone:
		case OTMapping:
		default:
			return errors.New("transaction type dose not match the output payload type")
		}
	} else {
		switch output.Type {
		case OTNone:
		default:
			return errors.New("transaction type dose not match the output payload type")
		}
	}

	return output.Payload.Validate()
}

func checkTransactionUTXOLock(txn *Transaction, references map[*Input]*Output) error {
	if txn.IsCoinBaseTx() {
		return nil
	}
	for input, output := range references {

		if output.OutputLock == 0 {
			//check next utxo
			continue
		}
		if input.Sequence != math.MaxUint32-1 {
			return errors.New("Invalid input sequence")
		}
		if txn.LockTime < output.OutputLock {
			return errors.New("UTXO output locked")
		}
	}
	return nil
}

func checkTransactionDepositUTXO(txn *Transaction, references map[*Input]*Output) error {
	for _, output := range references {
		if contract.GetPrefixType(output.ProgramHash) == contract.PrefixDeposit {
			if !txn.IsReturnDepositCoin() {
				return errors.New("only the ReturnDepositCoin transaction can use the deposit UTXO")
			}
		} else {
			if txn.IsReturnDepositCoin() {
				return errors.New("the ReturnDepositCoin transaction can only use the deposit UTXO")
			}
		}
	}

	return nil
}

func checkTransactionSize(txn *Transaction) error {
	size := txn.GetSize()
	if size <= 0 || size > pact.MaxBlockSize {
		return fmt.Errorf("Invalid transaction size: %d bytes", size)
	}

	return nil
}

func checkAssetPrecision(txn *Transaction) error {
	if len(txn.Outputs) == 0 {
		return nil
	}
	assetOutputs := make(map[common.Uint256][]*Output)

	for _, v := range txn.Outputs {
		assetOutputs[v.AssetID] = append(assetOutputs[v.AssetID], v)
	}
	for k, outputs := range assetOutputs {
		asset, err := DefaultLedger.GetAsset(k)
		if err != nil {
			return errors.New("The asset not exist in local blockchain.")
		}
		precision := asset.Precision
		for _, output := range outputs {
			if !checkAmountPrecise(output.Value, precision) {
				return errors.New("The precision of asset is incorrect.")
			}
		}
	}
	return nil
}

func checkTransactionFee(tx *Transaction, references map[*Input]*Output) error {
	var outputValue common.Fixed64
	var inputValue common.Fixed64
	for _, output := range tx.Outputs {
		outputValue += output.Value
	}
	for _, reference := range references {
		inputValue += reference.Value
	}
	if inputValue < common.Fixed64(config.Parameters.PowConfiguration.MinTxFee)+outputValue {
		return fmt.Errorf("transaction fee not enough")
	}
	return nil
}

func checkAttributeProgram(blockHeight uint32, tx *Transaction) error {
	switch tx.TxType {
	case CoinBase:
		// Coinbase and illegal transactions do not check attribute and program
		if len(tx.Programs) != 0 {
			return errors.New("transaction should have no programs")
		}
		return nil
	case IllegalSidechainEvidence:
		fallthrough
	case IllegalProposalEvidence:
		fallthrough
	case IllegalVoteEvidence:
		if len(tx.Programs) != 0 || len(tx.Attributes) != 0 {
			return errors.New("illegal proposal and vote transactions should have no attributes and programs")
		}
		return nil
	case IllegalBlockEvidence:
		if len(tx.Programs) != 1 {
			return errors.New("illegal block transactions should have one and only one program")
		}
		if len(tx.Attributes) != 0 {
			return errors.New("illegal block transactions should have no programs")
		}
	case InactiveArbitrators:
		if len(tx.Programs) != 1 {
			return errors.New("inactive arbitrators transactions should have one and only one program")
		}
		if len(tx.Attributes) != 1 {
			return errors.New("inactive arbitrators transactions should have one and only one arbitrator")
		}
	}

	// Check attributes
	for _, attr := range tx.Attributes {
		if !IsValidAttributeType(attr.Usage) {
			return fmt.Errorf("invalid attribute usage %v", attr.Usage)
		}
	}

	// Check programs
	if len(tx.Programs) == 0 {
		return fmt.Errorf("no programs found in transaction")
	}
	for _, program := range tx.Programs {
		if program.Code == nil {
			return fmt.Errorf("invalid program code nil")
		}
		if program.Parameter == nil {
			return fmt.Errorf("invalid program parameter nil")
		}
	}
	return nil
}

func checkTransactionSignature(tx *Transaction, references map[*Input]*Output) error {
	programHashes, err := GetTxProgramHashes(tx, references)
	if err != nil {
		return err
	}

	buf := new(bytes.Buffer)
	tx.SerializeUnsigned(buf)

	// sort the program hashes of owner and programs of the transaction
	common.SortProgramHashByCodeHash(programHashes)
	SortPrograms(tx.Programs)

	return RunPrograms(buf.Bytes(), programHashes, tx.Programs)
}

func checkAmountPrecise(amount common.Fixed64, precision byte) bool {
	return amount.IntValue()%int64(math.Pow(10, float64(8-precision))) == 0
}

func checkTransactionPayload(txn *Transaction) error {
	switch pld := txn.Payload.(type) {
	case *payload.RegisterAsset:
		if pld.Asset.Precision < payload.MinPrecision || pld.Asset.Precision > payload.MaxPrecision {
			return errors.New("Invalide asset Precision.")
		}
		if !checkAmountPrecise(pld.Amount, pld.Asset.Precision) {
			return errors.New("Invalide asset value,out of precise.")
		}
	case *payload.TransferAsset:
	case *payload.Record:
	case *payload.CoinBase:
	case *payload.SideChainPow:
	case *payload.WithdrawFromSideChain:
	case *payload.TransferCrossChainAsset:
	case *payload.ProducerInfo:
	case *payload.ProcessProducer:
	case *payload.ReturnDepositCoin:
	case *payload.DPOSIllegalProposals:
	case *payload.DPOSIllegalVotes:
	case *payload.DPOSIllegalBlocks:
	case *payload.SidechainIllegalData:
	case *payload.InactiveArbitrators:
	default:
		return errors.New("[txValidator],invalidate transaction payload type.")
	}
	return nil
}

//validate the transaction of duplicate sidechain transaction
func checkDuplicateSidechainTx(txn *Transaction) error {
	if txn.IsWithdrawFromSideChainTx() {
		witPayload := txn.Payload.(*payload.WithdrawFromSideChain)
		existingHashs := make(map[common.Uint256]struct{})
		for _, hash := range witPayload.SideChainTransactionHashes {
			if _, exist := existingHashs[hash]; exist {
				return errors.New("Duplicate sidechain tx detected in a transaction")
			}
			existingHashs[hash] = struct{}{}
		}
	}
	return nil
}

func CheckSideChainPowConsensus(txn *Transaction, arbitrator []byte) error {
	payloadSideChainPow, ok := txn.Payload.(*payload.SideChainPow)
	if !ok {
		return errors.New("Side mining transaction has invalid payload")
	}

	publicKey, err := DecodePoint(arbitrator)
	if err != nil {
		return err
	}

	buf := new(bytes.Buffer)
	err = payloadSideChainPow.Serialize(buf, payload.SideChainPowVersion)
	if err != nil {
		return err
	}

	err = Verify(*publicKey, buf.Bytes()[0:68], payloadSideChainPow.SignedData)
	if err != nil {
		return errors.New("Arbitrator is not matched")
	}

	return nil
}

func (b *BlockChain) checkWithdrawFromSideChainTransaction(txn *Transaction, references map[*Input]*Output) error {
	witPayload, ok := txn.Payload.(*payload.WithdrawFromSideChain)
	if !ok {
		return errors.New("Invalid withdraw from side chain payload type")
	}
	for _, hash := range witPayload.SideChainTransactionHashes {
		if exist := DefaultLedger.Store.IsSidechainTxHashDuplicate(hash); exist {
			return errors.New("Duplicate side chain transaction hash in paylod")
		}
	}

	for _, v := range references {
		if bytes.Compare(v.ProgramHash[0:1], []byte{byte(contract.PrefixCrossChain)}) != 0 {
			return errors.New("Invalid transaction inputs address, without \"X\" at beginning")
		}
	}

	for _, p := range txn.Programs {
		publicKeys, err := crypto.ParseCrossChainScript(p.Code)
		if err != nil {
			return err
		}

		if err := b.checkCrossChainArbitrators(publicKeys); err != nil {
			return err
		}
	}

	return nil
}

func (b *BlockChain) checkCrossChainArbitrators(publicKeys [][]byte) error {
	arbitrators := DefaultLedger.Arbitrators.GetArbitrators()
	if len(arbitrators) != len(publicKeys) {
		return errors.New("invalid arbitrator count")
	}

	arbitratorsMap := make(map[string]interface{})
	for _, arbitrator := range arbitrators {
		found := false
		for _, pk := range publicKeys {
			if bytes.Equal(arbitrator, pk[1:]) {
				found = true
				break
			}
		}

		if !found {
			return errors.New("invalid cross chain arbitrators")
		}

		arbitratorsMap[common.BytesToHexString(arbitrator)] = nil
	}

	if DefaultLedger.Blockchain.GetHeight()+1 >=
		b.chainParams.CRCOnlyDPOSHeight {
		for _, crc := range DefaultLedger.Arbitrators.GetArbitrators() {
			if _, exist :=
				arbitratorsMap[common.BytesToHexString(crc)]; !exist {
				return errors.New("not all crc arbitrators participated in" +
					" crosschain multi-sign")
			}
		}
	}

	return nil
}

func (b *BlockChain) checkTransferCrossChainAssetTransaction(txn *Transaction, references map[*Input]*Output) error {
	payloadObj, ok := txn.Payload.(*payload.TransferCrossChainAsset)
	if !ok {
		return errors.New("Invalid transfer cross chain asset payload type")
	}
	if len(payloadObj.CrossChainAddresses) == 0 ||
		len(payloadObj.CrossChainAddresses) > len(txn.Outputs) ||
		len(payloadObj.CrossChainAddresses) != len(payloadObj.CrossChainAmounts) ||
		len(payloadObj.CrossChainAmounts) != len(payloadObj.OutputIndexes) {
		return errors.New("Invalid transaction payload content")
	}

	//check cross chain output index in payload
	outputIndexMap := make(map[uint64]struct{})
	for _, outputIndex := range payloadObj.OutputIndexes {
		if _, exist := outputIndexMap[outputIndex]; exist || int(outputIndex) >= len(txn.Outputs) {
			return errors.New("Invalid transaction payload cross chain index")
		}
		outputIndexMap[outputIndex] = struct{}{}
	}

	//check address in outputs and payload
	csAddresses := make(map[string]struct{}, 0)
	for i := 0; i < len(payloadObj.CrossChainAddresses); i++ {
		if _, ok := csAddresses[payloadObj.CrossChainAddresses[i]]; ok {
			return errors.New("duplicated cross chain address in payload")
		}
		csAddresses[payloadObj.CrossChainAddresses[i]] = struct{}{}
		if bytes.Compare(txn.Outputs[payloadObj.OutputIndexes[i]].ProgramHash[0:1], []byte{byte(contract.PrefixCrossChain)}) != 0 {
			return errors.New("Invalid transaction output address, without \"X\" at beginning")
		}
		if payloadObj.CrossChainAddresses[i] == "" {
			return errors.New("Invalid transaction cross chain address ")
		}
	}

	//check cross chain amount in payload
	for i := 0; i < len(payloadObj.CrossChainAmounts); i++ {
		if payloadObj.CrossChainAmounts[i] < 0 || payloadObj.CrossChainAmounts[i] > txn.Outputs[payloadObj.OutputIndexes[i]].Value-common.Fixed64(config.Parameters.MinCrossChainTxFee) {
			return errors.New("Invalid transaction cross chain amount")
		}
	}

	//check transaction fee
	var totalInput common.Fixed64
	for _, v := range references {
		totalInput += v.Value
	}

	var totalOutput common.Fixed64
	for _, output := range txn.Outputs {
		totalOutput += output.Value
	}

	if totalInput-totalOutput < common.Fixed64(config.Parameters.MinCrossChainTxFee) {
		return errors.New("Invalid transaction fee")
	}
	return nil
}

func (b *BlockChain) checkRegisterProducerTransaction(txn *Transaction) error {
	info, ok := txn.Payload.(*payload.ProducerInfo)
	if !ok {
		return errors.New("invalid payload")
	}

	if err := checkStringField(info.NickName, "NickName"); err != nil {
		return err
	}

	// check url
	if err := checkStringField(info.Url, "Url"); err != nil {
		return err
	}

	// check duplication of node.
	if b.state.ProducerExists(info.NodePublicKey) {
		return fmt.Errorf("producer already registered")
	}

	// check duplication of owner.
	if b.state.ProducerExists(info.OwnerPublicKey) {
		return fmt.Errorf("producer owner already registered")
	}

	// check duplication of nickname.
	if b.state.NicknameExists(info.NickName) {
		return fmt.Errorf("nick name %s already inuse", info.NickName)
	}

	// check signature
	publicKey, err := DecodePoint(info.OwnerPublicKey)
	if err != nil {
		return errors.New("invalid public key in payload")
	}
	signedBuf := new(bytes.Buffer)
	err = info.SerializeUnsigned(signedBuf, payload.ProducerInfoVersion)
	if err != nil {
		return err
	}
	err = Verify(*publicKey, signedBuf.Bytes(), info.Signature)
	if err != nil {
		return errors.New("invalid signature in payload")
	}

	// check the deposit coin
	hash, err := contract.PublicKeyToDepositProgramHash(info.OwnerPublicKey)
	if err != nil {
		return errors.New("invalid public key")
	}
	var depositCount int
	for _, output := range txn.Outputs {
		if contract.GetPrefixType(output.ProgramHash) == contract.PrefixDeposit {
			depositCount++
			if !output.ProgramHash.IsEqual(*hash) {
				return errors.New("deposit address does not match the public key in payload")
			}
			if output.Value < MinDepositAmount {
				return errors.New("producer deposit amount is insufficient")
			}
		}
	}
	if depositCount != 1 {
		return errors.New("there must be only one deposit address in outputs")
	}

	return nil
}

func (b *BlockChain) checkProcessProducer(txn *Transaction) (
	*state.Producer, error) {
	processProducer, ok := txn.Payload.(*payload.ProcessProducer)
	if !ok {
		return nil, errors.New("invalid payload")
	}

	// check signature
	publicKey, err := DecodePoint(processProducer.OwnerPublicKey)
	if err != nil {
		return nil, errors.New("invalid public key in payload")
	}
	signedBuf := new(bytes.Buffer)
	err = processProducer.SerializeUnsigned(signedBuf, payload.ProcessProducerVersion)
	if err != nil {
		return nil, err
	}
	err = Verify(*publicKey, signedBuf.Bytes(), processProducer.Signature)
	if err != nil {
		return nil, errors.New("invalid signature in payload")
	}

	producer := b.state.GetProducer(processProducer.OwnerPublicKey)
	if producer == nil {
		return nil, errors.New("getting unknown producer")
	}
	return producer, nil
}

func (b *BlockChain) checkCancelProducerTransaction(txn *Transaction) error {
	producer, err := b.checkProcessProducer(txn)
	if err != nil {
		return err
	}

	if producer.State() == state.FoundBad ||
		producer.State() == state.Canceled {
		return errors.New("can not cancel this producer")
	}

	return nil
}

func (b *BlockChain) checkActivateProducerTransaction(txn *Transaction,
	height uint32) error {
	producer, err := b.checkProcessProducer(txn)
	if err != nil {
		return err
	}

	if producer.State() != state.Inactivate {
		return errors.New("can not activate this producer")
	}

	if height < producer.InactiveSince()+InactiveRecoveringHeightLimit {
		return errors.New("inactive producers should recover after 1 day")
	}

	programHash, err := contract.PublicKeyToDepositProgramHash(
		producer.OwnerPublicKey())
	if err != nil {
		return err
	}

	utxos, err := b.db.GetUnspentFromProgramHash(*programHash, config.ELAAssetID)
	if err != nil {
		return err
	}

	depositAmount := common.Fixed64(0)
	for _, u := range utxos {
		depositAmount += u.Value
	}

	if depositAmount-producer.Penalty() < MinDepositAmount {
		return errors.New("insufficient deposit amount")
	}

	return nil
}

func (b *BlockChain) checkUpdateProducerTransaction(txn *Transaction) error {
	info, ok := txn.Payload.(*payload.ProducerInfo)
	if !ok {
		return errors.New("invalid payload")
	}

	// check nick name
	if err := checkStringField(info.NickName, "NickName"); err != nil {
		return err
	}

	// check url
	if err := checkStringField(info.Url, "Url"); err != nil {
		return err
	}

	// check signature
	publicKey, err := DecodePoint(info.OwnerPublicKey)
	if err != nil {
		return errors.New("invalid public key in payload")
	}
	signedBuf := new(bytes.Buffer)
	err = info.SerializeUnsigned(signedBuf, payload.ProducerInfoVersion)
	if err != nil {
		return err
	}
	err = Verify(*publicKey, signedBuf.Bytes(), info.Signature)
	if err != nil {
		return errors.New("invalid signature in payload")
	}

	producer := b.state.GetProducer(info.OwnerPublicKey)
	if producer == nil {
		return errors.New("updating unknown producer")
	}

	// check nickname usage.
	if producer.Info().NickName != info.NickName &&
		b.state.NicknameExists(info.NickName) {
		return fmt.Errorf("nick name %s already exist", info.NickName)
	}

	// check node public key duplication
	if !bytes.Equal(info.NodePublicKey, producer.Info().NodePublicKey) &&
		b.state.ProducerExists(info.NodePublicKey) {
		return fmt.Errorf("producer %s already exist",
			hex.EncodeToString(info.NodePublicKey))
	}

	return nil
}

func (b *BlockChain) checkReturnDepositCoinTransaction(txn *Transaction,
	references map[*Input]*Output) error {

	var outputValue common.Fixed64
	var inputValue common.Fixed64
	for _, output := range txn.Outputs {
		outputValue += output.Value
	}
	for _, reference := range references {
		inputValue += reference.Value
	}

	var penalty common.Fixed64
	for _, program := range txn.Programs {
		p := b.state.GetProducer(program.Code[1 : len(program.Code)-1])
		if p.State() != state.Canceled {
			return errors.New("producer must be canceled before return deposit coin")
		}
		if b.db.GetHeight()-p.CancelHeight() < DepositLockupBlocks {
			return errors.New("return deposit does not meet the lockup limit")
		}
		penalty += p.Penalty()
	}

	if inputValue-penalty < common.Fixed64(
		config.Parameters.PowConfiguration.MinTxFee)+outputValue {
		return fmt.Errorf("overspend deposit")
	}

	return nil
}

func (b *BlockChain) checkIllegalProposalsTransaction(txn *Transaction) error {
	p, ok := txn.Payload.(*payload.DPOSIllegalProposals)
	if !ok {
		return errors.New("invalid payload")
	}

	if hash := txn.Hash(); b.state.SpecialTxExists(&hash) {
		return errors.New("tx already exists")
	}

	return CheckDPOSIllegalProposals(p)
}

func (b *BlockChain) checkIllegalVotesTransaction(txn *Transaction) error {
	p, ok := txn.Payload.(*payload.DPOSIllegalVotes)
	if !ok {
		return errors.New("invalid payload")
	}

	if hash := txn.Hash(); b.state.SpecialTxExists(&hash) {
		return errors.New("tx already exists")
	}

	return CheckDPOSIllegalVotes(p)
}

func (b *BlockChain) checkIllegalBlocksTransaction(txn *Transaction) error {
	p, ok := txn.Payload.(*payload.DPOSIllegalBlocks)
	if !ok {
		return errors.New("invalid payload")
	}

	if hash := txn.Hash(); b.state.SpecialTxExists(&hash) {
		return errors.New("tx already exists")
	}

	return CheckDPOSIllegalBlocks(p)
}

func (b *BlockChain) checkInactiveArbitratorsTransaction(
	txn *Transaction) error {

	if hash := txn.Hash(); b.state.SpecialTxExists(&hash) {
		return errors.New("tx already exists")
	}

	return CheckInactiveArbitrators(txn, b.chainParams.InactiveEliminateCount)
}

func (b *BlockChain) checkSidechainIllegalEvidenceTransaction(txn *Transaction) error {
	p, ok := txn.Payload.(*payload.SidechainIllegalData)
	if !ok {
		return errors.New("invalid payload")
	}

	if hash := txn.Hash(); b.state.SpecialTxExists(&hash) {
		return errors.New("tx already exists")
	}

	return CheckSidechainIllegalEvidence(p)
}

func CheckSidechainIllegalEvidence(p *payload.SidechainIllegalData) error {

	if p.IllegalType != payload.SidechainIllegalProposal &&
		p.IllegalType != payload.SidechainIllegalVote {
		return errors.New("invalid type")
	}

	_, err := crypto.DecodePoint(p.IllegalSigner)
	if err != nil {
		return err
	}

	_, err = common.Uint168FromAddress(p.GenesisBlockAddress)
	if err != nil {
		return err
	}

	if len(p.Signs) <= int(DefaultLedger.Arbitrators.GetArbitersMajorityCount()) {
		return errors.New("insufficient signs count")
	}

	if p.Evidence.DataHash.Compare(p.CompareEvidence.DataHash) > 0 {
		return errors.New("evidence order error")
	}

	if err := checkSignersInOrder(p.Signs); err != nil {
		return err
	}

	//todo get arbitrators by payload.Height and verify each sign in signs

	return nil
}

func CheckInactiveArbitrators(txn *Transaction,
	inactiveArbitratorsCount uint32) error {
	p, ok := txn.Payload.(*payload.InactiveArbitrators)
	if !ok {
		return errors.New("invalid payload")
	}

	arbitrators := map[string]interface{}{}
	for _, v := range DefaultLedger.Arbitrators.GetArbitrators() {
		arbitrators[common.BytesToHexString(v)] = nil
	}

	if _, exists := arbitrators[common.BytesToHexString(p.Sponsor)]; !exists {
		return errors.New("sponsor is not belong to arbitrators")
	}

	if err := checkSignersInOrder(p.Arbitrators); err != nil {
		return err
	}

	if len(p.Arbitrators) > int(inactiveArbitratorsCount) {
		return errors.New("number of arbitrators must less equal than " +
			strconv.FormatUint(uint64(inactiveArbitratorsCount), 10))
	}
	for _, v := range p.Arbitrators {
		if _, exists := arbitrators[common.BytesToHexString(v)]; !exists {
			return errors.New("inactive arbitrator is not belong to " +
				"arbitrators")
		}
		if DefaultLedger.Arbitrators.IsCRCArbitrator(v) {
			return errors.New("inactive arbiters should not include CRC")
		}
	}

	if err := checkInactiveArbitratorsSignatures(txn.Programs[0],
		arbitrators); err != nil {
		return err
	}

	return nil
}

func checkInactiveArbitratorsSignatures(program *program.Program,
	arbitrators map[string]interface{}) error {

	code := program.Code
	// Get N parameter
	n := int(code[len(code)-2]) - crypto.PUSH1 + 1
	// Get M parameter
	m := int(code[0]) - crypto.PUSH1 + 1

	crcArbitratorsCount := len(arbitrators)
	minSignCount := int(float64(crcArbitratorsCount) * 0.5)
	if m < 1 || m > n || n != crcArbitratorsCount || m <= minSignCount {
		return errors.New("invalid multi sign script code")
	}
	publicKeys, err := crypto.ParseMultisigScript(code)
	if err != nil {
		return err
	}

	for _, pk := range publicKeys {
		if _, exists := arbitrators[common.BytesToHexString(pk)]; !exists {
			return errors.New("invalid multi sign public key")
		}
	}
	return nil
}

func CheckDPOSIllegalProposals(d *payload.DPOSIllegalProposals) error {

	if err := validateProposalEvidence(&d.Evidence); err != nil {
		return err
	}

	if err := validateProposalEvidence(&d.CompareEvidence); err != nil {
		return err
	}

	if d.Evidence.BlockHeight != d.CompareEvidence.BlockHeight {
		return errors.New("should be in same height")
	}

	if d.Evidence.Proposal.Hash().IsEqual(d.CompareEvidence.Proposal.Hash()) {
		return errors.New("proposals can not be same")
	}

	if d.Evidence.Proposal.Hash().String() >
		d.CompareEvidence.Proposal.Hash().String() {
		return errors.New("evidence order error")
	}

	if !bytes.Equal(d.Evidence.Proposal.Sponsor, d.CompareEvidence.Proposal.Sponsor) {
		return errors.New("should be same sponsor")
	}

	if d.Evidence.Proposal.ViewOffset != d.Evidence.Proposal.ViewOffset {
		return errors.New("should in same view")
	}

	if !IsProposalValid(&d.Evidence.Proposal) || !IsProposalValid(&d.Evidence.Proposal) {
		return errors.New("proposal should be valid")
	}

	return nil
}

func CheckDPOSIllegalVotes(d *payload.DPOSIllegalVotes) error {

	if err := validateVoteEvidence(&d.Evidence); err != nil {
		return nil
	}

	if err := validateVoteEvidence(&d.CompareEvidence); err != nil {
		return nil
	}

	if d.Evidence.BlockHeight != d.CompareEvidence.BlockHeight {
		return errors.New("should be in same height")
	}

	if d.Evidence.Vote.Hash().IsEqual(d.CompareEvidence.Vote.Hash()) {
		return errors.New("votes can not be same")
	}

	if d.Evidence.Vote.Hash().String() >
		d.CompareEvidence.Vote.Hash().String() {
		return errors.New("evidence order error")
	}

	if !bytes.Equal(d.Evidence.Vote.Signer, d.CompareEvidence.Vote.Signer) {
		return errors.New("should be same signer")
	}

	if !bytes.Equal(d.Evidence.Proposal.Sponsor, d.CompareEvidence.Proposal.Sponsor) {
		return errors.New("should be same sponsor")
	}

	if d.Evidence.Proposal.ViewOffset != d.CompareEvidence.Proposal.ViewOffset {
		return errors.New("should in same view")
	}

	if !IsProposalValid(&d.Evidence.Proposal) ||
		!IsProposalValid(&d.CompareEvidence.Proposal) ||
		!IsVoteValid(&d.Evidence.Vote) ||
		!IsVoteValid(&d.CompareEvidence.Vote) {
		return errors.New("votes and related proposals should be valid")
	}

	return nil
}

func CheckDPOSIllegalBlocks(d *payload.DPOSIllegalBlocks) error {

	if d.Evidence.BlockHash().IsEqual(d.CompareEvidence.BlockHash()) {
		return errors.New("blocks can not be same")
	}

	if common.BytesToHexString(d.Evidence.Header) >
		common.BytesToHexString(d.CompareEvidence.Header) {
		return errors.New("evidence order error")
	}

	if d.CoinType == payload.ELACoin {
		var err error
		var header, compareHeader *Header
		var confirm, compareConfirm *payload.Confirm

		if header, compareHeader, err = checkDPOSElaIllegalBlockHeaders(d); err != nil {
			return err
		}

		if confirm, compareConfirm, err = checkDPOSElaIllegalBlockConfirms(
			d, header, compareHeader); err != nil {
			return err
		}

		if err := checkDPOSElaIllegalBlockSigners(d, confirm, compareConfirm); err != nil {
			return err
		}
	}

	return nil
}

func checkDPOSElaIllegalBlockSigners(
	d *payload.DPOSIllegalBlocks, confirm *payload.Confirm,
	compareConfirm *payload.Confirm) error {

	signers := d.Evidence.Signers
	if err := checkSignersInOrder(signers); err != nil {
		return err
	}

	compareSigners := d.CompareEvidence.Signers
	if err := checkSignersInOrder(compareSigners); err != nil {
		return err
	}

	if len(signers) <= int(DefaultLedger.Arbitrators.GetArbitersMajorityCount()) ||
		len(compareSigners) <= int(DefaultLedger.Arbitrators.GetArbitersMajorityCount()) {
		return errors.New("signers count less than DPOS required majority" +
			" count")
	}

	arbitratorsSet := make(map[string]interface{})
	for _, v := range DefaultLedger.Arbitrators.GetArbitrators() {
		arbitratorsSet[common.BytesToHexString(v)] = nil
	}

	for _, v := range signers {
		if _, ok := arbitratorsSet[common.BytesToHexString(v)]; !ok {
			return errors.New("invalid signers within evidence")
		}
	}

	for _, v := range compareSigners {
		if _, ok := arbitratorsSet[common.BytesToHexString(v)]; !ok {
			return errors.New("invalid signers within evidence")
		}
	}

	confirmSigners := getConfirmSigners(confirm)
	for _, v := range signers {
		if _, ok := confirmSigners[common.BytesToHexString(v)]; !ok {
			return errors.New("signers and confirm votes do not match")
		}
	}

	compareConfirmSigners := getConfirmSigners(compareConfirm)
	for _, v := range signers {
		if _, ok := compareConfirmSigners[common.BytesToHexString(v)]; !ok {
			return errors.New("signers and confirm votes do not match")
		}
	}

	return nil
}

func checkDPOSElaIllegalBlockConfirms(d *payload.DPOSIllegalBlocks,
	header *Header, compareHeader *Header) (*payload.Confirm,
	*payload.Confirm, error) {

	confirm := &payload.Confirm{}
	compareConfirm := &payload.Confirm{}

	data := new(bytes.Buffer)
	data.Write(d.Evidence.BlockConfirm)
	if err := confirm.Deserialize(data); err != nil {
		return nil, nil, err
	}

	data = new(bytes.Buffer)
	data.Write(d.CompareEvidence.BlockConfirm)
	if err := compareConfirm.Deserialize(data); err != nil {
		return nil, nil, err
	}

	if err := ConfirmSanityCheck(confirm); err != nil {
		return nil, nil, err
	}
	if err := ConfirmContextCheck(confirm); err != nil {
		return nil, nil, err
	}

	if err := ConfirmSanityCheck(compareConfirm); err != nil {
		return nil, nil, err
	}
	if err := ConfirmContextCheck(compareConfirm); err != nil {
		return nil, nil, err
	}

	if confirm.Proposal.ViewOffset != compareConfirm.Proposal.ViewOffset {
		return nil, nil, errors.New("confirm view offset should not be same")
	}

	if !confirm.Proposal.BlockHash.IsEqual(header.Hash()) {
		return nil, nil, errors.New("block and related confirm do not match")
	}

	if !compareConfirm.Proposal.BlockHash.IsEqual(compareHeader.Hash()) {
		return nil, nil, errors.New("block and related confirm do not match")
	}

	return confirm, compareConfirm, nil
}

func checkDPOSElaIllegalBlockHeaders(d *payload.DPOSIllegalBlocks) (*Header,
	*Header, error) {

	header := &Header{}
	compareHeader := &Header{}

	data := new(bytes.Buffer)
	data.Write(d.Evidence.Header)
	if err := header.Deserialize(data); err != nil {
		return nil, nil, err
	}

	data = new(bytes.Buffer)
	data.Write(d.CompareEvidence.Header)
	if err := compareHeader.Deserialize(data); err != nil {
		return nil, nil, err
	}

	if header.Height != d.BlockHeight || compareHeader.Height != d.BlockHeight {
		return nil, nil, errors.New("block data is illegal")
	}

	if header.Height != compareHeader.Height {
		return nil, nil, errors.New("block header height should be same")
	}

	//todo check header content later if needed
	// (there is no need to check headers sanity, because arbiters check these
	// headers already. On the other hand, if arbiters do evil to sign multiple
	// headers that are not valid, normal node shall not attach to the chain.
	// So there is no motivation for them to do this.)

	return header, compareHeader, nil
}

func getConfirmSigners(
	confirm *payload.Confirm) map[string]interface{} {
	result := make(map[string]interface{})
	for _, v := range confirm.Votes {
		result[common.BytesToHexString(v.Signer)] = nil
	}
	return result
}

func checkStringField(rawStr string, field string) error {
	if len(rawStr) == 0 || len(rawStr) > MaxStringLength {
		return fmt.Errorf("Field %s has invalid string length.", field)
	}

	return nil
}

func validateProposalEvidence(evidence *payload.ProposalEvidence) error {

	header := &Header{}
	buf := new(bytes.Buffer)
	buf.Write(evidence.BlockHeader)

	if err := header.Deserialize(buf); err != nil {
		return err
	}

	if header.Height != evidence.BlockHeight {
		return errors.New("evidence height and block height should match")
	}

	if !header.Hash().IsEqual(evidence.Proposal.BlockHash) {
		return errors.New("proposal hash and block should match")
	}

	return nil
}

func validateVoteEvidence(evidence *payload.VoteEvidence) error {
	if err := validateProposalEvidence(&evidence.ProposalEvidence); err != nil {
		return err
	}

	if evidence.Proposal.Hash().IsEqual(evidence.Vote.ProposalHash) {
		return errors.New("vote and proposal should match")
	}

	return nil
}

func checkSignersInOrder(signers [][]byte) error {
	var signersStr []string
	for _, signer := range signers {
		signersStr = append(signersStr, common.BytesToHexString(signer))
	}

	var signersCompare []string
	signersCompare = append(signersCompare, signersStr...)

	sort.Strings(signersStr)

	for i := 0; i < len(signersStr); i++ {
		if signersStr[i] != signersCompare[i] {
			return errors.New("signers have not been ordered")
		}
	}
	return nil
}
