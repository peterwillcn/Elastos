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


#import "HWMOpposedProgressHeadView.h"

@interface HWMOpposedProgressHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *showOrHiddenButton;
@property (weak, nonatomic) IBOutlet UIView *OpposedProgressView;
@property (weak, nonatomic) IBOutlet UILabel *TheCurrentNumberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TheCurrentNumber;
@property (weak, nonatomic) IBOutlet UILabel *VetoVoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *VetoVote;

@end

@implementation HWMOpposedProgressHeadView

-(instancetype)init{
    self=[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMCommentPerioDetailsHeadView" owner:nil options:nil].firstObject;
        self.typeInfoLabel.text=NSLocalizedString(@"提案信息", nil);
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow"] forState:UIControlStateNormal];
         [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow_fold"] forState:UIControlStateSelected];
        self.TheCurrentNumberLabel.text=NSLocalizedString(@"当前票数", nil);
        self.VetoVoteLabel.text=NSLocalizedString(@"否决通过票数", nil);
    }
    return self;
}
- (IBAction)showOrHiddenEvent:(id)sender {
}


@end
