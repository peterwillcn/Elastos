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
#import <Bugly/Bugly.h>
#define KYRect  [UIScreen mainScreen].bounds
#define BUGLY_APP_ID @"2642eff54a"
@interface AppDelegate ()<BuglyDelegate>

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{


        //初始化一个imageView，并添加到window上
    
    if(launchOptions[UIApplicationLaunchOptionsURLKey] != nil){
        [self application:application handleOpenURL:launchOptions[UIApplicationLaunchOptionsURLKey]];
    }
        
    
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
            model=array[i];
             model.walletID=[NSString stringWithFormat:@"%@",model.walletID];
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
                sideModel.thePercentageMax=@"100";
                sideModel.thePercentageCurr=@"0";
                
                [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
                [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
                
            }
            
        }
        
    }
    
    array =[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet];
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
    
    //#if DEBUG
    
    [self setupBugly];
    
    //#endif
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window

{
    
  return UIInterfaceOrientationMaskPortrait;
    
}
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    
    return YES;
    
}
-(void)applicationWillTerminate:(UIApplication *)application{
   
}
-(void)applicationDidEnterBackground:(UIApplication *)application {
}
/**
 iOS 9.0 以下 程序运行过程中调用
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL host:%@", [url host]);
    return YES;
}

/**
 iOS 9.0 之后 程序运行过程中调用
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    
    NSLog(@"URL scheme:%@", [url scheme]);
    //参数
    NSLog(@"URL host:%@", [url host]);
    
    NSString * message;
    if ([[url host] isEqualToString:@"success"]) {
        message = @"分享成功";
    }else{
        message = @"分享失败";
    }
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:[url host] delegate:self cancelButtonTitle:nil otherButtonTitles:message, nil];
    [alertView show];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
}
- (void)setupBugly {
    
    // Get the default config
    
    BuglyConfig * config = [[BuglyConfig alloc] init];
    
    
    
    // Open the debug mode to print the sdk log message.
    
    // Default value is NO, please DISABLE it in your RELEASE version.
    
    //#if DEBUG
    
    config.debugMode = YES;
    
    //#endif
    
    
    
    // Open the customized log record and report, BuglyLogLevelWarn will report Warn, Error log message.
    
    // Default value is BuglyLogLevelSilent that means DISABLE it.
    
    // You could change the value according to you need.
    
    //    config.reportLogLevel = BuglyLogLevelWarn;
    
    
    
    // Open the STUCK scene data in MAIN thread record and report.
    
    // Default value is NO
    
    config.blockMonitorEnable = YES;
    
    
    
    // Set the STUCK THRESHOLD time, when STUCK time > THRESHOLD it will record an event and report data when the app launched next time.
    
    // Default value is 3.5 second.
    
    config.blockMonitorTimeout = 1.5;
    
    
    
    // Set the app channel to deployment
    
    config.channel = @"Bugly";
    
    
    
    config.delegate = self;
    
    
    
    config.consolelogEnable = NO;
    
    config.viewControllerTrackingEnable = NO;
    
    
    
    // NOTE:Required
    
    // Start the Bugly sdk with APP_ID and your config
    
    [Bugly startWithAppId:BUGLY_APP_ID
     
#if DEBUG
     
        developmentDevice:YES
     
#endif
     
                   config:config];
    
    
    
    // Set the customizd tag thats config in your APP registerd on the  bugly.qq.com
    
    // [Bugly setTag:1799];
    
    
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    
    
    
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    
    
    
    // NOTE: This is only TEST code for BuglyLog , please UNCOMMENT it in your code.
    
//    [self performSelectorInBackground:@selector(testLogOnBackground) withObject:nil];
    
}



/**
 
 *    @brief TEST method for BuglyLog
 
 */

- (void)testLogOnBackground {
    
    int cnt = 0;
    
    while (1) {
        
        cnt++;
        
        
        
        switch (cnt % 5) {
                
            case 0:
                
                BLYLogError(@"Test Log Print %d", cnt);
                
                break;
                
            case 4:
                
                BLYLogWarn(@"Test Log Print %d", cnt);
                
                break;
                
            case 3:
                
                BLYLogInfo(@"Test Log Print %d", cnt);
                
                BLYLogv(BuglyLogLevelWarn, @"BLLogv: Test", NULL);
                
                break;
                
            case 2:
                
                BLYLogDebug(@"Test Log Print %d", cnt);
                
                BLYLog(BuglyLogLevelError, @"BLLog : %@", @"Test BLLog");
                
                break;
                
            case 1:
                
            default:
                
                BLYLogVerbose(@"Test Log Print %d", cnt);
                
                break;
                
        }
        
        
        
        // print log interval 1 sec.
        
        //        sleep(1);
        
    }
    
}



#pragma mark - BuglyDelegate

- (NSString *)attachmentForException:(NSException *)exception {
    
    NSLog(@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,exception);
    
    
    
    return @"This is an attachment";
    
}


-(void)applicationWillResignActive:(UIApplication *)application {
    [[ELWalletManager share]EMWMFlushData];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
     [[ELWalletManager share]EMWMFlushData];
}
@end
