//
//  HMWAssetDetailsViewController.h
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assetsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMWAssetDetailsViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *currentWallet;
/*
 *<# #>
 */
@property(copy,nonatomic)assetsListModel*model;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *supportOfTheCurrencyArray;

/*
 *<# #>
 */
@property(copy,nonatomic)assetsListModel*elaModel;

/*
 *<# #>
 */
@property(assign,nonatomic)float synchronousP;


@end

NS_ASSUME_NONNULL_END
