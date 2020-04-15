//
//  UILabel+HMWinternationalization.m
//  FLWALLET
//
//  Created by  on 2019/4/22.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "UILabel+HMWinternationalization.h"
#import <objc/runtime.h>
@implementation UILabel (HMWinternationalization)

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method setText =class_getInstanceMethod([UILabel class], @selector(setText:));
        Method setTextMySelf =class_getInstanceMethod([self class],@selector(setTextHooked:));
        
        // 将目标函数的原实现绑定到setTextOriginalImplemention方法上
        IMP setTextImp =method_getImplementation(setText);
        
        class_addMethod([UILabel class], @selector(setTextOriginal:), setTextImp,method_getTypeEncoding(setText));
        
        //然后用我们自己的函数的实现，替换目标函数对应的实现
        IMP setTextMySelfImp =method_getImplementation(setTextMySelf);
        class_replaceMethod([UILabel class], @selector(setText:), setTextMySelfImp,method_getTypeEncoding(setText));
    });
    // 获取到UILabel中setText对应的method
    
    
}


- (void)setTextHooked:(NSString *)string
{
    if ([self isBlankString:string]) {

        string = @"";
        
    }
//    //NSLog(@"label===%@",string);
//    self.adjustsFontSizeToFitWidth = YES;
//    self.numberOfLines=0.f;
    [self performSelector:@selector(setTextOriginal:) withObject:NSLocalizedString(string, nil)];
    
}
- (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        
        return YES;
        
    }
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

@end
