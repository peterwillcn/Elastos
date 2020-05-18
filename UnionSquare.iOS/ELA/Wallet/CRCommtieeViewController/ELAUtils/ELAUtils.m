//
//  ELSUtils.m
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/11.
//  Copyright © 2020 64. All rights reserved.
//

#import "ELAUtils.h"

@implementation ELAUtils

+ (NSString *)localizedString:(NSString *)key
{
    return NSLocalizedString(key, nil);
}
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (NSString *)getTime:(NSString *)timeStr
{
    
    NSTimeInterval time = [timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    NSString *timeString = [formatter stringFromDate:date];
    
    return timeString;
}

@end
