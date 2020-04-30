//
//  HMWChooseSideChainViewController.h
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assetsListModel.h"
#import "friendsModel.h"
typedef NS_ENUM(NSInteger,ChooseSideChainType ) {
    chooseSideChainType=0,
    chooseFriendsType
};
NS_ASSUME_NONNULL_BEGIN

@protocol HMWChooseSideChainViewControllerDelegate <NSObject>

-(void)choosedFriedsMode:(friendsModel*)model;

@end



@interface HMWChooseSideChainViewController : UIViewController
/*
 *<# #>
 */
@property(assign,nonatomic)ChooseSideChainType type;
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
@property(weak,nonatomic)id<HMWChooseSideChainViewControllerDelegate> delegate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *addressArray;
@end

NS_ASSUME_NONNULL_END
