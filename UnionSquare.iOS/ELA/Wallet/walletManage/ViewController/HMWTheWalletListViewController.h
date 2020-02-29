//
//  HMWTheWalletListViewController.h
//  ELA
//
//  Created by  on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMWTheWalletListViewControllerDelegate <NSObject>

-(void)needUpdateInfo:(FLWallet*_Nonnull)wallet withSelectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HMWTheWalletListViewController : UIViewController

/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger currentWalletIndex;
/*
 *<# #>
 */
@property(copy,nonatomic)NSMutableArray *walletIDListArray;
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWTheWalletListViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
