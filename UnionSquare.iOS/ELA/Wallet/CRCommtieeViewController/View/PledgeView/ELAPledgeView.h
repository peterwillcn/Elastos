//
//  ELAPledgeView.h
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/14.
//  Copyright © 2020 64. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PledgeBlock)(void);

@interface ELAPledgeView : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) PledgeBlock block;

- (void)showAlertView;

- (void)hideAlertView;
@end

NS_ASSUME_NONNULL_END
