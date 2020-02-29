//
//  HMWvotingRulesView.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMWvotingRulesViewDelegate <NSObject>

-(void)closeViewDele;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HMWvotingRulesView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWvotingRulesViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
