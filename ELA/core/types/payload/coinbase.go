package payload

import (
	"io"

	"github.com/elastos/Elastos.ELA/common"
)

const (
	// MaxPayloadDataSize is the maximum allowed length of payload data.
	MaxCoinbasePayloadDataSize = 1024 * 1024 // 1MB
)

const CoinBaseVersion byte = 0x04

type CoinBase struct {
	Content []byte
}

func (a *CoinBase) Data(version byte) []byte {
	return a.Content
}

func (a *CoinBase) Serialize(w io.Writer, version byte) error {
	return common.WriteVarBytes(w, a.Content)
}

func (a *CoinBase) Deserialize(r io.Reader, version byte) error {
	temp, err := common.ReadVarBytes(r, MaxCoinbasePayloadDataSize,
		"payload coinbase data")
	a.Content = temp
	return err
}
