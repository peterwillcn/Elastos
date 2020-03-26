//
//  HWMDIDInfoViewController.h
//  elastos wallet
//
//  Created by  on 2019/10/30.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"



@protocol HWMDIDInfoViewControllerDelegate <NSObject>

-(void)needUpdateDIDInfo;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDInfoViewController : UIViewController
@property(strong,nonatomic)HWMDIDInfoModel *model;
@property(weak,nonatomic)id<HWMDIDInfoViewControllerDelegate>delegate;
@property (nonatomic, strong)FLWallet *currentWallet;

@end

NS_ASSUME_NONNULL_END
