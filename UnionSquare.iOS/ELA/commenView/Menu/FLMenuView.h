//
//  FLMenuView.h
//  RYJ
//
//  Created by  on 2018/1/31.
//  Copyright © 2018年 RongKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLMenuView;
@protocol FLMenuViewDelegate<NSObject>
-(void)FLMenuView:(FLMenuView*)menu click:(NSInteger)index info:(NSDictionary*)info;
@end

@interface FLMenuView : UIView
@property(strong,nonatomic)NSArray *items;
@property (nonatomic, assign)NSInteger style;//0 背景 金字 1 白背景 黑字
@property(weak,nonatomic)id<FLMenuViewDelegate>FLMenuDelegate;
@end


