//
//  AFHTTPSessionTaskManager.m
//  InaviAirFrame
//
//  Created by KimDaeCheol on 2016. 4. 21..
//  Copyright © 2016년 KimDaeCheol. All rights reserved.
//

#import "AFHTTPSessionTaskManager.h"
static NSLock *sessionLock;
@implementation AFHTTPSessionTaskManager
+(NSLock*)sessionLock{
    if(sessionLock == nil){
        sessionLock = [[NSLock alloc] init];
        sessionLock.name = @"AFHTTPSessionTaskManager.Session.Lock";
    }
    return sessionLock;
}
@end

@implementation AFHTTPSessionTaskDelegate
@end
