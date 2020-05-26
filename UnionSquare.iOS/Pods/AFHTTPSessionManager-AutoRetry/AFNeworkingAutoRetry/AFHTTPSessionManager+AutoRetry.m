//
//  AFHTTPSessionManager+AutoRetry.m
//  InaviAirFrame
//
//  Created by KimDaeCheol on 2016. 4. 21..
//  Copyright © 2016년 KimDaeCheol. All rights reserved.
//

#import <objc/runtime.h>

#import "AFHTTPSessionManager+AutoRetry.h"
#import "AFHTTPSessionTaskManager.h"

static char const * const mutableTaskKey = "mutableTaskDelegateKeyByTaskIdentifier";

@implementation AFHTTPSessionManager(AutoRetry)

- (NSURLSessionDataTask * _Nonnull)GET:(NSString * _Nonnull)URLString
                            parameters:(id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id  _Nullable))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
                             autoretry:(NSInteger)retryCount
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    
    AFHTTPSessionTaskDelegate *delegate = [self delegateDataSet:URLString parameters:parameters progress:nil success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(GET:parameters:success:failure:autoretry:);
    
    NSURLSessionDataTask *dataTask = [self GET:URLString parameters:parameters
                                       success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                           [self successBlockTask:task success:responseObject];
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           [self failBlockTask:task failure:error];
                                       }];
    
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    
    return dataTask;
}

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable))failure
                             autoretry:(NSInteger)retryCount
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    
    AFHTTPSessionTaskDelegate *delegate = [self delegateDataSet:URLString parameters:parameters progress:downloadProgress success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(GET:parameters:progress:success:failure:autoretry:);
    
    NSURLSessionDataTask *dataTask = [self GET:URLString parameters:parameters
                                      progress:^(NSProgress * _Nonnull downloadProgress) {
                                          //TODO: ...
                                      } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                          [self successBlockTask:task success:responseObject];
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          [self failBlockTask:task failure:error];
                                      }];
    
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    
    return dataTask;
}

- (nullable NSURLSessionDataTask *)HEAD:(NSString * _Nonnull)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable))failure
                              autoretry:(NSInteger)retryCount
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    
    AFHTTPSessionTaskDelegate *delegate = [self delegateNonDataSet:URLString parameters:parameters progress:nil success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(HEAD:parameters:success:failure:autoretry:);
    
    NSURLSessionDataTask *dataTask = [self HEAD:URLString parameters:parameters
                                        success:^(NSURLSessionDataTask * _Nonnull task) {
                                            [self successBlockTask:task success:nil];
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            [self failBlockTask:task failure:error];
                                        }];
    
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    
    return dataTask;
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
                              autoretry:(NSInteger)retryCount DEPRECATED_ATTRIBUTE
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    AFHTTPSessionTaskDelegate *delegate = [self delegateDataSet:URLString parameters:parameters progress:nil success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(POST:parameters:success:failure:autoretry:);
    NSURLSessionDataTask *dataTask = [self POST:URLString parameters:parameters
                                        success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                            [self successBlockTask:task success:responseObject];
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            [self failBlockTask:task failure:error];
                                        }];
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                     autoretry:(NSInteger)retryCount
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    AFHTTPSessionTaskDelegate *delegate = [self delegateDataSet:URLString parameters:parameters progress:uploadProgress success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(POST:parameters:progress:success:failure:autoretry:);
    
    NSURLSessionDataTask *dataTask = [self POST:URLString parameters:parameters
                                       progress:^(NSProgress * _Nonnull uploadProgress) {
                                           //TODO: ...
                                       } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                           [self successBlockTask:task success:responseObject];
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           [self failBlockTask:task failure:error];
                                       }];
    
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    return dataTask;
}

- (nullable NSURLSessionDataTask *)PUT:(NSString * _Nonnull)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                             autoretry:(NSInteger)retryCount
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    AFHTTPSessionTaskDelegate *delegate = [self delegateDataSet:URLString parameters:parameters progress:nil success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(PUT:parameters:success:failure:autoretry:);
    
    NSURLSessionDataTask *dataTask = [self PUT:URLString parameters:parameters
                                       success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                           [self successBlockTask:task success:responseObject];
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           [self failBlockTask:task failure:error];
                                       }];
    
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    return dataTask;
}

