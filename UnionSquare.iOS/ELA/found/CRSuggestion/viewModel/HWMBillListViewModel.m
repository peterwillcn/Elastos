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


#import "HWMBillListViewModel.h"
#import "HWMBillListModel.h"
@interface HWMBillListViewModel (){
    dispatch_queue_t  Analyticalqueue_t;
    
}

@end
@implementation HWMBillListViewModel
-(instancetype)init{
    self= [super init];
    if (self) {
        Analyticalqueue_t=dispatch_queue_create("HWMBillListViewModel",DISPATCH_QUEUE_SERIAL);
        
    }
    return self;
}
-(void)BillListWithDataJosn:(id)json completion:(_Nonnull BillListBlock)completionBlock {
    dispatch_async(Analyticalqueue_t, ^{
        NSArray *dataArray= [self AnalyticalDataWithDicJosn:json];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(dataArray);
            
        });
    });
}
-(NSArray*)AnalyticalDataWithDicJosn:(id)json{
    NSArray *modeArray=[NSArray modelArrayWithClass:[HWMBillListModel class] json:json];
    NSMutableArray *AnalyticalArray=[[NSMutableArray alloc]init];
    for (HWMBillListModel *model in modeArray) {
        model.baseInfoString=[NSString stringWithFormat:@"#%@ %@ %@",model.ID ,[[FLTools share]YMDHMSgetTimeFromTimesTamp:model.createdAt],model.proposedBy];
        if (self.searchString) {
            model.searchRanege=[model.title localizedStandardRangeOfString:self.searchString];
        }
        if ([model.status isEqualToString:@"VOTING"]) {
            model.status=NSLocalizedString(@"委员评议",nil);
        }else if ([model.status isEqualToString:@"NOTIFICATION"]){
            model.status=NSLocalizedString(@"公示中",nil);
        }else if ([model.status isEqualToString:@"ACTIVE"]){
            model.status=NSLocalizedString(@"执行中",nil);
        }else if ([model.status isEqualToString:@"FINAL"]){
            model.status=NSLocalizedString(@"已完成",nil);
        }else if ([model.status isEqualToString:@"REJECTED"]){
            model.status=NSLocalizedString(@"已废止",nil);
        }else if ([model.status isEqualToString:@"REJECTED"]){
            model.status=NSLocalizedString(@"未通过",nil);
        }else if ([model.status isEqualToString:@"VETOED"]){
            model.status=NSLocalizedString(@"已否决",nil);
        }
        model.cellHeight=[[FLTools share]calculateRowHeight:model.title fontSize:14 withmargin:30];
        if (model.cellHeight>60) {
            model.cellHeight=60;
        }
        [AnalyticalArray addObject:model];
    }
    return AnalyticalArray;
}

@end
