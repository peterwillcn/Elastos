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
#import <objc/runtime.h>
#import "HWMDIDManager.h"
#import "JWT.h"
#import "MyUtil.h"
#define KYRect  [UIScreen mainScreen].bounds
@interface AppDelegate ()

@end
@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    
    
    //初始化一个imageView，并添加到window上
    
    if(launchOptions[UIApplicationLaunchOptionsURLKey] != nil){
        [self application:application handleOpenURL:launchOptions[UIApplicationLaunchOptionsURLKey]];
    }
    
    
    //    [HWMDIDManager sdas];
    
    NSString *languageString=[DAConfig userLanguage];
    //    if (
    //    [[FLTools share]allHasNameAndHas];
    //        ) {
    //        exit(0);
    //      }
//       [[FLTools share]showErrorInfo:[NSString stringWithFormat:@"%f",AppHeight]];
    
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
    NSArray *reArray=re.message[@"success"];
    
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
            model.didString=@"";
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
    UITableView.appearance.estimatedRowHeight = 0;
    UITableView.appearance.estimatedSectionFooterHeight = 0;
    UITableView.appearance.estimatedSectionHeaderHeight = 0;
    [self.window makeKeyAndVisible];
    
    if (@available(iOS 13.2, *)) {
        
    }else{
        const char *className = "_UITextLayoutView";
        Class cls = objc_getClass(className);
        if (cls == nil) {
            cls = objc_allocateClassPair([UIView class], className, 0);
            objc_registerClassPair(cls);
#if DEBUG
            printf("added %s dynamically\n", className);
#endif
        }
    }
    
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
    //NSLog(@"URL scheme:%@", [url scheme]);
    //NSLog(@"URL host:%@", [url host]);
    return YES;
}

/**
 iOS 9.0 之后 程序运行过程中调用
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    
    //NSLog(@"URL scheme:%@", [url scheme]);
    //参数
    //NSLog(@"URL host:%@", [url host]);
    NSString *path = [url absoluteString];
    path = [path stringByRemovingPercentEncoding];
    NSMutableString *string = [[NSMutableString alloc] initWithString:path];
    
    BOOL sa= [MyUtil AddCommDIDWithJWT:string];
    NSString * message;
    if (sa) {
        message = @"保存成功";
    }else{
        message = @"保存失败";
    }
    [[FLTools share]showErrorInfo:message];
    
    //    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:[url host] delegate:self cancelButtonTitle:nil otherButtonTitles:message, nil];
    //    [alertView show];
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
}
-(void)applicationWillResignActive:(UIApplication *)application {
    [[ELWalletManager share]EMWMFlushData];
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [[ELWalletManager share]EMWMFlushData];
}




















//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths lastObject];
//    if (url != nil) {
//        NSString *path = [url absoluteString];
//        path = [path stringByRemovingPercentEncoding];
//        NSMutableString *string = [[NSMutableString alloc] initWithString:path];
//        if ([path hasPrefix:@"file:///private"]) {
//            [string replaceOccurrencesOfString:@"file:///private" withString:@"" options:NSCaseInsensitiveSearch  range:NSMakeRange(0, path.length)];
//        }
//        NSArray *tempArray = [string componentsSeparatedByString:@"/"];
//        NSString *fileName = tempArray.lastObject;
//        NSString *sourceName = options[@"UIApplicationOpenURLOptionsSourceApplicationKey"];
//
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",sourceName,fileName]];
//        if ([fileManager fileExistsAtPath:filePath]) {
//            //NSLog(@"文件已存在");
//            [SVProgressHUD showErrorWithStatus:@"文件已存在"];
//            return YES;
//        }
////        [MRTools creatFilePathInManager:sourceName];
//        BOOL isSuccess = [fileManager copyItemAtPath:string toPath:filePath error:nil];
//        if (isSuccess == YES) {
//            //NSLog(@"拷贝成功");
//            [SVProgressHUD showSuccessWithStatus:@"文件拷贝成功"];
//        } else {
//            //NSLog(@"拷贝失败");
//            [SVProgressHUD showErrorWithStatus:@"文件拷贝失败"];
//        }
//    }
//    //NSLog(@"application:openURL:options:");
//    return  YES;
//}
@end
