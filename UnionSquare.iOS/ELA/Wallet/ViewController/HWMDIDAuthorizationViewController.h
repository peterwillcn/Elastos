//
//  HWMDIDAuthorizationViewController.h
//  elastos wallet
//
//  Created by  on 2020/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDAuthorizationViewController : UIViewController
@property(copy,nonatomic)NSString *mastWalletID;

@property(copy,nonatomic)NSString *DIDString;
@property(copy,nonatomic)NSDictionary *CRInfoDic;
@property(copy,nonatomic)NSString *JWTString;


@end

NS_ASSUME_NONNULL_END
