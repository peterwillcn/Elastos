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


#import "ELAVotingProcessUtil.h"
#import "ELANetwork.h"
#import "ELAUtils.h"
#import "HWMCRSuggestionNetWorkManger.h"
#import "ELWalletManager.h"

@interface ELAVotingProcessUtil ()

@property (nonatomic, strong) NSMutableDictionary *producers;
@property (nonatomic, strong) NSMutableDictionary *CRCValueDic;
@property (nonatomic, strong) NSMutableDictionary *ProposalValueDic;
@property (nonatomic, strong) NSMutableDictionary *CRCImpeachmentDic;

@property (nonatomic, strong) NSString *masterWalletID;

@property (nonatomic, strong) NSMutableArray *networkState;
@end

@implementation ELAVotingProcessUtil

+ (ELAVotingProcessUtil *)shareVotingProcess
{
    static ELAVotingProcessUtil *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ELAVotingProcessUtil alloc] init];
        manager.networkState = [[NSMutableArray alloc] init];
    });
    
    return manager;
}

- (void)getVoteInfo
{
    FLWallet *wallet = [ELWalletManager share].currentWallet;
    _masterWalletID = wallet.masterWalletID;
    [self CRCImpeachment];
    [self asyncGetData];
    
}
- (void)CRCImpeachment
{
    _CRCImpeachmentDic = [[NSMutableDictionary alloc] init];
    NSArray *CRCImpeachment = [[ELWalletManager share] getVoteInfoList:_masterWalletID :@"CRCImpeachment"];
    if(CRCImpeachment && CRCImpeachment.count > 0)
    {
        NSDictionary *dic = CRCImpeachment[0];
        NSDictionary *votes = dic[@"Votes"];//spv返回数据
        [_CRCImpeachmentDic setValue:votes forKey:@"votes"];
    }
    else
    {
        _CRCImpeachmentDic = nil;
    }
}
- (void)delegateData:(NSArray *)array dpos:(NSArray *)dposArray
{
    if(array == nil || array.count <= 0)
    {
        _producers = nil;
        return;
    }
   NSDictionary *dic = array[0];
   
   NSMutableDictionary *voteDic = [[NSMutableDictionary alloc] init];
   NSMutableArray *candidatesArray = [[NSMutableArray alloc] init];
   NSMutableDictionary *candidatesDic = [[NSMutableDictionary alloc] init];
   NSString *type = dic[@"Type"];
   //    NSString *amount = dic[@"Amount"];
   NSDictionary *votes = dic[@"Votes"];//spv返回数据
   for (NSString *key in votes)//用key取值
   {
       NSString *value = votes[key];
       if(dposArray && dposArray.count > 0)
       {
           for (NSDictionary *dic in dposArray)//网路数组获取每个字典
           {
               NSString *cid = dic[@"ownerpublickey"];//取字典中cid
               NSString *state = dic[@"code"];//取字典中code
               if([key isEqualToString:cid])//key 与 cid 相同
               {
                   if([state isEqualToString:@"Active"])//有效
                   {
                       [voteDic setValue:value forKey:key]; //添加到有效字典
                   }
                   else
                   {
                       [candidatesArray addObject:key];//无效的key 添加到数组
                   }
                   break;
               }
           }
           [candidatesDic setValue:type forKey:@"Type"];
           [candidatesDic setValue:candidatesArray forKey:@"Candidates"]; //添加到无效字典
       }
       else
       {
           [voteDic addEntriesFromDictionary:votes];
       }
   }
   _producers = [[NSMutableDictionary alloc]  init];
   [_producers setValue:candidatesDic forKey:@"inCandidates"];
   [_producers setValue:voteDic forKey:@"votes"];
}

