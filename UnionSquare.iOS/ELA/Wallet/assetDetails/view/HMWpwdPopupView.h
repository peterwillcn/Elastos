//
//  HMWpwdPopupView.h
//  ELA
//
//  Created by  on 2018/12/27.
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
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGHeight;

@end

NS_ASSUME_NONNULL_END