- (nullable NSURLSessionDataTask *)PATCH:(NSString * _Nonnull)URLString
                              parameters:(nullable id)parameters
                                 success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                               autoretry:(NSInteger)retryCount
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    AFHTTPSessionTaskDelegate *delegate = [self delegateDataSet:URLString parameters:parameters progress:nil success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(PATCH:parameters:success:failure:autoretry:);
    
    NSURLSessionDataTask *dataTask = [self PATCH:URLString parameters:parameters
                                       success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                           [self successBlockTask:task success:responseObject];
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           [self failBlockTask:task failure:error];
                                       }];
    
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    return dataTask;
}

- (nullable NSURLSessionDataTask *)DELETE:(NSString * _Nonnull)URLString
                               parameters:(nullable id)parameters
                                  success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                                autoretry:(NSInteger)retryCount
{
    [[AFHTTPSessionTaskManager sessionLock] lock];
    AFHTTPSessionTaskDelegate *delegate = [self delegateDataSet:URLString parameters:parameters progress:nil success:success failure:failure autoretry:retryCount];
    delegate.selector = @selector(DELETE:parameters:success:failure:autoretry:);
    
    NSURLSessionDataTask *dataTask = [self DELETE:URLString parameters:parameters
                                         success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                                             [self successBlockTask:task success:responseObject];
                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             [self failBlockTask:task failure:error];
                                         }];
    
    [self associativeDataSetWithDelegate:delegate SessionDataTask:dataTask];
    [[AFHTTPSessionTaskManager sessionLock] unlock];
    return dataTask;
}
#pragma mark - AutoRetry Fuction
- (AFHTTPSessionTaskDelegate *)delegateDataSet:(NSString *)URLString
                                    parameters:(id)parameters
                                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                                     autoretry:(NSInteger)retryCount
{
    AFHTTPSessionTaskDelegate *delegate = [[AFHTTPSessionTaskDelegate alloc] init];
    delegate.successBlock = success;
    delegate.failBlock = failure;
    delegate.progressBlock = uploadProgress;
    delegate.retryCount = retryCount;
    delegate.urlString = URLString;
    delegate.params = parameters;
    return delegate;
}
- (AFHTTPSessionTaskDelegate *)delegateNonDataSet:(NSString *)URLString
                                       parameters:(id)parameters
                                         progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                          success:(void (^)(NSURLSessionDataTask * _Nonnull))success
                                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                                        autoretry:(NSInteger)retryCount
{
    AFHTTPSessionTaskDelegate *delegate = [[AFHTTPSessionTaskDelegate alloc] init];
    delegate.successNonBlock = success;
    delegate.failBlock = failure;
    delegate.progressBlock = uploadProgress;
    delegate.retryCount = retryCount;
    delegate.urlString = URLString;
    delegate.params = parameters;
    return delegate;
}
- (void)associativeDataSetWithDelegate:(AFHTTPSessionTaskDelegate *)delegate SessionDataTask:(NSURLSessionDataTask *)dataTask
{
    NSMutableDictionary *taskIdentifierDic = [self mutableTaskDelegateKeyByTaskIdentifier];
    if(taskIdentifierDic == nil){
        taskIdentifierDic = [[NSMutableDictionary alloc] init];
    }
    taskIdentifierDic[@(dataTask.taskIdentifier)] = delegate;
    [self setMutableTaskDelegateKeyByTaskIdentifier:taskIdentifierDic];
}
- (void)successBlockTask:(NSURLSessionDataTask *)dataTask success:(id _Nullable) success
{
    NSMutableDictionary *taskIdentifierDic = [self mutableTaskDelegateKeyByTaskIdentifier];
    AFHTTPSessionTaskDelegate *delegate = taskIdentifierDic[@(dataTask.taskIdentifier)];
    delegate.successBlock(dataTask,success);
    [taskIdentifierDic removeObjectForKey:@(dataTask.taskIdentifier)];
}
- (void)failBlockTask:(NSURLSessionDataTask * _Nullable)dataTask failure:(NSError * _Nonnull) failure
{
    NSMutableDictionary *taskIdentifierDic = [self mutableTaskDelegateKeyByTaskIdentifier];
    AFHTTPSessionTaskDelegate *delegate = taskIdentifierDic[@(dataTask.taskIdentifier)];
    if(delegate == nil)
        return;
    delegate.retryCount -= 1;
    if(delegate.retryCount <= 0)
        delegate.failBlock(dataTask,failure);
    else{
        //        [self GET:delegate.urlString parameters:delegate.params success:delegate.successBlock failure:delegate.failBlock autoretry:delegate.retryCount];
        //        [taskIdentifierDic removeObjectForKey:@(dataTask.taskIdentifier)];
        
        NSString *str = NSStringFromSelector(delegate.selector);
        NSArray *ary = [str componentsSeparatedByString:@":"];
        NSMutableArray *paramsAry = [NSMutableArray array];
        BOOL bNonSuccessCheck = NO;
        for(NSString *key in ary){
            if([key isEqualToString:@"GET"] || [key isEqualToString:@"POST"] ||
               [key isEqualToString:@"PUT"] || [key isEqualToString:@"PATCH"] ||
               [key isEqualToString:@"DELETE"]) {
                [paramsAry addObject:delegate.urlString];
            }else if([key isEqualToString:@"HEAD"]){
                [paramsAry addObject:delegate.urlString];
                bNonSuccessCheck = YES;
            }else if([key isEqualToString:@"parameters"]){
                if(delegate.params == nil)
                    [paramsAry addObject:[NSNull null]];
                else
                    [paramsAry addObject:delegate.params];
            }else if([key isEqualToString:@"progress"]){
                if(delegate.progressBlock == nil)
                    [paramsAry addObject:[NSNull null]];
                else
                    [paramsAry addObject:delegate.progressBlock];
            }else if([key isEqualToString:@"success"]){
                if(bNonSuccessCheck)
                    [paramsAry addObject:delegate.successNonBlock];
                else
                    [paramsAry addObject:delegate.successBlock];
            }else if([key isEqualToString:@"failure"]){
                [paramsAry addObject:delegate.failBlock];
            }else if([key isEqualToString:@"autoretry"]){
                [paramsAry addObject:[NSNumber numberWithInteger:delegate.retryCount]];
            }
        }
        [self dispatchSelector:delegate.selector target:self objects:paramsAry onMainThread:NO];
        [taskIdentifierDic removeObjectForKey:@(dataTask.taskIdentifier)];
    }
}

