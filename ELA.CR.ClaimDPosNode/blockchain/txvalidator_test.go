package blockchain

import (
	"bytes"
	"crypto/rand"
	"fmt"
	"math"
	"os"
	"testing"

	"github.com/elastos/Elastos.ELA/config"
	"github.com/elastos/Elastos.ELA/core"
	"github.com/elastos/Elastos.ELA/log"

	"github.com/elastos/Elastos.ELA.Utility/common"
	"github.com/stretchr/testify/assert"
)

func init() {
	log.Init(log.Path, os.Stdout)
	foundation, err := common.Uint168FromAddress("8VYXVxKKSAxkmRrfmGpQR2Kc66XhG6m3ta")
	if err != nil {
		log.Error(err)
		os.Exit(-1)
	}
	FoundationAddress = *foundation
	chainStore, err := NewChainStore()
	if err != nil {
		log.Error(err)
		os.Exit(-1)
	}

	err = Init(chainStore)
	if err != nil {
		log.Error(err)
		os.Exit(-1)
	}
}

func TestCheckTransactionSize(t *testing.T) {
	tx := buildTx()
	buf := new(bytes.Buffer)
	err := tx.Serialize(buf)
	if !assert.NoError(t, err) {
		return
	}

	size := tx.GetSize()
	// normal
	config.Parameters.MaxBlockSize = size
	err = CheckTransactionSize(tx)
	assert.NoError(t, err, "[CheckTransactionSize] passed normal size")

	// invalid
	config.Parameters.MaxBlockSize = size - 1
	err = CheckTransactionSize(tx)
	assert.EqualError(t, err, fmt.Sprintf("Invalid transaction size: %d bytes", size))

	t.Log("[TestCheckTransactionSize] PASSED")
}

func TestCheckOutputProgramHash(t *testing.T) {
	programHash := common.Uint168{}

	// empty program hash should pass
	assert.Equal(t, true, CheckOutputProgramHash(programHash))

	// prefix standard program hash should pass
	programHash[0] = common.PrefixStandard
	assert.Equal(t, true, CheckOutputProgramHash(programHash))

	// prefix multisig program hash should pass
	programHash[0] = common.PrefixMultisig
	assert.Equal(t, true, CheckOutputProgramHash(programHash))

	// prefix crosschain program hash should pass
	programHash[0] = common.PrefixCrossChain
	assert.Equal(t, true, CheckOutputProgramHash(programHash))

	// other prefix program hash should not pass
	programHash[0] = 0x34
	assert.Equal(t, false, CheckOutputProgramHash(programHash))

	t.Log("[TestCheckOutputProgramHash] PASSED")
}

func TestCheckTransactionInput(t *testing.T) {
	// coinbase transaction
	tx := NewCoinBaseTransaction(new(core.PayloadCoinBase), 0)
	tx.Inputs[0].Previous.Index = math.MaxUint16
	err := CheckTransactionInput(tx)
	assert.NoError(t, err)

	// invalid coinbase refer index
	tx.Inputs[0].Previous.Index = 0
	err = CheckTransactionInput(tx)
	assert.EqualError(t, err, "invalid coinbase input")

	// invalid coinbase refer id
	tx.Inputs[0].Previous.Index = math.MaxUint16
	rand.Read(tx.Inputs[0].Previous.TxID[:])
	err = CheckTransactionInput(tx)
	assert.EqualError(t, err, "invalid coinbase input")

	// multiple coinbase inputs
	tx.Inputs = append(tx.Inputs, &core.Input{})
	err = CheckTransactionInput(tx)
	assert.EqualError(t, err, "coinbase must has only one input")

	// normal transaction
	tx = buildTx()
	err = CheckTransactionInput(tx)
	assert.NoError(t, err)

	// no inputs
	tx.Inputs = nil
	err = CheckTransactionInput(tx)
	assert.EqualError(t, err, "transaction has no inputs")

	// normal transaction with coinbase input
	tx.Inputs = append(tx.Inputs, &core.Input{Previous: *core.NewOutPoint(common.EmptyHash, math.MaxUint16)})
	err = CheckTransactionInput(tx)
	assert.EqualError(t, err, "invalid transaction input")

	// duplicated inputs
	tx = buildTx()
	tx.Inputs = append(tx.Inputs, tx.Inputs[0])
	err = CheckTransactionInput(tx)
	assert.EqualError(t, err, "duplicated transaction inputs")

	t.Log("[TestCheckTransactionInput] PASSED")
}

