//
//  HWMDIDManager.h
//  elastos wallet
//
//  Created by  on 2020/2/18.
//

#import <Foundation/Foundation.h>
#import "MyUtil.h"
#include "ela_did.h"
#include "HDkey.h"
#include "crypto.h"
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDManager : NSObject{
    
    NSString *rootPath;
}
+(instancetype)shareDIDManager;
-(void)copyDirToSharedDir;
-(BOOL)saveDir;
-(BOOL)initDIDWithPWD:(NSString *)passWord withDIDString:(NSString*)DIDString
WithPrivatekeyString:(NSString*)privatekeyString
     WithmastWalletID:(NSString*)mastWalletID;
-(void)getDIDInfo;
-(BOOL)updateInfoWithInfo:(HWMDIDInfoModel*)model;
@property(copy,nonatomic)NSString *passWord;
@property(copy,nonatomic)NSString *DIDString;
@property(copy,nonatomic)NSString *TheMnemonicWordString;
@property(copy,nonatomic)NSString *privatekeyString;
@property(copy,nonatomic)NSString *mastWalletID;

@end

NS_ASSUME_NONNULL_END
