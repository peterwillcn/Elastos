//
//  HMWnodeInformationViewController.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLManageSelectPointNodeInformationVC : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *currentWallet;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *CRTypeString;

/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *lastArray;

@end

NS_ASSUME_NONNULL_END
