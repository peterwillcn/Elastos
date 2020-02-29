//
//  UIButton+HMWButton.h
//  FLWALLET
//
//  Created by  on 2019/4/16.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HMWButton)
/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
@end

NS_ASSUME_NONNULL_END
