// Copyright (c) 2017-2019 Elastos Foundation
// Use of this source code is governed by an MIT
// license that can be found in the LICENSE file.
//

package wallet

import (
	"sync"

	"github.com/elastos/Elastos.ELA/blockchain"
)

const (
	key             = "utxo"
	dataExtension   = ".ucp"
	savePeriod      = uint32(720)
	effectivePeriod = uint32(720)

	WalletVersion = "0.0.1"
)

var (
	Store blockchain.IChainStore

	addressBook = make(map[string]*AddressInfo, 0)
	abMutex     sync.RWMutex
)

// GetWalletAccount retrieval an address information in wallet by address
func GetWalletAccount(address string) (*AddressInfo, bool) {
	abMutex.RLock()
	defer abMutex.RUnlock()

	addressInfo, exist := addressBook[address]
	return addressInfo, exist
}

// SetWalletAccount set an address information to wallet
func SetWalletAccount(addressInfo *AddressInfo) {
	abMutex.Lock()
	defer abMutex.Unlock()

	addressBook[addressInfo.address] = addressInfo
}
