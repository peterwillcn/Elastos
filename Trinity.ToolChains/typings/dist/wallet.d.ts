/*
* Copyright :(c) 2018-2020 Elastos Foundation
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files :(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

/**
* This is about Wallet which can only be used by wallet application by default.
* However, you can change this by editing the group.json correctly.
* <br><br>
* Please use 'Wallet' as the plugin name in the manifest.json if you want to use
* this facility. Additionally, you need to make sure you have permission(granted
* in the group.json) to use it.
* <br><br>
* Usage:
* <br>
* declare let walletManager: WalletPlugin.WalletManager;
*/

declare module WalletPlugin {
    interface WalletManager {
        // TODO: define types for all arguments and callback parameters
        print:(args, success, error)=>void;
        recoverWallet:(args, success, error)=>void;
        createWallet:(args, success, error)=>void; 
        start:(args, success, error)=>void; 
        stop:(args, success, error)=>void; 
        createSubWallet:(args, success, error)=>void; 
        recoverSubWallet:(args, success, error)=>void;
        createMasterWallet:(args, success, error)=>void;
        importWalletWithKeystore:(args, success, error)=>void;
        importWalletWithMnemonic:(args, success, error)=>void;
        exportWalletWithKeystore:(args, success, error)=>void;
        exportWalletWithMnemonic:(args, success, error)=>void;
        getBalanceInfo:(args, success, error)=>void;
        getBalance:(args, success, error)=>void;
        createAddress:(args, success, error)=>void; 
        getAllAddress:(args, success, error)=>void;
        getBalanceWithAddress:(args, success, error)=>void;
        generateMultiSignTransaction:(args, success, error)=>void;
        createMultiSignAddress:(args, success, error)=>void;
        getAllTransaction:(args, success, error)=>void;
        sign:(args, success, error)=>void;
        checkSign:(args, success, error)=>void;
        deriveIdAndKeyForPurpose:(args, success, error)=>void; 
        getAllMasterWallets:(args, success, error)=>void;
        registerWalletListener:(args, success, error)=>void;
        isAddressValid:(args, success, error)=>void; 
        generateMnemonic:(args, success, error)=>void;
        getWalletId:(args, success, error)=>void;
        getAllChainIds:(args, success, error)=>void;
        getSupportedChains:(args, success, error)=>void;
        getAllSubWallets:(args, success, error)=>void;
        changePassword:(args, success, error)=>void;
        sendRawTransaction:(args, success, error)=>void;
        createTransaction:(args, success, error)=>void;
        createDID:(args, success, error)=>void;
        getDIDList:(args, success, error)=>void;
        destoryDID:(args, success, error)=>void;
        didSetValue:(args, success, error)=>void;
        didGetValue:(args, success, error)=>void;
        didGetHistoryValue:(args, success, error)=>void;
        didGetAllKeys:(args, success, error)=>void;
        didSign:(args, success, error)=>void;
        didCheckSign:(args, success, error)=>void;
        didGetPublicKey:(args, success, error)=>void;
        destroyWallet:(args, success, error)=>void; 
        createIdTransaction:(args, success, error)=>void;
        createDepositTransaction:(args, success, error)=>void;
        createWithdrawTransaction:(args, success, error)=>void;
        getGenesisAddress:(args, success, error)=>void;
        didGenerateProgram:(args, success, error)=>void;
        getAllCreatedSubWallets:(args, success, error)=>void;
        createMultiSignMasterWalletWithPrivKey:(args, success, error)=>void;
        createMultiSignMasterWallet:(args, success, error)=>void;
        getMasterWalletBasicInfo:(args, success, error)=>void;
        signTransaction:(args, success, error)=>void;
        publishTransaction:(args, success, error)=>void;
        getMasterWalletPublicKey:(args, success, error)=>void;
        getSubWalletPublicKey:(args, success, error)=>void;
        createMultiSignMasterWalletWithMnemonic:(args, success, error)=>void;
        removeWalletListener:(args, success, error)=>void; 
        disposeNative:(args, success, error)=>void;
        getMultiSignPubKeyWithMnemonic:(args, success, error)=>void;
        getMultiSignPubKeyWithPrivKey:(args, success, error)=>void;
        getTransactionSignedSigners:(args, success, error)=>void;
        importWalletWithOldKeystore:(args, success, error)=>void;
        getVersion:(args, success, error)=>void;
        destroySubWallet:(args, success, error)=>void;
        getVotedProducerList:(args, success, error)=>void;
        createVoteProducerTransaction:(args, success, error)=>void;
        createCancelProducerTransaction:(args, success, error)=>void;
        getRegisteredProducerInfo:(args, success, error)=>void; 
        createRegisterProducerTransaction:(args, success, error)=>void;
        generateProducerPayload:(args, success, error)=>void;
        generateCancelProducerPayload:(args, success, error)=>void;
        getPublicKeyForVote:(args, success, error)=>void;
        createRetrieveDepositTransaction:(args, success, error)=>void;
        createUpdateProducerTransaction:(args, success, error)=>void;
    }
}