func TestCheckTransactionOutput(t *testing.T) {
	// coinbase
	tx := NewCoinBaseTransaction(new(core.PayloadCoinBase), 0)
	tx.Outputs = []*core.Output{
		{AssetID: DefaultLedger.Blockchain.AssetID, ProgramHash: FoundationAddress},
		{AssetID: DefaultLedger.Blockchain.AssetID, ProgramHash: FoundationAddress},
	}
	err := CheckTransactionOutput(core.CheckTxOut, tx)
	assert.NoError(t, err)

	// outputs < 2
	tx.Outputs = []*core.Output{
		{AssetID: DefaultLedger.Blockchain.AssetID, ProgramHash: FoundationAddress},
	}
	err = CheckTransactionOutput(core.CheckTxOut, tx)
	assert.EqualError(t, err, "coinbase output is not enough, at least 2")

	// invalid asset id
	tx.Outputs = []*core.Output{
		{AssetID: common.EmptyHash, ProgramHash: FoundationAddress},
		{AssetID: common.EmptyHash, ProgramHash: FoundationAddress},
	}
	err = CheckTransactionOutput(core.CheckTxOut, tx)
	assert.EqualError(t, err, "asset ID in coinbase is invalid")

	// no output to foundation
	tx.Outputs = []*core.Output{
		{AssetID: DefaultLedger.Blockchain.AssetID, ProgramHash: common.Uint168{}},
		{AssetID: DefaultLedger.Blockchain.AssetID, ProgramHash: common.Uint168{}},
	}
	err = CheckTransactionOutput(core.CheckTxOut, tx)
	assert.EqualError(t, err, "no foundation address in coinbase output")

	// normal transaction
	tx = buildTx()
	for _, output := range tx.Outputs {
		output.AssetID = DefaultLedger.Blockchain.AssetID
		output.ProgramHash = common.Uint168{}
	}
	err = CheckTransactionOutput(core.CheckTxOut, tx)
	assert.NoError(t, err)

	// outputs < 1
	tx.Outputs = nil
	err = CheckTransactionOutput(core.CheckTxOut, tx)
	assert.EqualError(t, err, "transaction has no outputs")

	// invalid asset ID
	tx.Outputs = randomOutputs()
	for _, output := range tx.Outputs {
		output.AssetID = common.EmptyHash
		output.ProgramHash = common.Uint168{}
	}
	err = CheckTransactionOutput(core.CheckTxOut, tx)
	assert.EqualError(t, err, "asset ID in output is invalid")

	// invalid program hash
	tx.Outputs = randomOutputs()
	for _, output := range tx.Outputs {
		output.AssetID = DefaultLedger.Blockchain.AssetID
		address := common.Uint168{}
		address[0] = 0x23
		output.ProgramHash = address
	}
	err = CheckTransactionOutput(core.CheckTxOut, tx)
	assert.EqualError(t, err, "output address is invalid")

	t.Log("[TestCheckTransactionOutput] PASSED")
}

func TestCheckAssetPrecision(t *testing.T) {
	// normal transaction
	tx := buildTx()
	for _, output := range tx.Outputs {
		output.AssetID = DefaultLedger.Blockchain.AssetID
		output.ProgramHash = common.Uint168{}
	}
	err := CheckAssetPrecision(tx)
	assert.NoError(t, err)

	// asset not exist
	for _, output := range tx.Outputs {
		output.AssetID = common.EmptyHash
		output.ProgramHash = common.Uint168{}
	}
	err = CheckAssetPrecision(tx)
	assert.EqualError(t, err, "The asset not exist in local blockchain.")

	// precision check
	for i := 8; i >= 0; i-- {
		amount := common.Fixed64(math.Pow(10, float64(i)))
		t.Logf("Amount %s", amount.String())
		assert.Equal(t, true, checkAmountPrecise(amount, byte(8-i)))
		assert.Equal(t, false, checkAmountPrecise(amount, byte(8-i-1)))
	}

	t.Log("[TestCheckAssetPrecision] PASSED")
}

func TestCheckAttributeProgram(t *testing.T) {
	// Fixme method not implemented
	t.Log("[TestCheckAttributeProgram] PASSED")
}

func TestCheckTransactionPayload(t *testing.T) {
	// normal
	tx := new(core.Transaction)
	payload := &core.PayloadRegisterAsset{
		Asset: core.Asset{
			Name:      "ELA",
			Precision: 0x08,
			AssetType: core.Token,
		},
		Amount: 3300 * 10000 * 10000000,
	}
	tx.Payload = payload
	err := CheckTransactionPayload(tx)
	assert.NoError(t, err)

	// invalid precision
	payload.Asset.Precision = 9
	err = CheckTransactionPayload(tx)
	assert.EqualError(t, err, "Invalide asset Precision.")

	// invalid amount
	payload.Asset.Precision = 0
	payload.Amount = 1234567
	err = CheckTransactionPayload(tx)
	assert.EqualError(t, err, "Invalide asset value,out of precise.")

	t.Log("[TestCheckTransactionPayload] PASSED")
}

func TestCheckDuplicateSidechainTx(t *testing.T) {
	// 1. Generate the ill withdraw transaction which have duplicate sidechain tx
	txn := new(core.Transaction)
	txn.TxType = core.WithdrawFromSideChain
	txn.Payload = &core.PayloadWithdrawFromSideChain{
		BlockHeight:         100,
		GenesisBlockAddress: "eb7adb1fea0dd6185b09a43bdcd4924bb22bff7151f0b1b4e08699840ab1384b",
		SideChainTransactionHash: []string{
			"8a6cb4b5ff1a4f8368c6513a536c663381e3fdeff738e9b437bd8fce3fb30b62",
			"cc62e14f5f9526b7f4ff9d34dcd0643dacb7886707c57f49ec97b95ec5c4edac",
			"8a6cb4b5ff1a4f8368c6513a536c663381e3fdeff738e9b437bd8fce3fb30b62", // duplicate tx hash
		},
	}

	// 2. Run CheckDuplicateSidechainTx
	err := CheckDuplicateSidechainTx(txn)
	assert.EqualError(t, err, "Duplicate sidechain tx detected in a transaction")

	t.Log("[TestCheckDuplicateSidechainTx] PASSED")
}
