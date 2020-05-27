//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define ELAUnitConversion 10000000

#define ELAFEE @"0.0001"

#define ELAWeakSelf __weak __typeof(self) weakSelf = self;

#define ELAIsNoEmpty(string) ((string) != nil && (![(string) isEqualToString:@""]))

#define ELALocalizedString(key) (NSLocalizedString((key), nil))

#define PingFangRegular(s) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize(s)]
#define PingFangSemibold(s) [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize(s)]
//宽比例放大
//#define fontSize(size) floor(size*((ScreenHeight>568.0f)?((ScreenHeight>667.0f?667.0f:ScreenHeight)/568.0f):1))    //字体适配
#define fontSize(size) floor(size * 1)    //字体适配
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width                   //屏幕宽度
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height                 //屏幕高度

#define ELARGBA(r,g,b,a)  [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define ELARGB(r,g,b)  [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]
#define ELAColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define AppWidth  [UIScreen mainScreen].bounds.size.width
#define AppHeight [UIScreen mainScreen].bounds.size.height

// 判断是否是iPhone X
#define iPhoneX ((ScreenWidth == 375.f || ScreenWidth == 414.f) && (ScreenHeight == 812.f || ScreenHeight == 896.f))


#define StatusBarHeight (iPhoneX ? 44.f : 20.f) //状态栏高度
#define NavigitionBarHeight  (iPhoneX ? 88.f : 64.f) //导航栏高度
#define BottomHeight (iPhoneX ? 34 : 0)
#define TabBarBottomHeight (iPhoneX ? 34 + 49 : 49)


#define ImageNamed(name)  [UIImage imageNamed:(name)]

//ELARGBA(149, 159, 171) //ELARGBA(107, 133, 135);//ELARGBA(107, 142, 143);
@interface ELAUtils : NSObject

+ (NSString *)localizedString:(NSString *)key;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (NSString *)getNationality:(NSInteger )location;
+ (NSString *)getTime:(NSString *)timeStr;
+ (NSString *)getTimeWithNumber:(double)time;

@end

NS_ASSUME_NONNULL_END
