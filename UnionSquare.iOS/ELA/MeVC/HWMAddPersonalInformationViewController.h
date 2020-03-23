//
//  HWMAddPersonalInformationViewController.h
//  elastos wallet
//
//  Created by  on 2019/10/25.
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
/*
 *<# #>
 */
@property(assign,nonatomic)Boolean  whereFrome;
@property (nonatomic, strong)FLWallet *currentWallet;


@end

NS_ASSUME_NONNULL_END
