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


#import "ELANetworkManager.h"

@implementation ELANetworkManager

#define TimeOut 60

+ (AFHTTPSessionManager *)getManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        //网络传输类型
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"application/x-www-form-urlencoded", @"text/html", nil];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:NO];
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = TimeOut;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
    });
    
    return manager;
}

+ (NSURLSessionDataTask *)ELANetworkPOST:(NSString *)url parameters:(NSDictionary *)parameters
                                 headers:(nullable NSDictionary *)headers block:(void (^) (id data, NSError *error))block
{
    AFHTTPSessionManager *manager = [ELANetworkManager getManager];
    
    NSURLSessionDataTask *task =[manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
    
    return task;
}

+ (NSURLSessionDataTask *)ELANetworkGET:(NSString *)url parameters:(NSDictionary *)parameters
                                headers:(nullable NSDictionary *)headers block:(void (^) (id data, NSError *error))block
{
    
    AFHTTPSessionManager *manager = [ELANetworkManager getManager];
    
    NSURLSessionDataTask *task =[manager GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
    return task;
}


@end
