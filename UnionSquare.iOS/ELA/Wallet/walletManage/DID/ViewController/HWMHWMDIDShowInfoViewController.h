//
//  HWMHWMDIDShowInfoViewController.h
//  elastos wallet
//
//  Created by  on 2020/2/14.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWMHWMDIDShowInfoViewController : UIViewController
@property(strong,nonatomic)HWMDIDInfoModel *model;
@property(assign,nonatomic)BOOL isEi;
@property (nonatomic, strong)FLWallet *currentWallet;
@end

NS_ASSUME_NONNULL_END
