//
//  HMWAddTheCurrencyListViewController.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>


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
@end

//NS_ASSUME_NONNULL_END
