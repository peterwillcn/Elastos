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


#import "ELANetwork.h"
#import "ELANetworkManager.h"
#import "ELAUtils.h"
#import "ELACommitteeInfoModel.h"
#import "ELACouncilAndSecretariatModel.h"
#import "ELAInformationDetail.h"

#define ERRORDESC (ELALocalizedString(@"获取数据失败"))

@implementation ELANetwork


+ (ELANetwork *)getManager
{
    static ELANetwork *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ELANetwork alloc] init];
        
    });
    
    return manager;
}

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters
                         block:(void (^) (id data, NSError *error))block
{
    return [ELANetworkManager ELANetworkPOST:url parameters:parameters headers:nil block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            if(data)
            {
                NSInteger code = [data[@"code"] integerValue];
                if(code == 0 || code == 200)
                {
                    block(data, nil);
                }
                else
                {
                    NSString *desc = data[@"exceptionMsg"];
                    NSError *_error = [ELANetwork getError:desc];
                    block(nil, _error);
                }
            }
        }
        
    }];
}

+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters
                        block:(void (^) (id data, NSError *error))block
{
    return [ELANetworkManager ELANetworkGET:url parameters:parameters headers:nil block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            NSInteger code = [data[@"code"] integerValue];
            if(code == 0 || code == 1)
            {
                block(data, nil);
            }
            else
            {
                NSString *errorStr = nil;
                NSString *desc = data[@"exceptionMsg"];
                if(desc && desc.length > 0)
                {
                    errorStr = desc;
                }
                else
                {
                    desc = data[@"message"];
                    if(desc && desc.length > 0)
                    {
                        errorStr = desc;
                    }
                }
                NSError *_error = [ELANetwork getError:desc];
                block(nil, _error);
            }
        }
    }];
}

+ (NSError *)getError:(NSString *)msg
{
    NSString *domain = @"";
    NSString *desc = msg;
    if(desc == nil)
    {
        desc = ERRORDESC;
    }
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
    
    NSError *_error = [NSError errorWithDomain:domain
                                          code:-101
                                      userInfo:userInfo];
    return _error;
}

#pragma mark - 查询历届CR委员会相关信息

+ (NSURLSessionDataTask *)getCommitteeInfo:(void (^) (id data, NSError *error))block
{
    NSString *host = CRProposalIP;
    NSString *path = @"/api/council/term/";
    NSString *url = [NSString stringWithFormat:@"%@%@",host, path];
    
    NSURLSessionDataTask *task = [ELANetwork GET:url parameters:nil block:^(id data, NSError *error) {
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            ELACommitteeInfoModel *mode = [ELACommitteeInfoModel mj_objectWithKeyValues:data];
            block(mode, nil);
            
        }
        
        
    }];
    return task;
   
    
}

#pragma mark - 查询某届CR委员会委员列表

+ (NSURLSessionDataTask *)getCouncilListInfo:(NSInteger)_id block:(void (^) (id data, NSError *error))block
{
    NSString *host = CRProposalIP;
    NSString *path = @"/api/council/list/";
    NSString *url = [NSString stringWithFormat:@"%@%@%ld", host, path, (long)_id];
    
    NSURLSessionDataTask *task = [ELANetwork GET:url parameters:nil block:^(id data, NSError *error) {
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            
            ELACouncilAndSecretariatModel *mode = [ELACouncilAndSecretariatModel mj_objectWithKeyValues:data];
            block(mode, nil);
            
        }
        
        
    }];
    return task;
}

+ (NSURLSessionDataTask *)getInformation:(NSString *)did ID:(NSInteger)_id block:(void (^) (id data, NSError *error))block
{
    NSString *host = CRProposalIP;
    NSString *path = @"/api/council/information/";
    NSString *url = [NSString stringWithFormat:@"%@%@%@/%ld", host, path, did, (long)_id];
//    /api/council/information/5ebcf259c4a7fe0078148afc/1
    NSURLSessionDataTask *task = [ELANetwork GET:url parameters:nil block:^(id data, NSError *error) {
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            
            ELAInformationDetail *mode = [ELAInformationDetail mj_objectWithKeyValues:data];
            block(mode, nil);

        }
        
        
    }];
    return task;
}


@end
