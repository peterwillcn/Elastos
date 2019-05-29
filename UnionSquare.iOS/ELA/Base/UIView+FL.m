//
//  UIView+FL.m
//  FLWALLET
//
//  Created by  on 2018/8/15.
//  Copyright © 2018年 . All rights reserved.
//

#import "UIView+FL.h"

@implementation UIView (FL)
+(UILabel*)FLLab_TextColor:(UIColor *)color Fort:(NSInteger)fort{
    UILabel *a = [[UILabel alloc]init];
    a.textColor = color;
    a.font = [UIFont systemFontOfSize:fort];
    return a;
}
+(UIButton*)FLBtn_Text:(NSString*)text TextColor:(UIColor *)color Fort:(NSInteger)fort{
    UIButton *b = [[UIButton alloc]init];
    [b setTitleColor:color forState:UIControlStateNormal];
    [b setTitle:text forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:fort];
    return b;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor boldColor:(UIColor*)boldColor corner:(CGFloat)num
{
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    }
    if (num) {
//        num = self.mj_h/2;
        self.layer.cornerRadius = num;
    }
    
    if (boldColor) {
        self.layer.borderColor = boldColor.CGColor;
        self.layer.borderWidth = 1;
    }
    self.layer.masksToBounds = YES;
}
-(void)setTestFilePlaceStringColor:(UITextField*)file color:(UIColor*)color{
    file.attributedPlaceholder = [[NSAttributedString alloc] initWithString:file.placeholder attributes:@{NSForegroundColorAttributeName: color}];
}
- (UIImage *)resetImageWithOriginalImage:(UIImage *)originalImage withScaleSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)makeBordersWithView:(UIView*)view{
    
    view.layer.borderWidth=1.f;
    view.layer.borderColor=[UIColor whiteColor].CGColor;
    view.layer.masksToBounds=YES;
    
    
    
}
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 6; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
//                          NSKernAttributeName:@1.0f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
    label.numberOfLines=0;
}
@end
