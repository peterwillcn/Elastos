//
//  NSString+HWMNSTaggedPointerString.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/11/5.
//

#import "NSString+HWMNSTaggedPointerString.h"
#import <objc/runtime.h>
//#import <AppKit/AppKit.h>


@implementation NSString (HWMNSTaggedPointerString)
-(void)count{
    
}

- (NSString *)safeCharacterAtIndex:(NSUInteger)index {
    if (index < self.length) {
        return [NSString stringWithFormat:@"%C",[self characterAtIndex:index]];
    }else {
        return nil;
    }
}
@end
