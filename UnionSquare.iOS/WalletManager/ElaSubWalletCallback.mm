//
//  ElasubWalletCallback.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/1/21.
//

#import "ElaSubWalletCallback.h"
#import "ELWalletManager.h"
#include <wchar.h>

NSString *wallID;
//
using namespace Elastos::ElaWallet;

//@implementation ElaSubWalletCallback

ElaSubWalletCallback::ElaSubWalletCallback(const std::string &callBackInfo)
{
    
    //    NSString *string=@"";
    _callBackInfo=callBackInfo;
    
    //    wallID=[NSS]walletID;
}

ElaSubWalletCallback::~ElaSubWalletCallback()
{
    
}
void ElaSubWalletCallback:: OnTransactionStatusChanged( const std::string &txid,
                                                       const std::string &status,
                                                       const nlohmann::json &desc,
                                                       uint32_t confirms){

    NSDictionary *dic=@{@"txid":[NSString stringWithUTF8String:txid.c_str()],
                        @"status":[NSString stringWithUTF8String:status.c_str()],
                        @"desc":[NSString stringWithUTF8String:desc.dump().c_str()],
                        };
    DLog(@"交易金额:  %@",dic);
    [[NSNotificationCenter defaultCenter] postNotificationName:TransactionStatusChanged object:dic];

    
}

void ElaSubWalletCallback::OnBlockSyncStarted()
{
    
}

void ElaSubWalletCallback::OnBlockSyncProgress(uint32_t currentBlockHeight, uint32_t estimatedHeight, time_t lastBlockTime)
{
    NSString *walletIDString = [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
    
    NSString *lastBlockTimeString =[NSString stringWithFormat:@"%ld",lastBlockTime];
        NSString *YYMMSS =[[FLTools share]YMDHMSgetTimeFromTimesTamp:lastBlockTimeString];
    NSDictionary *dic=@{@"currentBlockHeight":@(currentBlockHeight),@"progress":@(estimatedHeight),@"callBackInfo":walletIDString,@"lastBlockTimeString":YYMMSS};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:progressBarcallBackInfo object:dic];
}

void ElaSubWalletCallback::OnBlockSyncStopped()
{
    
}

void ElaSubWalletCallback::OnTxPublished(const std::string &hash, const nlohmann::json &result)
{
    
    NSString *hash1 = [NSString stringWithCString:hash.c_str() encoding:NSUTF8StringEncoding];
    NSString *resultString = [NSString stringWithCString:result.dump().c_str() encoding:NSUTF8StringEncoding];
    NSDictionary *dic=@{@"hash":hash1,@"result":resultString};

    [[NSNotificationCenter defaultCenter] postNotificationName:OnTxPublishedResult object:dic];

}

void ElaSubWalletCallback::OnTxDeleted(const std::string &hash, bool notifyUser, bool recommendRescan)
{
    
    
}
/**
 * Callback method fired when block end synchronizing with a peer. This callback could be used to show progress.
 */

void ElaSubWalletCallback:: OnBalanceChanged(const std::string &asset, uint64_t balance)
{
    
    
    NSString *walletIDString = [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
    
    
       NSString *assetString = [NSString stringWithCString:asset.c_str() encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic=@{@"asset":assetString,@"balance":@(balance),@"callBackInfo":walletIDString};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AccountBalanceChanges object:dic];
    
    
    
    
}
//@end
