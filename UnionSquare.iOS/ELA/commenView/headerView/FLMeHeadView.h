//
//  FLMeHeadView.h
//  FLWALLET
//
//  Created by  on 2018/4/17.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLMeHeadView;
@protocol FLMeHeadViewDelegate <NSObject>
-(void)head:(FLMeHeadView*)header click:(NSInteger)index;//1左2右3头像
@end

@interface FLMeHeadView : UIView

@end
