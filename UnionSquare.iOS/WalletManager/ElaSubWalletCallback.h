//
//  ElaSubWalletCallback.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/1/21.
//

#import <UIKit/UIKit.h>
#include <stdint.h>
#include "json.hpp"
#include "string"
#import "ISubWalletCallback.h"
NS_ASSUME_NONNULL_BEGIN
namespace Elastos {
    namespace ElaWallet {class ElaSubWalletCallback : public  ISubWalletCallback {
    public:
        
        void OnTransactionStatusChanged( const std::string &txid,
                                        const std::string &status,
                                        const nlohmann::json &desc,
                                        uint32_t confirms);
        
        /**
         * Callback method fired when block begin synchronizing with a peer. This callback could be used to show progress.
         */
        void OnBlockSyncStarted();
        
        /**
         * Callback method fired when best block chain height increased. This callback could be used to show progress.
         * @param currentBlockHeight is the of current block when callback fired.
         * @param estimatedHeight is max height of blockchain.
         */
        void OnBlockSyncProgress(uint32_t currentBlockHeight, uint32_t estimatedHeight, time_t lastBlockTime);
        
        /**
         * Callback method fired when block end synchronizing with a peer. This callback could be used to show progress.
         */
        void OnBlockSyncStopped();
        
        void OnBalanceChanged(const std::string &asset, uint64_t balance);
        
        void OnTxPublished(const std::string &hash, const nlohmann::json &result);
        
        void OnTxDeleted(const std::string &hash, bool notifyUser, bool recommendRescan);
        ElaSubWalletCallback(const std::string &callBackInfo);
        
        ~ElaSubWalletCallback();
    private:
        std::string _callBackInfo;
        
        
    };
        
        
    }
    
}
NS_ASSUME_NONNULL_END
