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
        [DAConfig setUserLanguage:@"en"];
     
    }else if ([languageString  containsString:@"zh"]){

        [DAConfig setUserLanguage:@"zh-Hans"];
        
    }else{
        
           [DAConfig setUserLanguage:@"en"];
    }
      
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    CDVPluginResult *re=[[ELWalletManager share] getAllMasterWallets:nil];
    NSArray *reArray=[[FLTools share]stringToArray: re.message[@"success"]];
    
    NSArray  *array =[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet];
    for (int i=0; i<array.count; i++) {
         BOOL isbool = [reArray containsObject: array[i]];
        if (isbool==NO) {
            FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
            model.walletID=[NSString stringWithFormat:@"%@",array[i]];
            [[HMWFMDBManager sharedManagerType:walletType]delectRecordWallet: model];
        }
        
    }
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
    [WOCrashProtectorManager makeAllEffective];
    [self.window makeKeyAndVisible];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window

{
    
  return UIInterfaceOrientationMaskPortrait;
    
}
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    
    
    
}

@end
