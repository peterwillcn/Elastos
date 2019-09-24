//
//  HMWCommView.h
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMWCommView : NSObject
+(instancetype)share;
-(void)makeBordersWithView:(UIView*)view;
-(void)makeTextFieldPlaceHoTextColorWithTextField:(UITextField*)textf withTxt:(NSString*)pText;
@end

NS_ASSUME_NONNULL_END
