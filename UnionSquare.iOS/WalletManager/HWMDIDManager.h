//
//  HWMDIDManager.h
//  elastos wallet
//
//  Created by  on 2020/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDManager : NSObject{
    NSString *rootPath;
}
+(instancetype)shareDIDManager;
-(void)copyDirToSharedDir;
-(BOOL)saveDir;
@property(copy,nonatomic)NSString *passWord;
@property(copy,nonatomic)NSString *DIDString;
@property(copy,nonatomic)NSString *TheMnemonicWordString;
@property(copy,nonatomic)NSString *privatekeyString;
@property(copy,nonatomic)NSString *mastWalletID;

@end

NS_ASSUME_NONNULL_END
