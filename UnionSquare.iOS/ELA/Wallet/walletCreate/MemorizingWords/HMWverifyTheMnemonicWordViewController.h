//
//  HMWverifyTheMnemonicWordViewController.h
//  ELA
//
//  Created by  on 2019/1/7.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMWverifyTheMnemonicWordVCDelegate <NSObject>
-(void)backTheWallet:(FLWallet*)wallet;
@end

@interface HMWverifyTheMnemonicWordViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)NSString *mnemonic;
@property (nonatomic, strong)FLWallet*Wallet;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *FormeType;
@property (nonatomic, assign)NSInteger createType;
@property(weak,nonatomic)id<HMWverifyTheMnemonicWordVCDelegate>delegate;
@end