#pragma mark - Associative References
- (id)mutableTaskDelegateKeyByTaskIdentifier {
    return objc_getAssociatedObject(self, mutableTaskKey );
}
- (void)setMutableTaskDelegateKeyByTaskIdentifier:(id)mutableTask {
    objc_setAssociatedObject(self, mutableTaskKey , mutableTask , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - common func
- (void) dispatchSelector:(SEL)selector
                   target:(id)target
                  objects:(NSArray*)objects
             onMainThread:(BOOL)onMainThread{
    if(target && [target respondsToSelector:selector]){
        NSMethodSignature* signature	= [target methodSignatureForSelector:selector];
        if(signature){
            NSInvocation* invocation	= [NSInvocation invocationWithMethodSignature:signature];
            @try{
                [invocation setTarget:target];
                [invocation setSelector:selector];
                
                if(objects){
                    NSInteger objectsCount	= [objects count];
                    
                    for(NSInteger i=0; i < objectsCount; i++){
                        NSObject* obj = [objects objectAtIndex:i];
                        if([obj isKindOfClass:[NSNull class]])
                            obj = nil;
                        if([obj isKindOfClass:[NSNumber class]]){
                            NSInteger nItem = [(NSNumber*)obj integerValue];
                            [invocation setArgument:&nItem atIndex:i+2];
                        }else
                            [invocation setArgument:&obj atIndex:i+2];
                    }
                }
                [invocation retainArguments];
                if(onMainThread){
                    [invocation performSelectorOnMainThread:@selector(invoke)
                                                 withObject:nil
                                              waitUntilDone:NO];
                }
                else{
                    [invocation performSelector:@selector(invoke)
                                       onThread:[NSThread currentThread]
                                     withObject:nil
                                  waitUntilDone:NO];
                }
            }
            @catch (NSException * e){
                NSLog(@"exception:%@", e.name);
            }
            @finally{
                
            }
        }
    }
}
@end
