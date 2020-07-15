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


#import "HWMDetailsProposalViewModel.h"


@interface HWMDetailsProposalViewModel (){
    dispatch_queue_t  Analyticalqueue_t;
}
@end

@implementation HWMDetailsProposalViewModel
-(instancetype)init{
    self= [super init];
    if (self) {
        Analyticalqueue_t=dispatch_queue_create("HWMDetailsProposalViewModel",DISPATCH_QUEUE_SERIAL);
    }
    return self;
}
-(HWMDetailsProposalModel*)AnalyticalDataWithDicJosn:(id)json{
    HWMDetailsProposalModel *Fmodel=[HWMDetailsProposalModel modelWithJSON:json];
    Fmodel.abstractCell=[[FLTools share]calculateRowHeight:Fmodel.abstract fontSize:11 withmargin:30];
    Fmodel.duration=[[FLTools share]RemainingTimeFormatting:Fmodel.duration];
    Fmodel.rejectHeight=[[FLTools share]isEmptyString:Fmodel.rejectHeight];
    Fmodel.rejectAmount=[[FLTools share]isEmptyString:Fmodel.rejectAmount];
    Fmodel.voteResult=[NSArray modelArrayWithClass:[HWMVoteResultModel class] json:json[@"voteResult"]];
    Fmodel.agreeResult=[[NSMutableArray alloc]init];
    Fmodel.againstResult=[[NSMutableArray alloc]init];
    Fmodel.waiverResult=[[NSMutableArray alloc]init];
    for (HWMVoteResultModel *model in Fmodel.voteResult) {
        model.reasonCell=[[FLTools share]calculateRowHeight:model.reason fontSize:12 withmargin:30];
        if ([model.value isEqualToString:@"support"]) {
            [Fmodel.agreeResult addObject:model];
        }else if([model.value isEqualToString:@"reject"]) {
            [Fmodel.againstResult addObject:model];
        }else if([model.value isEqualToString:@"abstention"]){
            [Fmodel.waiverResult addObject:model];
        }
    }
    if (Fmodel.tracking.count>0) {
        Fmodel.trackingResult=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in Fmodel.tracking) {
            HWMVoteResultModel *VoteRModel=[HWMVoteResultModel modelWithJSON:dic];
            VoteRModel.createdAt=[[FLTools share]YMDHMSgetTimeFromTimesTamp:VoteRModel.createdAt];
            VoteRModel.commentModel=[HWMcommentModel  modelWithJSON:VoteRModel.comment];
             VoteRModel.commentModel.createdAt=[[FLTools share]YMDHMSgetTimeFromTimesTamp: VoteRModel.commentModel.createdAt];
            VoteRModel.commentModel.reasonCell=[[FLTools share]calculateRowHeight:VoteRModel.commentModel.content fontSize:12 withmargin:40];
            VoteRModel.reasonCell=[[FLTools share]calculateRowHeight:VoteRModel.content fontSize:12 withmargin:30];
            [Fmodel.trackingResult addObject:VoteRModel];
            
            
        }
        
    }
    //    if (model.summary.count>0) {
    ////          model.summary=[HWMVoteResultModel modelWithJSON:[]]
    //    }
    return Fmodel;
}
-(void)detailsProposalModelDataJosn:( _Nonnull  id)json completion:(_Nonnull DetailsProposalBlock)completionBlock{
    HWMDetailsProposalModel *model= [self AnalyticalDataWithDicJosn:json];
    completionBlock(model);
}
@end
