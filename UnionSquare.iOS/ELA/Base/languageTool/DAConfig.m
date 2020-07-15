//
//  DAConfig.m
//  elastos wallet
//
//  Created by  on 2019/2/19.
//

#import "DAConfig.h"
#import "FLMyVC.h"
#import "NSBundle+DAUtils.h"
#import "AppDelegate.h"
#import "FLFLTabBarVC.h"
#import "MJRefreshConfig.h"
@implementation DAConfig
+ (void)setUserLanguage:(NSString *)userLanguage
{
    //用户自定义
    if (userLanguage.length==0) {
        userLanguage=@"en";
    }
    [STANDARD_USER_DEFAULT setValue:@[userLanguage] forKey:UWUserLanguageKey];
    [STANDARD_USER_DEFAULT synchronize];
}

+ (NSString *)userLanguage
{

    NSObject * ojg =[STANDARD_USER_DEFAULT valueForKey:UWUserLanguageKey];
   
    NSMutableString *LamguaeKey;
    if ([ojg isKindOfClass:[NSArray class]]) {
        NSArray *ojbArr=[STANDARD_USER_DEFAULT valueForKey:UWUserLanguageKey];
        LamguaeKey=[NSMutableString stringWithFormat:@"%@",ojbArr.firstObject];

    }else{
         LamguaeKey=[NSMutableString stringWithFormat:@"%@",[STANDARD_USER_DEFAULT valueForKey:UWUserLanguageKey]];
        
    }
    return LamguaeKey;
}
+(BOOL)isArrayType{
    NSObject * ojg =[STANDARD_USER_DEFAULT valueForKey:UWUserLanguageKey];
       if ([ojg isKindOfClass:[NSArray class]]) {
           return YES;

       }
    return NO;
    
}

/**
 重置系统语言
 */
+ (void)resetSystemLanguage
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isOpen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    //解决奇怪的动画bug。异步执行
    dispatch_async(dispatch_get_main_queue(), ^{
        appdelegate.window.rootViewController = tabVC;
        tabVC.selectedIndex=2;
    });
}
@end