- (void)Proposal:(NSArray *)array proposalArray:(NSArray *)proposalArray
{
    
    if(array == nil || array.count <= 0)
    {
        _ProposalValueDic = nil;
        return;
    }
    NSDictionary *dic = array[0];
    
    NSMutableDictionary *voteDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *candidatesArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *candidatesDic = [[NSMutableDictionary alloc] init];
    NSString *type = dic[@"Type"];
    //    NSString *amount = dic[@"Amount"];
    NSDictionary *votes = dic[@"Votes"];//spv返回数据
    for (NSString *key in votes)//用key取值
    {
        NSString *value = votes[key];
        if(proposalArray && proposalArray.count > 0)
        {
            for (NSDictionary *dic in proposalArray)//网路数组获取每个字典
            {
                NSString *cid = dic[@"proposalHash"];//取字典中cid
                NSString *state = dic[@"code"];//取字典中code
                if([key isEqualToString:cid])//key 与 cid 相同
                {
                    if([state isEqualToString:@"Active"])//有效
                    {
                        [voteDic setValue:value forKey:key]; //添加到有效字典
                    }
                    else
                    {
                        [candidatesArray addObject:key];//无效的key 添加到数组
                    }
                    break;
                }
            }
            [candidatesDic setValue:type forKey:@"Type"];
            [candidatesDic setValue:candidatesArray forKey:@"Candidates"]; //添加到无效字典
        }
        else
        {
            [voteDic addEntriesFromDictionary:votes];
        }
    }
    _ProposalValueDic = [[NSMutableDictionary alloc]  init];
    [_ProposalValueDic setValue:candidatesDic forKey:@"inCandidates"];
    [_ProposalValueDic setValue:voteDic forKey:@"votes"];
}
- (void)CRC:(NSArray *)array crcArray:(NSArray *)crcArray
{
    
    if(array == nil || array.count <= 0)
    {
        _CRCValueDic = nil;
        return;
    }
    NSDictionary *dic = array[0];
    
    NSMutableDictionary *voteDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *candidatesArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *candidatesDic = [[NSMutableDictionary alloc] init];
    NSString *type = dic[@"Type"];
//    NSString *amount = dic[@"Amount"];
    NSDictionary *votes = dic[@"Votes"];
    for (NSString *key in votes)//用key取值
    {
        NSString *value = votes[key];
        if(crcArray && crcArray.count > 0)
        {
            for (NSDictionary *dic in crcArray)//网路数组获取每个字典
            {
                NSString *cid = dic[@"cid"];//取字典中cid
                NSString *state = dic[@"code"];//取字典中code
                if([key isEqualToString:cid])//key 与 cid 相同
                {
                    if([state isEqualToString:@"Active"])//有效
                    {
                        [voteDic setValue:value forKey:key]; //添加到有效字典
                    }
                    else
                    {
                        [candidatesArray addObject:key];//无效的key 添加到数组
                    }
                    break;
                }
            }
            [candidatesDic setValue:type forKey:@"Type"];
            [candidatesDic setValue:candidatesArray forKey:@"Candidates"]; //添加到无效字典
        }
        else
        {
            [voteDic addEntriesFromDictionary:votes];
        }
    }
    _CRCValueDic = [[NSMutableDictionary alloc]  init];
    [_CRCValueDic setValue:candidatesDic forKey:@"inCandidates"];
    [_CRCValueDic setValue:voteDic forKey:@"votes"];
}

