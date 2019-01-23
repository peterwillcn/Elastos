package protocol

import (
	"fmt"
	"net"
	"time"

	"github.com/elastos/Elastos.ELA/bloom"
	"github.com/elastos/Elastos.ELA/common"
	"github.com/elastos/Elastos.ELA/core/types"
	"github.com/elastos/Elastos.ELA/errors"
	"github.com/elastos/Elastos.ELA/p2p"
	"github.com/elastos/Elastos.ELA/p2p/msg"
)

const (
	ProtocolVersion    = 0
	HandshakeTimeout   = 8
	MinConnectionCount = 3
	MaxSyncHdrReq      = 2 //Max Concurrent Sync Header Request
	MaxOutBoundCount   = 8
	DefaultMaxPeers    = 125
	MaxIDCached        = 5000
)

const (
	// FlagNode indicates node is a full node.
	FlagNode = 1

	OpenService = 1 << 2
)

type State int32

const (
	INIT State = iota
	HAND
	HANDSHAKE
	HANDSHAKED
	ESTABLISHED
	INACTIVITY
)

var States = map[State]string{
	INIT:        "INIT",
	HAND:        "HAND",
	HANDSHAKE:   "HANDSHAKE",
	HANDSHAKED:  "HANDSHAKED",
	ESTABLISHED: "ESTABLISHED",
	INACTIVITY:  "INACTIVITY",
}

func (s State) String() string {
	state, ok := States[s]
	if ok {
		return state
	}
	return fmt.Sprintf("STATE%d", s)
}

type TxnPoolListener interface {
	OnIllegalBlockTxnReceived(txn *types.Transaction)
}

// Handler is the P2P message handler interface.
type Handler interface {
	MakeEmptyMessage(cmd string) (p2p.Message, error)
	HandleMessage(message p2p.Message)
}

type Noder interface {
	Version() uint32
	ID() uint64
	Services() uint64
	Addr() string
	IP() net.IP
	NetAddress() *p2p.NetAddress
	SetNAFilter(filter p2p.NAFilter)
	NAFilter() p2p.NAFilter
	Port() uint16
	IsExternal() bool
	HttpInfoPort() int
	SetHttpInfoPort(uint16)
	SetState(state State)
	State() State
	IsRelay() bool
	IsCurrent() bool
	AddNeighborNode(Noder)
	DelNeighborNode(id uint64) (Noder, bool)
	Height() uint64
	GetConn() net.Conn
	Connected() bool
	Disconnect()
	AddToHandshakeQueue(addr string, node Noder)
	RemoveFromHandshakeQueue(node Noder)
	GetConnectionCount() (uint, uint)
	GetTransactionPool(bool) map[common.Uint256]*types.Transaction
	AppendToTxnPool(*types.Transaction) errors.ErrCode
	RegisterTxPoolListener(listener TxnPoolListener)
	UnregisterTxPoolListener(listener TxnPoolListener)
	IsDuplicateSidechainTx(sidechainTxHash common.Uint256) bool
	ExistedID(id common.Uint256) bool
	RequireNeighbourList()
	UpdateInfo(t time.Time, version uint32, services uint64,
		port uint16, nonce uint64, relay bool, height uint64)
	UpdateHandler(handler Handler)
	ConnectNodes()
	Connect(nodeAddr string) error
	LoadFilter(filter *msg.FilterLoad)
	BloomFilter() *bloom.Filter
	SendMessage(msg p2p.Message)
	NodeEstablished(uid uint64) bool
	GetTransaction(hash common.Uint256) *types.Transaction
	IncRxTxnCnt()
	GetTxnCnt() uint64
	GetRxTxnCnt() uint64

	GetNeighborNodes() []Noder
	GetNeighbourAddresses() []*p2p.NetAddress

	WaitForSyncFinish(interrupt <-chan struct{})
	CleanSubmittedTransactions(block *types.Block) error
	MaybeAcceptTransaction(txn *types.Transaction) error
	RemoveTransaction(txn *types.Transaction)

	SetHeight(height uint64)
	SetLastActive(now time.Time)
	GetLastActive() time.Time
	Relay(Noder, interface{}) error
	IsSyncHeaders() bool
	SetSyncHeaders(b bool)
	IsRequestedBlock(hash common.Uint256) bool
	AddRequestedBlock(hash common.Uint256)
	DeleteRequestedBlock(hash common.Uint256)
	GetRequestBlockList() map[common.Uint256]time.Time
	AcqSyncBlkReqSem()
	RelSyncBlkReqSem()
	SetStartHash(hash common.Uint256)
	GetStartHash() common.Uint256
	SetStopHash(hash common.Uint256)
	GetStopHash() common.Uint256
	ResetRequestedBlock()
}
