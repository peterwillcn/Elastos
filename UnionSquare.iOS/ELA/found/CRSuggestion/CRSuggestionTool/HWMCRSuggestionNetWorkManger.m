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


#import "HWMCRSuggestionNetWorkManger.h"

@interface HWMCRSuggestionNetWorkManger()
@property(nonatomic,strong)NSArray *CommunityProposalTypeStringArray;
@end

static HWMCRSuggestionNetWorkManger* _instatance;
@implementation HWMCRSuggestionNetWorkManger
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instatance==nil) {
            _instatance=[super allocWithZone:zone];
        }
    });
    return _instatance;
}
+(instancetype)shareCRSuggestionNetWorkManger{
    return [[self alloc]init];
}
-(id)copyWithZone:(NSZone *)zone
{
    return _instatance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instatance;
}

-(void)reloadCRSuggestionDataSourceWithType:(CommunityProposalType)type withStartIndex:(NSInteger)startIndex withNumbers:(NSInteger)numer withComplete:(_Nonnull CRSuggestionNetWorkComplete)Completed{
    if (numer<1) {
        numer=10;
    }
    NSString *bordyUrlString=[NSString stringWithFormat:@"/api/cvote/all_search?page=%ld&results=%ld&status=%@",startIndex,(long)numer,self.CommunityProposalTypeStringArray[type]];
    
    [HttpUrl NetGETHost:CRProposalIP url:bordyUrlString header:nil body:nil showHUD:YES WithSuccessBlock:^(id data) {
        Completed(data);
    } WithFailBlock:^(id data) {
        
        Completed(data);
    }];
    
}
- (NSArray *)CommunityProposalTypeStringArray{
    if (!_CommunityProposalTypeStringArray) {
        _CommunityProposalTypeStringArray=@[@"ALL",@"VOTING",@"NOTIFICATION",@"ACTIVE",@"FINAL",@"REJECTED"];
    }
    return _CommunityProposalTypeStringArray;
}
-(void)searchReloadCRSuggestionDataSourceWithType:(CommunityProposalType)type withStartIndex:(NSInteger)startIndex withNumbers:(NSInteger)numer withSearchContent:(NSString*)searchString withComplete:(_Nonnull CRSuggestionNetWorkComplete)Completed{
    if (numer<1) {
        numer=10;
    }
    
    NSDictionary *parameter=@{@"page": @(startIndex),@"results": @(numer),@"status": self.CommunityProposalTypeStringArray[type],@"search":searchString};
    NSString *bordyUrlString=@"/api/cvote/all_search";
    
    [HttpUrl NetGETHost:CRProposalIP url:bordyUrlString header:nil body:parameter showHUD:YES WithSuccessBlock:^(id data) {
        Completed(data);
    } WithFailBlock:^(id data) {
        
        Completed(data);
    }];
    
}
-(void)reloadCRSuggestionDetailsWithID:(NSString*)ID withComplete:(_Nonnull CRSuggestionNetWorkComplete)Completed{
    
    
    NSString *bordyUrlString=[NSString stringWithFormat:@"/api/cvote/get_proposal/%@",ID];
    
    [HttpUrl NetGETHost:CRProposalIP url:bordyUrlString header:nil body:nil showHUD:YES WithSuccessBlock:^(id data) {
        NSLog(@"详情数据---%@",data);
        Completed(data);
    } WithFailBlock:^(id data) {
        Completed(data);
    }];
}
-(void)reloadCRAdviceDetailsWithID:(NSString*)ID withComplete:(_Nonnull CRSuggestionNetWorkComplete)Completed{
    [[FLTools share]showLoadingView];
    NSString *bordyUrlString=[NSString stringWithFormat:@"/api/suggestion/get_suggestion/%@",ID];
    [HttpUrl NetGETHost:CRProposalIP url:bordyUrlString header:nil body:nil showHUD:YES WithSuccessBlock:^(id data) {
        Completed(data);
        [[FLTools share]hideLoadingView];
    } WithFailBlock:^(id data) {
    }];
}
-(void)reloadSecretaryGeneralAndMembersDetailsWithID:(NSString*)ID withDIDString:(NSString*)didString withComplete:(_Nonnull CRSuggestionNetWorkComplete)Completed{
    didString=[didString stringByReplacingOccurrencesOfString:@"did:elastos:" withString:@""];
      NSString *bordyUrlString=[NSString stringWithFormat:@"/api/council/information/%@",didString];
    if (ID.length>0) {
        [bordyUrlString stringByAppendingString:[NSString stringWithFormat:@"/%@",ID]];
    }
  
    [HttpUrl NetGETHost:CRProposalIP url:bordyUrlString header:nil body:nil showHUD:YES WithSuccessBlock:^(id data) {
        Completed(data);
    } WithFailBlock:^(id data) {
    }];
}
@end
