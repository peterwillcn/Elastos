//
//  FLwalletSelectView.h
//  FLWALLET
//
//  Created by fxl on 2018/4/18.
//  Copyright © 2018年 fxl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLwalletSelectView;
@protocol MoreDelegate<NSObject>
@optional
-(void)memu:(FLwalletSelectView*)menu clickWallet:(NSInteger)index;
-(void)memu:(FLwalletSelectView*)menu clickBtn:(NSInteger)index;
@end

@interface FLwalletSelectView : UIView
@property(weak ,nonatomic)id<MoreDelegate> delegate;
@property (nonatomic, assign)NSInteger selectIndext;
+(instancetype)shareView;
-(void)removed;


@end
