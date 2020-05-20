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


#import <UIKit/UIKit.h>
#import "HWMBillListModel.h"
#import "HWMDetailsProposalModel.h"
@protocol HWMOpposedProgressHeadViewDelegate <NSObject>

-(void)closeOpposedProgressDetailsOrOpen:(BOOL)isOpen;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HWMOpposedProgressHeadView : UIView
@property(nonatomic,weak)id<HWMOpposedProgressHeadViewDelegate> delegate;
@property(nonatomic,strong)HWMBillListModel *model;
@property(nonatomic,strong)HWMDetailsProposalModel *DetailsProposalM;
@property(assign,nonatomic)BOOL needMakeLine;
@end

NS_ASSUME_NONNULL_END