- (void)asyncGetData
{
    if(_networkState)
    {
        [_networkState removeAllObjects];
    }
    ELAWeakSelf;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //dpos
        NSArray *Delegate = [[ELWalletManager share] getVoteInfoList:weakSelf.masterWalletID :@"Delegate"];
        if(Delegate.count < 0)
        {
            [weakSelf.networkState addObject:@"success"];
            weakSelf.producers = nil;
            dispatch_group_leave(group);
        }
        else
        {
            [ELANetwork listproducer:@"all" moreInfo:1 block:^(id  _Nonnull data, NSError * _Nonnull error){
                
                if(error)
                {
                    [weakSelf.networkState addObject:@"fail"];
                    if(error.code == -999)
                    {
                        //已取消
                    }
                    else
                    {
                    }
                }
                else
                {
                    [weakSelf.networkState addObject:@"success"];
                    NSDictionary *result = data[@"result"];
                    NSArray *array = result[@"producers"];
                    [self delegateData:Delegate dpos:array];
                }
                dispatch_group_leave(group);
                
            }];
        }

    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSLog(@"request CRC");
        //CRC
        NSArray *CRC = [[ELWalletManager share] getVoteInfoList:weakSelf.masterWalletID :@"CRC"];
        if(CRC.count < 0)
        {
            [weakSelf.networkState addObject:@"success"];
            weakSelf.CRCValueDic = nil;
            dispatch_group_leave(group);
        }
        else
        {
            [ELANetwork listcrcandidates:@"all" block:^(id  _Nonnull data, NSError * _Nonnull error){

                if(error)
                {
                    [weakSelf.networkState addObject:@"fail"];
                    if(error.code == -999)
                    {
                        //已取消
                    }
                    else
                    {
                    }
                }
                else
                {
                    [weakSelf.networkState addObject:@"success"];
                    NSDictionary *result = data[@"data"][@"result"];
                    if(result)
                    {
                        NSArray *array = result[@"crcandidatesinfo"];
                        [self CRC:CRC crcArray:array];
                    }
                }
                dispatch_group_leave(group);

            }];
        }
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSLog(@"request proposal");
        NSArray *CRCProposal = [[ELWalletManager share] getVoteInfoList:weakSelf.masterWalletID :@"CRCProposal"];
        if(CRCProposal.count < 0)
        {
            [weakSelf.networkState addObject:@"success"];
            weakSelf.ProposalValueDic = nil;
            dispatch_group_leave(group);
        }
        else
        {
            [ELANetwork cvoteAllSearch:@"" page:0 results:100 type:NOTIFICATIONType block:^(id  _Nonnull data, NSError * _Nonnull error){

                if(error)
                {
                    [weakSelf.networkState addObject:@"fail"];
                    if(error.code == -999)
                    {
                        //已取消
                    }
                    else
                    {
                    }
                }
                else
                {
                    [weakSelf.networkState addObject:@"success"];
                    NSDictionary *result = data[@"data"];
                    if(result)
                    {
                        NSArray *array = result[@"list"];
                        [self Proposal:CRCProposal proposalArray:array];
                    }
                }
                dispatch_group_leave(group);

            }];
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        BOOL result = YES;
        for (NSString *state in weakSelf.networkState)
        {
            if([state isEqualToString:@"fail"])
            {
                //失败
                result = NO;
                break;
            }
        }
        [weakSelf networkState:result];
       
    });

}

- (void)networkState:(BOOL)result
{
    if(_networkStateBlock)
    {
        _networkStateBlock(result);
    }
}

- (void)getImpeachmentWithNetworkState:(NSString *)hash amount:(NSString *)amount
{
    NSMutableArray *invalidCandidates = [[NSMutableArray alloc] init];
    NSMutableDictionary *votes = [[NSMutableDictionary alloc] init];
    if(_producers && _producers.count > 0)
    {
        
//        NSDictionary *voteDic = _producers[@"votes"];
        NSDictionary *candidatesDic = _producers[@"inCandidates"];
        
        [invalidCandidates addObject:candidatesDic];
        
    }
    else
    {
        
    }
    
    if(_CRCValueDic && _CRCValueDic.count > 0)
    {
        
//        NSDictionary *voteDic = _CRCValueDic[@"votes"];
        NSDictionary *candidatesDic = _CRCValueDic[@"inCandidates"];
        [invalidCandidates addObject:candidatesDic];
        
    }
    else
    {
        
    }
    
    if(_ProposalValueDic && _ProposalValueDic.count > 0)
    {
        
//        NSDictionary *voteDic = _ProposalValueDic[@"votes"];
        NSDictionary *candidatesDic = _ProposalValueDic[@"inCandidates"];
        [invalidCandidates addObject:candidatesDic];
        
    }
    else
    {
        
    }
    if(_CRCImpeachmentDic && _CRCImpeachmentDic.count > 0)
    {
        NSDictionary *voteDic = _CRCImpeachmentDic[@"votes"];
        NSDictionary *candidatesDic = _CRCImpeachmentDic[@"inCandidates"];
        [invalidCandidates addObject:candidatesDic];
        [votes addEntriesFromDictionary:voteDic];
        
        [votes setValue:amount forKey:hash];
        
    }
    else
    {
        [votes setValue:amount forKey:hash];
    }
    if(_getImpeachmentBlock)
    {
        _getImpeachmentBlock(votes, invalidCandidates);
    }
}

@end
