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

@interface AppDelegate ()

@end
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
    
    PluginResult *re=[[ELWalletManager share] getAllMasterWallets:nil];
    NSArray *reArray=[[FLTools share]stringToArray: re.message[@"success"]];
    
    NSArray  *array =[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet];
   
    if (array.count>reArray.count) {
        for (int i=0; i<array.count; i++) {
             FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
             model.walletID=[NSString stringWithFormat:@"%@",array[i]];
            BOOL isbool = [reArray containsObject: model.walletID];
            
            if (isbool==NO) {
                
               
               
                [[HMWFMDBManager sharedManagerType:walletType]delectRecordWallet: model];
                
            }
        }
        
    }else if(array.count<reArray.count){
        
        
        
        for (int i=0; i<reArray.count; i++) {
            FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
            model.walletID=[NSString stringWithFormat:@"%@",reArray[i]];
            BOOL isbool = [array containsObject: model.walletID];
            if (isbool==NO) {
                model.walletName=@"null";
                sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
            sideModel.walletID=model.walletID;
            sideModel.sideChainName=@"ELA";
        sideModel.sideChainNameTime=@"--:--";
                
                [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
                [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
                
            }
            
        }
    }
    
    
    if (array.count==0) {
        
        FLPrepareVC *vc=[[FLPrepareVC alloc]init];
        BaseNavigationVC *naVC=[[BaseNavigationVC alloc]initWithRootViewController:vc];
        vc.type=creatWalletType;
        self.window.rootViewController = naVC;
        
    }else{
        FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
        self.window.rootViewController = tabVC;
    }
    [WOCrashProtectorManager makeAllEffective];
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window

{
    
  return UIInterfaceOrientationMaskPortrait;
    
}
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    
    
    
}
-(void)applicationWillTerminate:(UIApplication *)application{
    
    [[ELWalletManager share] EMWMSaveConfigs];
}
-(void)applicationDidEnterBackground:(UIApplication *)application {
 [[ELWalletManager share] EMWMSaveConfigs];
}

@end
