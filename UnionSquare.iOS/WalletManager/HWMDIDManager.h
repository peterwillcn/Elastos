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
    
//    NSString *rootPath;
}
+(instancetype)shareDIDManager;
@property(copy,nonatomic)NSString *passWord;
@property(copy,nonatomic)NSString *DIDString;
@property(copy,nonatomic)NSString *TheMnemonicWordString;
@property(copy,nonatomic)NSString *privatekeyString;
@property(copy,nonatomic)NSString *mastWalletID;
-(void)copyDirToSharedDir;
-(BOOL)saveDir;
-(NSString*)hasDIDWithPWD:(NSString *)passWord withDIDString:(NSString*)DIDString
WithPrivatekeyString:(NSString*)privatekeyString
         WithmastWalletID:(NSString*)mastWalletID;
-(NSDictionary*)getDIDInfo;
-(BOOL)updateInfoWithInfo:(HWMDIDInfoModel*)model;
-(id)jwtDecodeWithJwtStringInfo:(NSString *)jwtStr;
-(NSString*)PKWith:(const char*)pk58;
-(NSString*)DIDSignatureWithString:(NSString*)sigString;
-(BOOL)saveDIDCredentialWithDIDModel:(HWMDIDInfoModel*)model;
-(HWMDIDInfoModel*)readDIDCredential;
-(bool)CheckDIDwhetherExpiredWithDIDString:(NSString*)didString WithmastWalletID:(NSString*)walletID;
@end

NS_ASSUME_NONNULL_END
