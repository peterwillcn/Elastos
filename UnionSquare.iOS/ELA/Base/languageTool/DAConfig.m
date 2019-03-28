//
//  DAConfig.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/2/19.
//

#import "DAConfig.h"
#import "FLMyVC.h"
#import "NSBundle+DAUtils.h"
#import "AppDelegate.h"
#import "FLFLTabBarVC.h"




@implementation DAConfig

+ (void)setUserLanguage:(NSString *)userLanguage
{
//    //跟随手机系统
//    if (!userLanguage.length) {
//
//        return;
//    }
    
//     [STANDARD_USER_DEFAULT removeObjectForKey:UWUserLanguageKey];
    //用户自定义
    [STANDARD_USER_DEFAULT setValue:userLanguage forKey:UWUserLanguageKey];
//        [STANDARD_USER_DEFAULT removeObjectForKey:UWUserLanguageKey];
//    [STANDARD_USER_DEFAULT setValue:@[userLanguage] forKey:UWUserLanguageKey];
  
    [STANDARD_USER_DEFAULT synchronize];
    
//    [self resetSystemLanguage];
}

+ (NSString *)userLanguage
{
//         [STANDARD_USER_DEFAULT removeObjectForKey:UWUserLanguageKey];
//    [STANDARD_USER_DEFAULT removeObjectForKey:@"AppleLanguages"];
//      [STANDARD_USER_DEFAULT removeObjectForKey:UWUserLanguageKey];
//    return @"en";
//    NSArray *languageArray=[STANDARD_USER_DEFAULT valueForKey:UWUserLanguageKey];
    return [STANDARD_USER_DEFAULT valueForKey:UWUserLanguageKey];
}

/**
 重置系统语言
 */
+ (void)resetSystemLanguage
{
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isOpen"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    //解决奇怪的动画bug。异步执行
    dispatch_async(dispatch_get_main_queue(), ^{
        appdelegate.window.rootViewController = tabVC;

        
        tabVC.selectedIndex=2;
       
//        NSLog(@"已切换到语言 %@", [NSBundle currentLanguage]);
    });
}
@end
