//
//  ElaSubWalletCallback.h
//  elastos wallet
//
//  Created by  on 2019/1/21.
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
        
        void OnTransactionStatusChanged(
                                                const std::string &txid,
                                                const std::string &status,
                                                const nlohmann::json &desc,
                                                uint32_t confirms);
        
//        /**
//         * Callback method fired when block begin synchronizing with a peer. This callback could be used to show progress.
//         */
//        void OnBlockSyncStarted();
        
        /**
         * Callback method fired when best block chain height increased. This callback could be used to show progress.
         * @param progressInfo progress info contain detail as below:
         * {
         *     "Progress": 50,                    # 0% ~ 100%
         *     "BytesPerSecond": 12345678,        # 12.345678 MByte / s
         *     "LastBlockTime": 1573799697,       # timestamp of last block
         *     "DownloadPeer": "127.0.0.1"        # IP address of node
         * }
         */
         void OnBlockSyncProgress(const nlohmann::json &progressInfo);
//        
//        /**
//         * Callback method fired when block end synchronizing with a peer. This callback could be used to show progress.
//         */
//         void OnBlockSyncStopped();
        
        /**
         * Callback method fired when balance changed.
         * @param asset ID.
         * @param balance after changed.
         */
        void OnBalanceChanged(const std::string &asset, const std::string &balance);
        
        /**
         * Callback method fired when tx published.
         * @param hash of published tx.
         * @param result in json format.
         */
         void OnTxPublished(const std::string &hash, const nlohmann::json &result);
        
        /**
         * Callback method fired when a new asset registered.
         * @param asset ID.
         * @param information of asset.
         */
        void OnAssetRegistered(const std::string &asset, const nlohmann::json &info);
        void OnConnectStatusChanged(const std::string &status);
        ElaSubWalletCallback(const std::string &callBackInfo);
        
        ~ElaSubWalletCallback();
    private:
        std::string _callBackInfo;
        
        
    };
        
        
    }
    
}
NS_ASSUME_NONNULL_END
