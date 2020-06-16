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
#import "HMWLocalNotice.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

static HMWLocalNotice *tool;

@interface HMWLocalNotice ()
@property (strong,nonatomic)UIViewController *aleVC;

@end

@implementation HMWLocalNotice
+(instancetype)share{
    if (!tool) {
        
        tool = [[self alloc]init];
    }
    return tool;
    
}
-(instancetype)init{
    self = [super init];
    [self checkUserNotificationEnable];
    return self;
}
-(void)addLocalNoticeWithCont:(NSString*)cont{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *notiCenter = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
        content.badge = @1;
        
        content.body = cont;
        content.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"testNOti" content:content trigger:trigger];
        [notiCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
        }];
        
    } else {
        
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        
        notif.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
        
        notif.alertBody = cont;
        
        
        notif.applicationIconBadgeNumber = 1;
        
        notif.soundName = UILocalNotificationDefaultSoundName;
        
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
    
    
}

// 移除某一个指定的通知
- (void)removeOneNotificationWithID:(NSString *)noticeId {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            for (UNNotificationRequest *req in requests){
                NSLog(@"存在的ID:%@\n",req.identifier);
            }
            NSLog(@"移除currentID:%@",noticeId);
        }];
        
        [center removePendingNotificationRequestsWithIdentifiers:@[noticeId]];
    }else {
        NSArray *array=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (UILocalNotification *localNotification in array){
            NSDictionary *userInfo = localNotification.userInfo;
            NSString *obj = [userInfo objectForKey:@"noticeId"];
            if ([obj isEqualToString:noticeId]) {
                [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            }
        }
    }
}

// 移除所有通知
- (void)removeAllNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
    }else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)checkUserNotificationEnable { // 判断用户是否允许接收通知
    if (@available(iOS 10.0, *)) {
        __block BOOL isOn = NO;
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                isOn = YES;
                NSLog(@"打开了通知");
            }else {
                isOn = NO;
                NSLog(@"关闭了通知");
                [self showAlertView];
            }
        }];
    }else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone){
            NSLog(@"关闭了通知");
            [self showAlertView];
        }else {
            NSLog(@"打开了通知");
        }
    }
}

- (void)showAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"通知", nil) message:NSLocalizedString(@"未获得通知权限，请前去设置", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"设置", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToAppSystemSetting];
    }]];

    [self.aleVC presentViewController:alert animated:YES completion:nil];
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改
- (void)goToAppSystemSetting {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                }
            }else {
               
            }
        }
    });
}
- (UINavigationController *)getCurrentVC {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        
        return (UINavigationController *)window.rootViewController;
        
    } else if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
        
        if ([selectVc isKindOfClass:[UINavigationController class]]) {
            
            return (UINavigationController *)selectVc;
            
        }
        
    }
    
    return nil;
    
    
}
-(void)checkUserNotificationEnableWith:(UIViewController*)vc{
    
    [self checkUserNotificationEnable];
    self.aleVC=vc;
    
}
@end
