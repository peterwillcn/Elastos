//
//  HMWverifyTheMnemonicWordViewController.h
//  ELA
//
//  Created by 韩铭文 on 2019/1/7.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMWverifyTheMnemonicWordViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)NSString *mnemonic;
@property (nonatomic, strong)FLWallet*Wallet;

@end

NS_ASSUME_NONNULL_END
