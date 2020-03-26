//
//  HWMAddPersonalProfileViewController.h
//  elastos wallet
//
//  Created by  on 2019/10/28.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^block)(HWMDIDInfoModel *model);

@interface HWMAddPersonalProfileViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDInfoModel *model;

/*
 *<# #>
 */
@property(assign,nonatomic)Boolean  isEidet;
@property(atomic,copy)NSString *walletID;
@property(copy,nonatomic) void(^block)(HWMDIDInfoModel *model);

@end

NS_ASSUME_NONNULL_END
