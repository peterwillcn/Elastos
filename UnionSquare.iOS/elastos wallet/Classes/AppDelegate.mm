/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  elastos wallet
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "FLFLTabBarVC.h"
#import "ELWalletManager.h"
#import "BaseNavigationVC.h"
#import "FLPrepareVC.h"
#import "FirstViewController.h"
#import "HMWFMDBManager.h"
#import "ELWalletManager.h"
#import "WOCrashProtectorManager.h"
#import "DAConfig.h"
#define KYRect  [UIScreen mainScreen].bounds
@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{


        //初始化一个imageView，并添加到window上
    
    
        
    
   NSString *languageString=[DAConfig userLanguage];


    if ([languageString  containsString:@"en"]) {

//       [[NSUserDefaults standardUserDefaults] setValue:@[@"en"] forKey:UWUserLanguageKey];
        [DAConfig setUserLanguage:@"en"];
     
    }else if ([languageString  containsString:@"zh"]){
//        [[NSUserDefaults standardUserDefaults] setValue:@[@"zh-Hans"] forKey:UWUserLanguageKey];
        [DAConfig setUserLanguage:@"zh-Hans"];
        
    }else{
//         NSString *localeLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
//        if ([localeLanguageCode  containsString:@"en"]) {
//             [DAConfig setUserLanguage:@"en"];
//        [[NSUserDefaults standardUserDefaults] setValue:@[@"en"] forKey:@"UWUserLanguageKey"];
//        }else if ([localeLanguageCode  containsString:@"zh"]){
//            [DAConfig setUserLanguage:@"zh-Hans"];
////               [[NSUserDefaults standardUserDefaults] setValue:@[@"zh-Hans"] forKey:UWUserLanguageKey];
//
//        }else{
        
           [DAConfig setUserLanguage:@"en"];
//        }
        
        
        
    }
      
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    CDVPluginResult *re=[[ELWalletManager share] getAllMasterWallets:nil];
    NSArray  *array =[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet];
    //    [[FLTools share]stringToArray:re.message[@"success"]];
    
    if (array.count==0) {
        
        FLPrepareVC *vc=[[FLPrepareVC alloc]init];
        BaseNavigationVC *naVC=[[BaseNavigationVC alloc]initWithRootViewController:vc];
        vc.type=creatWalletType;
        self.window.rootViewController = naVC;
        
    }else{
        FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
        
        BaseNavigationVC *firstNAVC=tabVC.viewControllers.firstObject;
        FirstViewController *firstVC=firstNAVC.viewControllers.firstObject;
        //        firstVC.walletIDListArray=array;
        
        self.window.rootViewController = tabVC;
        
        
        
    }
//    [WOCrashProtectorManager makeAllEffective];
    [self.window makeKeyAndVisible];
//    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
//    imgView.image = [UIImage imageNamed:@"LimageEN"];
//    [self.window addSubview:imgView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [imgView removeFromSuperview];
//    });
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window

{
    
  return UIInterfaceOrientationMaskPortrait;
    
}
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    
    
    
}

@end
