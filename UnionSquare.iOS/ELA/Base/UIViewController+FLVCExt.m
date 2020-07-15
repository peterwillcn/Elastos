//
//  UIViewController+FLVCExt.m
//  FLWALLET
//
//  Created by  on 2018/4/17.
//  Copyright © 2018年 . All rights reserved.
//

#import "UIViewController+FLVCExt.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <UserNotifications/UserNotifications.h>
//#import "NSData+YYAdd.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDKUI.h>
#import "FLFLTabBarVC.h"
#import "AppDelegate.h"
#import "FLShareVC.h"
#import "HMWtransferViewController.h"
#import "HWMSingleSignReadOnlyWalletViewController.h"
#import "HWMSignThePurseViewController.h"
#import "HWMQrCodeScanningResultsViewController.h"
#import "HWMQrCodeTransferAndAddBuddyViewController.h"
#import "HMWaddContactViewController.h"
#import "HWMmessageWindowPopsView.h"

@interface UIViewController (FLVCExt)

@end

@implementation UIViewController (FLVCExt)

-(void)defultBack{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
}
-(void)firstNav{
    [self.navigationController.navigationBar setBackgroundImage:[self screenShotView:self.view.subviews.firstObject] forBarMetrics:UIBarMetricsDefault]; self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
-(void)defultWhite{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"window_750_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
}
-(void)blackBackImageDefultWhite{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_arrow_black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
}
-(void)CNTOdefultWhite{
    
    self.navigationController.navigationBar.barTintColor = defultColor;
    self.navigationController.navigationBar.tintColor = defultTextThemeColor;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],}];
}
-(void)setBackgroundImg:(NSString*)img{
    UIImageView *bg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    if (img.length==0) {
        [self CAGradientColorFrome:RGB(83, 136, 136) withToColor:RGB(16, 47, 58) withView:bg];
    }else{
        bg.image = [UIImage imageNamed:img];
    }
    [self.view insertSubview:bg atIndex:0];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
//传入需要截取的view
-(UIImage *)screenShotView:(UIView *)view{
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(AppWidth, 2), false, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
}
-(void)CAGradientColorFrome:(UIColor*)fclolr withToColor:(UIColor*)tcolor withView:(UIView*)view{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,AppWidth,AppHeight);
    gl.colors = @[(__bridge id)fclolr.CGColor,(__bridge id)tcolor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer addSublayer:gl];
    
}
-(void)setNavBarClearColor{
    //    [self.navigationController.navigationBar setTranslucent:true];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)NewStateView:(UIColor *)color{
    CGRect rect = [[UIApplication sharedApplication]statusBarFrame];
    if (rect.size.height != 20) {
        rect.size.height = 44;
    }
    //CGRectMake(0, -rect.size.height, rect.size.width, rect.size.height)
    UIView *v = [[UIView alloc]initWithFrame: rect];
    v.backgroundColor = color;
    [self.view addSubview:v];
}
//-(void)shareTitle:(NSString*)title content:(NSString*)content images:(NSArray*)imageArray url:(NSURL*)url{
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:content
//                                     images:imageArray
//                                        url:url
//                                      title:title
//                                       type:SSDKContentTypeAuto];
//    [shareParams SSDKSetupSinaWeiboShareParamsByText:[content stringByAppendingString:url?url.absoluteString:@"" ] title:title images:imageArray?imageArray:nil video:nil url:nil latitude:0 longitude:0 objectID:0 isShareToStory:NO type:SSDKContentTypeAuto];
//
//
//
//
//    [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//        switch (state) {
//            case SSDKResponseStateSuccess:
//            {
//                [HttpUrl NetPOSTHost:Http_UpImage url:@"/api/user/vlink/activity/news/share/reward" dict:@{@"id":@3001} showHUD:NO WithSuccessBlock:^(id data) {
//
//                } WithFailBlock:^(id data) {
//
//                }];
//                break;
//            }
//            case SSDKResponseStateFail:
//            {
//
//                break;
//            }
//            default:
//                break;
//        }
//    }];
//}
-(void)shearText:(NSString*)text{
    FLShareVC *vc =  [[FLShareVC  alloc]init];
    vc.definesPresentationContext = YES;
    vc.shareContent = text;
    vc.modalPresentationStyle =  UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

-(void)shareArray:(NSArray*)arr{
    
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
    //不出现在活动项目
    activityVC.modalInPopover = true;
    
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypeMail,UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeMessage,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAirDrop,UIActivityTypePostToVimeo,UIActivityTypeAddToReadingList,UIActivityTypeOpenInIBooks];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            
            //            [HttpUrl NetPOSTHost:Http_UpImage url:@"/api/user/vlink/activity/news/share/reward" dict:@{@"id":@3001} showHUD:NO WithSuccessBlock:^(id data) {
            //
            //            } WithFailBlock:^(id data) {
            //
            //            }];
            //分享 成功
        } else  {
            //            //NSLog(@"cancled");
            //分享 取消
        }
    };
}
- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        //                        DLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        //                        DLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:NO];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil) message:NSLocalizedString(@"请去-> [设置 - 隐私 - 相机 - ] 打开访问开关", nil) preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                //                //NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil) message:NSLocalizedString(@"未检测到您的摄像头", nil) preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}
-(BOOL)isPhoneNumber:(NSString*)phone;
{
    NSString *regex = @"^1\\d{10}";
    return [self isValidateByRegex:regex with:phone];
}
-(BOOL)isMathNumber:(NSString*)text{
    NSString *regex = @"^\\d+\\.?\\d*$";
    return [self isValidateByRegex:regex with:text];
}
-(BOOL)isIdCardNumber:(NSString*)text{
    NSString *regex = @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)";
    return [self isValidateByRegex:regex with:text];
}

