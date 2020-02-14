//
//  HWMShowSocialAccountViewController.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/11/8.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMShowSocialAccountViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDInfoModel *model;
/*
 *<# #>
 */
@property(assign,nonatomic)Boolean  isEidet;
@end

NS_ASSUME_NONNULL_END
