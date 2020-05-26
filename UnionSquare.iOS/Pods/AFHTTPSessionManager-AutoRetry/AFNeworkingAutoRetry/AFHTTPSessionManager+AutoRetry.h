//
//  AFHTTPSessionManager+AutoRetry.h
//  InaviAirFrame
//
//  Created by KimDaeCheol on 2016. 4. 21..
//  Copyright © 2016년 KimDaeCheol. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (AutoRetry)

- (NSURLSessionDataTask * _Nonnull)GET:(NSString * _Nonnull)URLString
                   parameters:(nullable id)parameters
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id  _Nullable))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
                    autoretry:(NSInteger)retryCount DEPRECATED_ATTRIBUTE;

- (nullable NSURLSessionDataTask *)GET:(NSString * _Nonnull)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
                             autoretry:(NSInteger)retryCount;

- (nullable NSURLSessionDataTask *)HEAD:(NSString * _Nonnull)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
                              autoretry:(NSInteger)retryCount;

- (nullable NSURLSessionDataTask *)POST:(NSString * _Nonnull)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                              autoretry:(NSInteger)retryCount DEPRECATED_ATTRIBUTE;

- (nullable NSURLSessionDataTask *)POST:(NSString *_Nonnull)URLString
                             parameters:(id _Nullable)parameters
                               progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure
                              autoretry:(NSInteger)retryCount;

- (nullable NSURLSessionDataTask *)PUT:(NSString * _Nonnull)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                             autoretry:(NSInteger)retryCount;

- (nullable NSURLSessionDataTask *)PATCH:(NSString * _Nonnull)URLString
                              parameters:(nullable id)parameters
                                 success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                               autoretry:(NSInteger)retryCount;

- (nullable NSURLSessionDataTask *)DELETE:(NSString * _Nonnull)URLString
                               parameters:(nullable id)parameters
                                  success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable responseObject))success
                                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
                                autoretry:(NSInteger)retryCount;

@property (nonatomic, strong) id _Nullable mutableTaskDelegateKeyByTaskIdentifier;
@end
