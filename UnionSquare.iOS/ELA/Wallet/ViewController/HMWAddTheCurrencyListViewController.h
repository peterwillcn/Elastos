//
//  HMWAddTheCurrencyListViewController.h
//  ELA
//
//  Created by  on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMWAddTheCurrencyListViewControllerDelegate <NSObject>

-(void)openIDChainOfDIDAddWithWallet:(NSString*)walletID;

@end


//NS_ASSUME_NONNULL_BEGIN

@interface HMWAddTheCurrencyListViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *wallet;


/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *openedTheSubstringArrayList;


/*
 *<# #>
 */
@property(copy,nonatomic)NSString *sideChainID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *didType;
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWAddTheCurrencyListViewControllerDelegate> delegate;
@end

//NS_ASSUME_NONNULL_END
