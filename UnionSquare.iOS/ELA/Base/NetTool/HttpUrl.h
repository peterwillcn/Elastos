//
//  HttpUrl.h
//  BS
//
//  Created by ike on 16/7/15.
//  Copyright © 2016年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HttpUrl : NSObject
//+(AFHTTPSessionManager*)getManage;
//个别网络加载失败POST处理

+ (void)NetPOSTHost:(NSString*)host url:(NSString *)httpUrl header:(NSDictionary*)header body:(NSDictionary *)param  showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock;
//个别网络加载失败GET处理
+ (void)NetGETHost:(NSString*)host url:(NSString *)httpUrl header:(NSDictionary*)header body:(NSDictionary *)param   showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock;




#pragma mark 上传图片
+ (void)upLoadImage:(UIImage *)image  showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock;
+ (void)upLoadImage:(NSString*)host Url:(NSString*)url Param:(NSDictionary*)param Images:(NSArray *)images  showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock;
#pragma mark ---------下载图片----------
+(void)loadDataWithUrl:(NSString*)urlString withIconName:(NSString*)iconName WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock;
+(void)canleURL;
@end

