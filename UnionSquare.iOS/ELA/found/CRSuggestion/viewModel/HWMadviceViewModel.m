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


#import "HWMadviceViewModel.h"

@implementation HWMadviceViewModel
-(HWMadviceModel*)AnalyticalDataWithDicJosn:(id)json{
    HWMadviceModel *model=[HWMadviceModel modelWithJSON:json];
    model.baseInfoString=[NSString stringWithFormat:@"#%@ %@ %@",model.ID ,[[FLTools share]YMDHMSgetTimeFromTimesTamp:model.createdAt],model.didName];
    model.baseInfoCell=[[FLTools share]calculateRowHeight:model.title fontSize:14 withmargin:30];
    model.absCell=[[FLTools share]calculateRowHeight:model.abs fontSize:11 withmargin:30];

    return model;
}
-(void)detailsProposalModelDataJosn:( _Nonnull  id)json completion:(_Nonnull adviceBlock)completionBlock{
    
    HWMadviceModel *model= [self AnalyticalDataWithDicJosn:json];
    completionBlock(model);
}

@end