-(BOOL)isPassWord:(NSString*)text{
    NSString *regex = @"^(?=.*[A-Za-z])(?=.*\\d).*\\S{8,16}$";
    return [self isValidateByRegex:regex with:text];
}
-(BOOL)isValidateByRegex:(NSString *)regex with:(NSString*)textStr {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:textStr];
}
- (NSString *)aes256_encrypt:(NSString*)text withKey:(NSString *)key{
    
    if (key.length>16) {
        key = [key substringToIndex:16];
    }
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    //对数据进行加密
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    //    char ivPtr[kCCKeySizeAES128+1];
    //    bzero(ivPtr, sizeof(ivPtr));
    //    [@"123123" getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding |kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    NSData *result;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    //转换为2进制字符串
    if (result && result.length > 0) {
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil ;
}

- (NSString *)aes256_decrypt:(NSString*)text withKey:(NSString *)key{
    
    if (key.length>16) {
        key = [key substringToIndex:16];
    }
    NSMutableData *data = [NSMutableData dataWithCapacity:text.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [text length] / 2; i++) {
        byte_chars[0] = [text characterAtIndex:i*2];
        byte_chars[1] = [text characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding |kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    NSData *result;
    if (cryptStatus == kCCSuccess) {
        result =  [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    //对数据进行解密
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}
//-(void)getShareCode:(NSString*)addr actityId:(NSString*)actityId projectId:(NSString*)projectId withcontractAddress:(NSString*)contractAddress{
//
//
//    if (addr==nil||actityId==nil||projectId==nil|| contractAddress==nil) {
//        return;
//    }
//    {
//        "activityId": "string",
//        "contractAddress": "string",
//        "investorAddress": "string",
//        "projectId": "string"
//    }
//        NSDictionary *param = @{@"investorAddress":addr,@"activityId":actityId,@"projectId":projectId,@"contractAddress":contractAddress};
//    [HttpUrl NetPOSTHost:Http_CNTO url:@"/cnto/sharingQualification/check" dict:param showHUD:YES WithSuccessBlock:^(id data) {
//        NSString *code = [NSString stringWithFormat:@"%@",data[@"data"][@"activityInvitedCode"]];
//
//
//        if (code.length ==0||[code isEqualToString:@"<null>"]) {
//            [[FLTools share]showErrorInfo:@"请先完成兑换"];
//            return ;
//        }
//
//
//
//        NSString *invite = [NSString stringWithFormat:@"参与【XXX CNTO节点计划】计划】http://download.mcoin.ai/VTR3DuA 复制链 复制链接，到浏览器打开后下载mok.ai APP并安装，然后复制这段描述 €%@€ 并打开mok.ai APP",code];
////        [[FLTools share]showErrorInfo:@"复制成功"];
////        [self shareArray:@[invite]];
//        [self shearText:invite];
//    } WithFailBlock:^(id data) {
//
//    }];
//}

-(void)GotoMainTabBarVC{
    FLFLTabBarVC *vc = [[FLFLTabBarVC alloc]init];
    AppDelegate  *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = vc;
}
-(UIWindow *)mainWindow{
//    return self.view;
    UIApplication *app = [UIApplication sharedApplication];

    if ([app.delegate respondsToSelector:@selector(window)]){
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}
/* 获取本地时间 */
- (NSString *)getLeftNowTimeWithEndTime:(NSString*)endTime {
    NSDate*currentDate = [NSDate date];
    
    //    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    //    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[currentDate timeIntervalSince1970];
    
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    NSString *leftTime=
    [NSString stringWithFormat:@"%d",[endTime intValue]-[timeString intValue]];
    
    
    return [leftTime floatValue]>0?leftTime:@"00:00:00";
}
// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        //        //NSLog(@"%@",error);
        
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}
-(void)makeBordersWithView:(UIView*)view{
    
    view.layer.borderWidth=1.f;
    view.layer.borderColor=[UIColor whiteColor].CGColor;
    view.layer.masksToBounds=YES;
    
    
    
}
-(void)NotificationCenter{
    
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    
}
#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect viewFrame=self.view.frame;
    if (viewFrame.origin.y==0) {
        viewFrame.origin.y=viewFrame.origin.y-frame.size.height;
        self.view.frame=viewFrame;
    }
    
    
    
    
}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect viewFrame=self.view.frame;
    viewFrame.origin.y=0;
    self.view.frame=viewFrame;
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardWillHideNotification object:nil];
    
}
-(void)reMovNotificationCenter{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    
    
}
-(BOOL)whetherTheCurrent:(NSString*)VC{
    if ([VC isEqualToString:[NSString stringWithFormat:@"%@",[self class]]]) {
        return YES;
    }
    return NO;
    
}
-(BOOL)QrCodepushVC:(NSDictionary*)dic WithCurrWallet:(FLWallet*)currW{
    int type=[dic[@"extra"][@"Type"] intValue];
    
    //    public static final int CREATEREADONLY = 0x1;//打开创建单签只读钱包页面
    //    public static final int CREATEMUL = 0x2;//打开创建多签钱包页面 已经打开了的情况直接填入
    //    public static final int SIGN = 0x3;//打开签名页面
    //    public static final int TRANSFER = 0x4;//打开转账页面
    
    switch (type) {
        case 1:{
            if (![self whetherTheCurrent:@"HWMSingleSignReadOnlyWalletViewController"]) {
                HWMSingleSignReadOnlyWalletViewController *SingleSignReadOnlyWalletVC=[[HWMSingleSignReadOnlyWalletViewController alloc]init];
                SingleSignReadOnlyWalletVC.jsonString=[[FLTools share]DicToString:dic[@"data"]];
                [self.navigationController pushViewController:SingleSignReadOnlyWalletVC animated:NO];
                return NO;
                
            }else{
                return YES;
            }
            
            break;}
        case 2:{
            if(![self whetherTheCurrent:@"HWMSignThePurseViewController"]) {
                HWMSignThePurseViewController *SignThePurseVC=[[ HWMSignThePurseViewController alloc]init];
                SignThePurseVC.publicKeyString=dic[@"data"];
                [self.navigationController pushViewController:SignThePurseVC animated:NO];
                return NO;
                
            }else{
                return YES;
            }
            
            
            break;}
        case 3:{
            if(![self whetherTheCurrent:@"FirstViewController"]) {
                
                return NO;
                
            }else{
                return YES;
            }
            
            break;}
        case 4:{
            if (![self whetherTheCurrent:@"HMWtransferViewController"]&&![self whetherTheCurrent:@"HMWaddContactViewController"]) {
                HWMQrCodeTransferAndAddBuddyViewController *QrCodeTransferAndAddBuddyVC=[[HWMQrCodeTransferAndAddBuddyViewController alloc]init];
                QrCodeTransferAndAddBuddyVC.currentWallet=currW;
                QrCodeTransferAndAddBuddyVC.addressDic=dic;
                QrCodeTransferAndAddBuddyVC.addressString=dic[@"data"];
                [self.navigationController pushViewController:QrCodeTransferAndAddBuddyVC animated:NO];
                return NO;
                
            }else{
                
                return YES;
            }
            
            break;}
            
        default:
            return NO;
            break;
    }
}
-(BOOL)TypeJudgment:(NSDictionary*)dic{
    
    NSInteger Type=[dic[@"extra"][@"Type"] integerValue];
    
    
    
    switch (Type) {
        case 1:
            return YES;
            break;
        case 2:
            return YES;
            break;
        case 3:
            return YES;
            break;
        case 4:
            return YES;
            break;
        default:
            return NO;
            break;
    }
    
    return NO;
}
-(void)QrCodeScanningResultsWithString:(NSString*)QrCodeScanning withVC:(UIViewController*)VC{
    HWMQrCodeScanningResultsViewController *QrCodeScanningResultsVC=[[HWMQrCodeScanningResultsViewController alloc]init];
    QrCodeScanningResultsVC.resultString=QrCodeScanning;
    [VC.navigationController pushViewController:QrCodeScanningResultsVC animated:YES];
    
}


//-(void)showSendSuccessView{
//   self.sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
//    UIView *manView=[self mainWindow];
//    [manView addSubview:self.sendSuccessPopuV];
//    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(manView);
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.sendSuccessPopuV removeFromSuperview];
//        self.sendSuccessPopuV=nil;
//        [self.navigationController popViewControllerAnimated:YES];
//    });
//   
//}
-(void)showLoading{
    [[FLTools share]showLoadingView];
    
}
-(void)hiddLoading{
   [[FLTools share] hideLoadingView];
}
-(void)showSendSuccessPopuVWithType:(SendSuccessType)suType withBackVC:(UIViewController*)VC{
    
    HMWSendSuccessPopuView *sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    sendSuccessPopuV.type=suType;
    UIView *manView=[self mainWindow];
    [manView addSubview:sendSuccessPopuV];
    [sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sendSuccessPopuV removeFromSuperview];
        if (VC) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                
                if ([controller isKindOfClass:[VC class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
    
}
-(void)showNeMessageWith:(HWMMessageCenterModel*)mode{
    UIView  *appW=[self mainWindow];
    HWMmessageWindowPopsView *messagePopsV =[[HWMmessageWindowPopsView alloc]init];
    messagePopsV.frame=CGRectMake(15, -100, AppWidth-30, 70);
    [appW addSubview:messagePopsV];
    
    [UIView animateWithDuration:1 animations:^{
        messagePopsV.frame = CGRectMake(15, 30, AppWidth-30, 70);
    }];
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        messagePopsV.frame = CGRectMake(15, -100, AppWidth-30, 70);
    } completion:^(BOOL finished) {
        [messagePopsV removeFromSuperview];
        
    }];
    
}
 -(void)checkUserNotificationEnable { // 判断用户是否允许接收通知
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

    [self  presentViewController:alert animated:YES completion:nil];
}
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
@end
