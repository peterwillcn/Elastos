//
//  HMWpwdPopupView.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol HMWpwdPopupViewDelegate <NSObject>

-(void)makeSureWithPWD:(NSString*)pwd;
@optional
-(void)cancelThePWDPageView;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HMWpwdPopupView : UIView
/*
 *<# #>
 */
@property(weak,nonatomic)id<HMWpwdPopupViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
