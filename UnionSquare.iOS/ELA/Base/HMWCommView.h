//
//  HMWCommView.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMWCommView : NSObject
+(instancetype)share;
-(void)makeBordersWithView:(UIView*)view;
-(void)makeTextFieldPlaceHoTextColorWithTextField:(UITextField*)textf;
@end

NS_ASSUME_NONNULL_END
