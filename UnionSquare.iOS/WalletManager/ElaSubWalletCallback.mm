//
//  ElasubWalletCallback.m
//  elastos wallet
//
//  Created by  on 2019/1/21.
//

#import "ElaSubWalletCallback.h"
#import "ELWalletManager.h"
#include <wchar.h>
#import "HWMMessageCenterModel.h"
#import "HMWFMDBManager.h"


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
    NSString *txidString=[NSString stringWithUTF8String:txid.c_str()];
    //    NSDictionary *dic=@{@"txid":txidString,
    //                        @"status":[NSString stringWithUTF8String:status.c_str()],
    //                        @"desc":[NSString stringWithUTF8String:desc.dump().c_str()],@"desc":[NSString stringWithUTF8String:desc.dump().c_str()],
    //                        @"confirms":@(confirms)
    //    };
//    if (confirms!=0) {
//
//        NSString *walletInfo= [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
//        NSArray *infoArray=[[FLTools share]stringToArray:walletInfo];
//        NSString *walletID=infoArray.firstObject;
//        NSString *chainID=infoArray[1];
//        HWMMessageCenterModel *model =[[HWMMessageCenterModel alloc]init];
//        model.walletID= walletID;
//        model.chainID=chainID;
//        model.typeHash=txidString;
//        HWMMessageCenterModel *almodel=[[HMWFMDBManager sharedManagerType:transactionsType]selectTransactionsWithModel:model];
//        if ([almodel.MessageType isEqualToString:@"1001"]) {
//            model.MessageC=@"由于交易金额不足,您的CR委员选举投票已失效";
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[FLTools share]showNeMessageWith:model];
//            });
//        }else if ([almodel.MessageType isEqualToString:@"1002"]){
//             model.MessageC=@"由于交易金额不足,您的超级节点选举投票已失效";
//
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                [[FLTools share]showNeMessageWith:model];
//            });
//        }
        
//    }
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
    [[NSNotificationCenter defaultCenter] postNotificationName:progressBarcallBackInfo object:dic];
}
void ElaSubWalletCallback::OnBalanceChanged(const std::string &asset, const std::string &balance){
    NSString *walletIDString = [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
    NSString *assetString = [NSString stringWithCString:asset.c_str() encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic=@{@"asset":assetString,@"balance":[NSString stringWithCString:balance.c_str() encoding:NSUTF8StringEncoding],@"callBackInfo":walletIDString};
    [[NSNotificationCenter defaultCenter] postNotificationName:AccountBalanceChanges object:dic];
}

//xxl #943
void ElaSubWalletCallback::OnTxPublished(const std::string &hash, const nlohmann::json &result)
{
    NSString *hashString = [NSString stringWithCString:hash.c_str() encoding:NSUTF8StringEncoding];
    NSString *resultString = [NSString stringWithCString:result.dump().c_str() encoding:NSUTF8StringEncoding];
    
    NSLog(@"xxl 943 1 ElaSubWalletCallback " );
    NSDictionary *dic=[[FLTools share]dictionaryWithJsonString:resultString];
    NSLog(@"%@",dic);
    if (dic) {
        int code= [dic[@"Code"] intValue];
        //if (code==0||(code==18&& [dic[@"Reason"] isEqualToString:@"uplicate"])){
        if (code==0 && [dic[@"Reason"] isEqualToString:@"success"]){
            NSLog(@"xxl 943 1 OK ElaSubWalletCallback %@",dic);
            [[NSNotificationCenter defaultCenter] postNotificationName:OnTxPublishedResult object:dic];

        }else if(code != 0){
            NSLog(@"xxl 943 1 error ElaSubWalletCallback %@",dic);
            
            NSString *walletInfo= [NSString stringWithCString:_callBackInfo.c_str() encoding:NSUTF8StringEncoding];
            NSArray *infoArray=[[FLTools share]stringToArray:walletInfo];
            NSString *walletID=infoArray.firstObject;
            NSString *chainID=infoArray[1];
            HWMMessageCenterModel *model =[[HWMMessageCenterModel alloc]init];
            model.walletID= walletID;
            model.chainID=chainID;
            model.MessageC=@"交易错误，无法上链";
            model.typeHash=hashString;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[FLTools share]showNeMessageWith:model];
            });
        }

    }
    
    
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
