//
//  HMWSecurityVerificationPopView.h
//  ELA
//
//  Created by 韩铭文 on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMWSecurityVerificationPopViewDelegate <NSObject>
-(void)takeOutOrShutDown;
-(void)makeSureWithPWD:(NSString*)pwdString;


@end

NS_ASSUME_NONNULL_BEGIN

@interface HMWSecurityVerificationPopView : UIView
/*
*<# #>
*/
@property(strong,nonatomic)id <HMWSecurityVerificationPopViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
