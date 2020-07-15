//
//  HMWTheWalletManagementViewController.h
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMWTheWalletManagementViewController : UIViewController
@property (nonatomic, strong)FLWallet *currentWallet;
@property (nonatomic, strong)NSArray *currencyArray;
@end

NS_ASSUME_NONNULL_END
