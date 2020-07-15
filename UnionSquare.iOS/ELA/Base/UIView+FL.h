//
//  UIView+FL.h
//  FLWALLET
//
//  Created by  on 2018/8/15.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FL)
+(UILabel*)FLLab_TextColor:(UIColor *)color Fort:(NSInteger)fort;
+(UIButton*)FLBtn_Text:(NSString*)text TextColor:(UIColor *)color Fort:(NSInteger)fort;

-(void)setBackgroundColor:(UIColor *)backgroundColor boldColor:(UIColor*)boldColor corner:(CGFloat)num;
-(void)setTestFilePlaceStringColor:(UITextField*)file color:(UIColor*)color;
- (UIImage *)resetImageWithOriginalImage:(UIImage *)originalImage withScaleSize:(CGSize)size;
-(void)makeBordersWithView:(UIView*)view;
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;

@end
