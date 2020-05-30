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
#import "HWMCRSuggestionNetWorkManger.h"

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
            if(mode && mode.data.count > 0)
            {
                NSArray *sortedArray = [mode.data sortedArrayUsingComparator:^(ELACommitteeInfoModel *obj1, ELACommitteeInfoModel *obj2){
                    if(obj1.index > obj2.index)
                    {
                        return NSOrderedAscending;
                    }
                    else
                    {
                        return NSOrderedDescending;
                    }
                }];
                mode.data = sortedArray;
            }
//                                        　　//升序，key表示比较的关键字
//                                        　　 if (obj1.key < obj1.key )
//                                        　　{
//                    　　　　 return NSOrderedAscending;
//                    　　}
//                                        　　else
//                                        　　{
//                    　　　　 return NSOrderedDescending;
//                    　　}
//                                        ｝
//                                        }
           
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
    NSString *url = @"";
    if(_id != -1)
    {
        url = [NSString stringWithFormat:@"%@%@%@/%ld", host, path, did, (long)_id];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@%@%@/", host, path, did];
    }
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

+ (NSURLSessionDataTask *)listproducer:(NSString *)state moreInfo:(NSInteger)moreInfo block:(void (^) (id data, NSError *error))block
{
    NSString *url = @"https://unionsquare.elastos.org/api/dposnoderpc/check/listproducer";

    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] init];
    [paramsDic setObject:[NSNumber numberWithLong:moreInfo] forKey:@"moreInfo"];
    [paramsDic setObject:state  forKey:@"state"];
    
    NSURLSessionDataTask *task = [ELANetwork POST:url parameters:paramsDic block:^(id data, NSError *error) {
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            
            block(data, nil);

        }
        
        
    }];
    return task;
}


+ (NSURLSessionDataTask *)listcrcandidates:(NSString *)state  block:(void (^) (id data, NSError *error))block
{
    NSString *url = @"https://unionsquare.elastos.org/api/dposnoderpc/check/listcrcandidates";

    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] init];
    [paramsDic setObject:state  forKey:@"state"];
    
    NSURLSessionDataTask *task = [ELANetwork POST:url parameters:paramsDic block:^(id data, NSError *error) {
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            
            block(data, nil);

        }
        
        
    }];
    return task;
}


//NSDictionary *parameter=@{@"page": @(startIndex),@"results": @(numer),@"status": self.CommunityProposalTypeStringArray[type],@"search":searchString};
//   NSString *bordyUrlString=@"/api/cvote/all_search";
//
//   [HttpUrl NetGETHost:CRProposalIP url:bordyUrlString header:nil body:parameter showHUD:YES WithSuccessBlock:^(id data) {
//       Completed(data);
//   } WithFailBlock:^(id data) {
//
//       Completed(data);
//   }];

+ (NSURLSessionDataTask *)cvoteAllSearch:(NSString *)searchString  page:(NSInteger)page  results:(NSInteger)results type:(CommunityProposalType)type  block:(void (^) (id data, NSError *error))block
{
    NSArray *typeArray = @[@"ALL",@"VOTING",@"NOTIFICATION",@"ACTIVE",@"FINAL",@"REJECTED"];
    
    NSString *host = CRProposalIP;
//    NSString *path = @"/api/cvote/all_search";
    NSString *bordyUrlString =
    [NSString stringWithFormat:@"/api/cvote/all_search?&status=%@", @"ALL"];

    NSString *url = [NSString stringWithFormat:@"%@%@", host, bordyUrlString];
    
    NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] init];
    [paramsDic setValue:typeArray[type]  forKey:@"status"];
    [paramsDic setValue:[NSNumber numberWithLong:page]  forKey:@"page"];
    [paramsDic setValue:[NSNumber numberWithLong:results]  forKey:@"results"];
//    [paramsDic setValue:searchString forKey:@"search"];
    
    NSURLSessionDataTask *task = [ELANetwork GET:url parameters:nil block:^(id data, NSError *error) {
        
        if(error)
        {
            block(nil, error);
        }
        else
        {
            
            
            block(data, nil);

        }
        
        
    }];
    return task;
}
@end
