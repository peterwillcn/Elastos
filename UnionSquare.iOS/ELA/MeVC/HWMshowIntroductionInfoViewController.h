//
//  HWMshowIntroductionInfoViewController.h
//  elastos wallet
//
//  Created by  on 2019/11/8.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HWMshowIntroductionInfoViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDInfoModel *model;
@property(atomic,copy)NSString *walletID;
@end

NS_ASSUME_NONNULL_END
