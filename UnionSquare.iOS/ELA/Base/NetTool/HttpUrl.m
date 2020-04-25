//
//  HttpUrl.m
//  BS
//
//  Created by ike on 16/7/15.
//  Copyright © 2016年 mc. All rights reserved.
//
#import "HttpUrl.h"

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
NSString *errorString = @"加载失败，请稍后再试";
NSInteger timeOut = 60;
@implementation HttpUrl

+(AFHTTPSessionManager*)getManage{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
//    AFHTTPSessionManager *manage = [[AFHTTPSessionManager manager]initWithBaseURL:[NSURL URLWithString:Http_UpImage]];
    manage.requestSerializer = [AFJSONRequestSerializer serializer];//请求

    
    manage.requestSerializer.timeoutInterval = timeOut;
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"application/x-www-form-urlencoded",@"text/html",nil];
   // [manage.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // 1.初始化单例类

//    // 2.设置证书模式
//    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
//    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
       AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone ];
    [securityPolicy setValidatesDomainName:NO];
//
    securityPolicy.allowInvalidCertificates = YES;

     manage.securityPolicy = securityPolicy;
    
    return manage;
}

+ (void)NetPOSTHost:(NSString*)host url:(NSString *)httpUrl header:(NSDictionary*)header body:(NSDictionary *)param  showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock{
    BOOL isSh=YES;
    if ([httpUrl isEqualToString:@"/api/dposnoderpc/check/getimage"]) {
        isSh=NO;
    }else if([httpUrl isEqualToString:@"/api/dposnoderpc/check/jwtget"]){
        isSh=NO;
    }
     if (show) {
         [[FLTools share]showLoadingView];
        
    }
    AFHTTPSessionManager *manage = [self getManage];
    
    NSDictionary *dataDic = [self addOtherKey:param];
    NSString *stringUrl;
    if (httpUrl.length>0) {
    stringUrl = [NSString stringWithFormat:@"%@%@",host,httpUrl];
    }else{
        stringUrl =host;
    }
    

    [manage POST:stringUrl parameters:param headers:header progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (show) {
            [SVProgressHUD dismiss];
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSInteger code = [dic[@"code"] integerValue];
      
        if (code==0||code==200) {
            successBlock(dic);
        }else{
            NSString *errString=dic[@"exceptionMsg"];
            if (isSh) {
                 [[FLTools share]showErrorInfo:errString];
            }
           
            FailBlock(dic);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isSh) {
            [[FLTools share]showErrorInfo:errorString];
    }
        FailBlock(error);
    }];
    
   
}
+ (void)NetGETHost:(NSString*)host url:(NSString *)httpUrl header:(NSDictionary*)header body:(NSDictionary *)param showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock{



  if (show) {
  [[FLTools share] showLoadingView];

    }
    AFHTTPSessionManager *manage = [self getManage];

    NSString *stringUrl = [NSString stringWithFormat:@"%@%@",host, httpUrl];
    NSDictionary *dataDic = [self addOtherKey:param];
    [manage GET:stringUrl parameters:dataDic headers:header progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (show) {
            [SVProgressHUD dismiss];
        }
        NSInteger code = [dic[@"code"] integerValue];
        if (code==0) {
            successBlock(dic);
        }else{
            NSString *errString=dic[@"exceptionMsg"];
           
            [[FLTools share]showErrorInfo:errString];
            
            FailBlock(dic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![httpUrl isEqualToString:@"/api/dposNodeRPC/getProducerNodesList"]) {
              [[FLTools share]showErrorInfo:errorString];
        }
        FailBlock(error);
        
    }];
   
}

