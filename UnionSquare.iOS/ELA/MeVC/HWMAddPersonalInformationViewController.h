//
//  HWMAddPersonalInformationViewController.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/25.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMAddPersonalInformationViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDInfoModel *model;


/*
 *<# #>
 */
@property(assign,nonatomic)Boolean  isEidet;
@property (nonatomic, strong)FLWallet *currentWallet;


@end

NS_ASSUME_NONNULL_END
