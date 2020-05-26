//
//  AFHTTPSessionTaskManager.h
//  InaviAirFrame
//
//  Created by KimDaeCheol on 2016. 4. 21..
//  Copyright © 2016년 KimDaeCheol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionTaskDelegate;

typedef void (^SessionManagerSuccessNonDataHandler)(NSURLSessionDataTask * _Nullable);
typedef void (^SessionManagerSuccessHandler)(NSURLSessionDataTask * _Nullable, id _Nonnull);
typedef void (^SessionManagerFailHandler)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
typedef void (^SessionManagerProgressHandler)(NSProgress * _Nonnull);

@interface AFHTTPSessionTaskManager : NSObject
+(NSLock* _Nullable)sessionLock;
@end

@interface AFHTTPSessionTaskDelegate : NSObject
@property (nonatomic, copy) SessionManagerSuccessNonDataHandler _Nullable successNonBlock;
@property (nonatomic, copy) SessionManagerSuccessHandler _Nullable successBlock;
@property (nonatomic, copy) SessionManagerFailHandler _Nullable failBlock;
@property (nonatomic, copy) SessionManagerProgressHandler _Nullable progressBlock;
@property (nonatomic, assign) SEL _Nonnull selector;
@property (nonatomic, assign) NSInteger retryCount;
@property (nonatomic, retain) NSString * _Nullable urlString;
@property (nonatomic, retain) id _Nullable params;
@end
