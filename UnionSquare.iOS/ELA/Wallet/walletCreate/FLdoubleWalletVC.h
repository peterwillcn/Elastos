//
//  FLdoubleWalletVC.h
//  FLWALLET
//
//  Created by  on 2018/4/20.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FLdoubleWalletVCDelegate <NSObject>
-(void)backTheWallet:(FLWallet*)wallet;


@end
@interface FLdoubleWalletVC : UIViewController
@property (nonatomic, strong)FLWallet*Wallet;
@property (nonatomic, copy)NSString*signType;
/*
 *<# #>
 */
@property(weak,nonatomic)id<FLdoubleWalletVCDelegate>delegate;
@property (nonatomic, assign)NSInteger createType;
@end
