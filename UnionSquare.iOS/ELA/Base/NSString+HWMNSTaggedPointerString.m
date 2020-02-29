//
//  NSString+HWMNSTaggedPointerString.m
//  elastos wallet
//
//  Created by  on 2019/11/5.
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
- (NSUInteger)charactorNumber
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self charactorNumberWithEncoding:encoding];
}

- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding
{
    NSUInteger strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:encoding];
    
    NSUInteger lengthOfBytes = [self lengthOfBytesUsingEncoding:encoding];
    for (int i = 0; i < lengthOfBytes; i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

- (NSUInteger)charactorNumberForChineseSpecial
{
    NSUInteger strLength = 0;
    for(int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if (a >= 0x4e00 && a <= 0x9fa5) { // judging whether it is Chinese
            strLength += 2;
        } else {
            strLength += 1;
        }
    }
    return strLength;
}
@end
