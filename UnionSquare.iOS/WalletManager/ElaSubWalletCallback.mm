//
//  ElasubWalletCallback.m
//  elastos wallet
//
//  Created by  on 2019/1/21.
//

#import "ElaSubWalletCallback.h"
#import "ELWalletManager.h"
#include <wchar.h>

NSString *wallID;
//
using namespace Elastos::ElaWallet;

//@implementation ElaSubWalletCallback

ElaSubWalletCallback::ElaSubWalletCallback(const std::string &callBackInfo){
    _callBackInfo=callBackInfo;
}
 ElaSubWalletCallback::~ElaSubWalletCallback(){
    
}
void ElaSubWalletCallback::OnTransactionStatusChanged(
                                                      const std::string &txid,
                                                      const std::string &status,
                                                      const nlohmann::json &desc,
                                                      uint32_t confirms){

//    NSOperationQueue *waitQueue = [[NSOperationQueue alloc] init];
//    [waitQueue addOperationWithBlock:^{
//
//    NSDictionary *dic=@{@"txid":[NSString stringWithUTF8String:txid.c_str()],
//                        @"status":[NSString stringWithUTF8String:status.c_str()],
//                        @"desc":[NSString stringWithUTF8String:desc.dump().c_str()],
//                        };
//    DLog(@"交易金额:  %@",dic);
//        [[NSNotificationCenter defaultCenter] postNotificationName:TransactionStatusChanged object:dic];}];

    
}

//void ElaSubWalletCallback::OnBlockSyncStarted()
//{
//
//}

void ElaSubWalletCallback::OnBlockSyncProgress(const nlohmann::json &progressInfo)
{
    NSString *walletIDString = [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
    NSString *progressInfoString=[NSString stringWithCString:progressInfo.dump().c_str() encoding:NSUTF8StringEncoding];
    NSDictionary *progressInfoDic=[[FLTools share]dictionaryWithJsonString:progressInfoString];
    
    NSString *BytesPerSecond=[NSString stringWithFormat:@"%@",progressInfoDic[@"BytesPerSecond"]];
    NSString *Progress=[NSString stringWithFormat:@"%f",[progressInfoDic[@"Progress"] doubleValue]/100];
    NSString *DownloadPeer=[NSString stringWithFormat:@"%@",progressInfoDic[@"DownloadPeer"]];
    NSString *LastBlockTime=[NSString stringWithFormat:@"%@",progressInfoDic[@"LastBlockTime"]];
      
        NSDictionary *dic=@{@"progress":Progress,@"callBackInfo":walletIDString,@"lastBlockTimeString":LastBlockTime,@"BytesPerSecond":BytesPerSecond,@"DownloadPeer":DownloadPeer};
//        NSLog(@"call回调数据%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:progressBarcallBackInfo object:dic];
}
void ElaSubWalletCallback::OnBalanceChanged(const std::string &asset, const std::string &balance){
    NSString *walletIDString = [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
    
    
    NSString *assetString = [NSString stringWithCString:asset.c_str() encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic=@{@"asset":assetString,@"balance":[NSString stringWithCString:balance.c_str() encoding:NSUTF8StringEncoding],@"callBackInfo":walletIDString};
    
        [[NSNotificationCenter defaultCenter] postNotificationName:AccountBalanceChanges object:dic];
}
void ElaSubWalletCallback::OnTxPublished(const std::string &hash, const nlohmann::json &result)
{
    NSString *hashString = [NSString stringWithCString:hash.c_str() encoding:NSUTF8StringEncoding];
     NSString *resultString = [NSString stringWithCString:result.dump().c_str() encoding:NSUTF8StringEncoding];
    
//    printf(@"s/n%/n",hash.c_str(),result.dump().c_str());
//
//    NSLog(@"hash===%@========详情======%@",hashString ,resultString);
}

/**
 * Callback method fired when block end synchronizing with a peer. This callback could be used to show progress.
 */
void ElaSubWalletCallback::OnAssetRegistered(const std::string &asset, const nlohmann::json &info){
    
    
}
void ElaSubWalletCallback::OnConnectStatusChanged(const std::string &status){
    NSString *walletIDString = [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
    NSDictionary *dic=@{@"status":[NSString stringWithCString:status.c_str() encoding:NSUTF8StringEncoding],@"callBackInfo":walletIDString};
    [[NSNotificationCenter defaultCenter] postNotificationName:ConnectStatusChanged object:dic];
    
}
//@end
