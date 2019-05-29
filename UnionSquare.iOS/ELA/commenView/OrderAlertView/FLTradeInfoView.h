//
//  FLTradeInfoView.h
//  FLWALLET
//
//  Created by  on 2018/4/24.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLTradeInfoView;
@protocol TradeInfoViewDelegate<NSObject>
@optional
-(void)TradeInfoView:(FLTradeInfoView*)view clickBtn:(NSInteger)index;
@end


@interface FLTradeInfoView : UIView
@property (nonatomic, strong)NSArray*dataSouce;
@property(weak ,nonatomic)id<TradeInfoViewDelegate> delegate;

+(instancetype)shareView;

@end
