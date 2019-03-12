//
//  HMWImTheMnemonicWordView.h
//  ELA
//
//  Created by 韩铭文 on 2019/1/4.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMWImTheMnemonicWordViewDelegate <NSObject>

-(void)ImTheMnemonicWordViewCompWithWallet:(FLWallet*)wallet;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HMWImTheMnemonicWordView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWImTheMnemonicWordViewDelegate> delegate;
/*
 *<# #>
 */
@property(strong,nonatomic)UIViewController *VC;
@end

NS_ASSUME_NONNULL_END
