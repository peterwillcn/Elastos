//
//  FLticketProgressView.h
//  FLWALLET
//
//  Created by  on 2018/11/15.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLticketProgressView;
@protocol FLticketProgressViewDelegate<NSObject>
-(void)flview:(FLticketProgressView*)view  ClickType:(NSInteger)type;

@end

@interface FLticketProgressView : UIView

@property(nonatomic,assign)NSInteger type;//必须传至 1//方的   2 扁的。
@property (weak, nonatomic) IBOutlet UILabel *subText;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *alertText;


@property(nonatomic,weak)id<FLticketProgressViewDelegate> delegate;

@end