#pragma mark 上传图片
+ (void)upLoadImage:(UIImage *)image showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock{
     if (show) {
         [[FLTools share] showLoadingView];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.requestSerializer = [AFJSONRequestSerializer new];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
   
    NSString *httpStr = [Http_IP stringByAppendingString:@"/api/attachment/upload"];
   
    [manager POST:httpStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        //对图片大小进行压缩--
        NSData *data=UIImageJPEGRepresentation(image, 1.0);
        if (data.length>100*1024) {
            if (data.length>1024*1024) {//1M以及以上
                data=UIImageJPEGRepresentation(image, 0.1);
            }else if (data.length>512*1024) {//0.5M-1M
                data=UIImageJPEGRepresentation(image, 0.5);
            }else if (data.length>200*1024) {//0.25M-0.5M
                data=UIImageJPEGRepresentation(image, 0.9);
            }
        }
        

        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data
                                    name:@"files"
                                fileName:@"123.jpg"
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
//        DLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
         if (show) {
        [SVProgressHUD dismiss];
    }
//        DLog(@"上传结果:%@", responseObject);
        //上传成功
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        if (code==0) {
            successBlock(dic);
         }else{
            NSString *errString=[NSString stringWithFormat:@"%@",dic[@"msg"]];
          
            [[FLTools share]showErrorInfo:errString];
        }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
//        DLog(@"%@", error);
        //上传失败
        [[FLTools share]showErrorInfo:errorString];
        FailBlock(nil);
    }];
}
+ (void)upLoadImage:(NSString*)host Url:(NSString*)url Param:(NSDictionary*)param Images:(NSArray *)images  showHUD:(BOOL)show WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock
{
    
     if (show) {
         [[FLTools share]showLoadingView];
    }

    AFHTTPSessionManager  *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
   [ manager.requestSerializer setValue:[FLTools share].user.loginToken forHTTPHeaderField:@"x-client-token"];
    manager.requestSerializer.timeoutInterval = 30;
    NSString *httpStr = [host stringByAppendingString:url];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSMutableURLRequest *re = [NSMutableURLRequest  ]
    
    [manager POST:httpStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        for (UIImage *img in images) {
            
            NSData *data=UIImageJPEGRepresentation(img, 1.0);
            if (data.length>100*1024) {
                if (data.length>1024*1024) {//1M以及以上
                    data=UIImageJPEGRepresentation(img, 0.1);
                }else if (data.length>512*1024) {//0.5M-1M
                    data=UIImageJPEGRepresentation(img, 0.5);
                }else if (data.length>200*1024) {//0.25M-0.5M
                    data=UIImageJPEGRepresentation(img, 0.9);
                }
            }
            //上传的参数(上传图片，以文件流的格式)
             NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", [formatter stringFromDate:[NSDate date]],i];
            [formData appendPartWithFileData:data
                                        name:@"files"
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
            
            i++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         if (show) {
        [SVProgressHUD dismiss];
    }
        NSDictionary *dic =responseObject;
        NSInteger code = [dic[@"code"] integerValue];
        if (code==0) {
            successBlock(dic);
       
        }else{
            NSString *errString=[NSString stringWithFormat:@"%@",dic[@"msg"]];
            
            [[FLTools share]showErrorInfo:errString];
            FailBlock(dic);

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[FLTools share]showErrorInfo:errorString];
        FailBlock(nil);
    }];

}
+(NSDictionary*)addOtherKey:(NSDictionary *)dict{
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]initWithDictionary:dict];
  
    [parm setValuesForKeysWithDictionary:dict];
    return parm;
}

+(void)loadDataWithUrl:(NSString*)urlString withIconName:(NSString*)iconName WithSuccessBlock:(void(^)(id data))successBlock WithFailBlock:(void(^)(id data))FailBlock{
    /* 创建网络下载对象 */
     AFHTTPSessionManager *manager = [self getManage];

    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    NSData *data =[NSData dataWithContentsOfFile:filePath];
    if (data.length>0) {
         successBlock(url.lastPathComponent);
        return;
        
    }
    
    /* 开始请求下载 */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //NSLog(@"下载完成");
        successBlock(url.lastPathComponent);
        
    }];
    [downloadTask resume];
    
}
+(void)canleURL{
      AFHTTPSessionManager *manager = [self getManage];
 [manager.operationQueue cancelAllOperations];
}

@end
