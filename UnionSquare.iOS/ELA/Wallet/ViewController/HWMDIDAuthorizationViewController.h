//
//  HWMDIDAuthorizationViewController.h
//  elastos wallet
//
//  Created by  on 2020/3/16.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HWMDIDAuthorizationViewControllerDelegate <NSObject>

-(void)needUploadJWTInfo;

@end
@interface HWMDIDAuthorizationViewController : UIViewController
@property(copy,nonatomic)NSString *mastWalletID;

@property(copy,nonatomic)NSString *DIDString;
@property(copy,nonatomic)NSDictionary *CRInfoDic;
@property(copy,nonatomic)NSString *JWTString;
@property(assign,nonatomic)BOOL MemberOfTheUpdate;
@property(strong,nonatomic)HWMDIDInfoModel *readModel;
@property(weak,nonatomic)id<HWMDIDAuthorizationViewControllerDelegate> delegate;

@property(strong,nonatomic) NSString *nickNameString;
@end

NS_ASSUME_NONNULL_END
