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
//    if (Fmodel.tracking.count>0) {
//        NSMutableArray *trackModel=[[NSMutableArray alloc]init];
////        for (HWMVoteResultModel *model in Fmodel.tracking) {
////            model.comment=
//            [trackModel addObject:model];
//        }
//         model.trackModel=[HWMVoteResultModel modelWithJSON:[]]
//    }
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
