//
//  HWMCRRegisteredViewController.h
//  elastos wallet
//
//  Created by  on 2019/8/27.
//

#import <UIKit/UIKit.h>
#import "HWMCRListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMCRRegisteredViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *currentWallet;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isUpdate;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMCRListModel *CRmodel;

/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *lastArray;

@end

NS_ASSUME_NONNULL_END
