//
//  HWMDIDAdapter.h
//  elastos wallet
//
//  Created by 韩铭文 on 2020/3/3.
//

#import <Foundation/Foundation.h>
#import "MyUtil.h"
#import "IMasterWallet.h"
#import "IDidManager.h"
#import "DIDManagerSupervisor.h"
#import "MasterWalletManager.h"
#import "ISidechainSubWallet.h"
#import "IMainchainSubWallet.h"
#import "IIdChainSubWallet.h"
#import "IDidManager.h"
#import "idid.h"
#import <string.h>
#import <map>
#import "ElaSubWalletCallback.h"
#import "FLJoinVoteInfoModel.h"
#import "PluginResult.h"
#import "invokedUrlCommand.h"


NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDAdapter : NSObject{
    
}

-(void)DIDAdapter_CreateWith:(NSString*)walletDir withwalletId:(NSString*)walletId;
@end

NS_ASSUME_NONNULL_END
