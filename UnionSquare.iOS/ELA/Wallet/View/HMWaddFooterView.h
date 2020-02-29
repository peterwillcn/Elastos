//
//  HMWaddFooterView.h
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMWaddFooterViewDelegate <NSObject>

-(void)addTheAssetEvent;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HMWaddFooterView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWaddFooterViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
