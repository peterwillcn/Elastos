//
//  UIViewController+FLVCExt.h
//  FLWALLET
//
//  Created by  on 2018/4/17.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLTools.h"

@interface UIViewController (FLVCExt)
/*
 *<# #>
 */
@property(copy,nonatomic)NSDictionary *QRCoreDic;
-(void)defultBack;
-(void)defultWhite;
-(void)NewStateView:(UIColor*)color;
-(void)setBackgroundImg:(NSString*)img;
-(void)setNavBarClearColor;
-(void)CAGradientColorFrome:(UIColor*)fclolr withToColor:(UIColor*)tcolor withView:(UIView*)view;

-(void)CNTOdefultWhite;
-(void)firstNav;

-(void)shareArray:(NSArray*)arr;
-(void)shearText:(NSString*)text;
-(void)shareTitle:(NSString*)title content:(NSString*)content images:(NSArray*)imageArray url:(NSURL*)url;
- (void)QRCodeScanVC:(UIViewController *)scanVC ;

- (UIWindow *)mainWindow;
-(void)GotoMainTabBarVC;

-(BOOL)isPhoneNumber:(NSString *)text;
-(BOOL)isMathNumber:(NSString*)text;
-(BOOL)isIdCardNumber:(NSString*)text;
-(BOOL)isPassWord:(NSString*)text;

- (NSString *)aes256_encrypt:(NSString*)text withKey:(NSString *)key;
- (NSString *)aes256_decrypt:(NSString*)text withKey:(NSString *)key;
- (NSString *)getLeftNowTimeWithEndTime:(NSString*)endTime;


-(NSString *)convertToJsonData:(NSDictionary *)dict;
-(void)makeBordersWithView:(UIView*)view;
-(void)NotificationCenter;
-(void)reMovNotificationCenter;
-(void)blackBackImageDefultWhite;
-(UIImage *)screenShotView:(UIView *)view;
-(NSDictionary*)SCanQRCodeWithDicCode:(NSDictionary*)dic;
-(BOOL)QrCodepushVC:(NSDictionary*)dic WithCurrWallet:(FLWallet*)currW;
-(BOOL)TypeJudgment:(NSDictionary*)dic;
-(void)QrCodeScanningResultsWithString:(NSString*)QrCodeScanning withVC:(UIViewController*)VC;
@end
