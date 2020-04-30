//
//  MyUtil.h
//  elastos wallet
//
//  Created by  on 2018/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyUtil : NSObject

+(NSString *)getRootPath;
+(NSString*)DIDRootPath;
+(NSString*)CommDIDPath;
+(BOOL)AddCommDIDWithJWT:(NSString*)fromePath;
+(NSArray*)ReadCommDIDPath;
+(NSString*)readFlieCommDIDWithFlieName:(NSString*)FlieName;
+(BOOL)saveDIDPathWithWalletID:(NSString*)walletID withString:(NSString*)jwtString WithFielName:(NSString*)fielName;
+(NSArray*)ReadDIDPathWithWalletID:(NSString*)walletID;
+(NSString*)jwtPathWithWalletID:(NSString*)walletID withFileName:(NSString*)fileName;
@end

NS_ASSUME_NONNULL_END
