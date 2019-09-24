//
//  HMWImKeystoreView.h
//  ELA
//
//  Created by  on 2019/1/4.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMWImKeystoreViewDeleagte <NSObject>

-(void)imKeystoreViewWithWallet:(FLWallet*_Nullable)wallet;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HMWImKeystoreView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWImKeystoreViewDeleagte> delegate;
/*
 *<# #>
 */
@property(strong,nonatomic)UIViewController *VC;
@end

NS_ASSUME_NONNULL_END
