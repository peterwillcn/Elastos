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
#import "HWMCircleProgressView.h"

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
@property (weak, nonatomic) IBOutlet UILabel *OpposedProgressLabel;
@property (weak, nonatomic) IBOutlet UILabel *OpposingVotesLabel;
@property (strong, nonatomic)HWMCircleProgressView*CircleProgressV;

@end

@implementation HWMOpposedProgressHeadView

-(instancetype)init{
    self=[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMOpposedProgressHeadView" owner:nil options:nil].firstObject;
        self.typeInfoLabel.text=NSLocalizedString(@"提案信息", nil);
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow"] forState:UIControlStateNormal];
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow_fold"] forState:UIControlStateSelected];
        self.TheCurrentNumberLabel.text=NSLocalizedString(@"当前票数", nil);
        self.VetoVoteLabel.text=NSLocalizedString(@"否决通过票数", nil);
        self.OpposedProgressLabel.text=NSLocalizedString(@"反对进度", nil);
        self.userInteractionEnabled=YES;
        [self.OpposedProgressView addSubview:self.CircleProgressV];
        [self.CircleProgressV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.OpposedProgressView);
        }];
    }
    return self;
}
- (IBAction)showOrHiddenEvent:(id)sender {
    self.showOrHiddenButton.selected=!self.showOrHiddenButton.isSelected;
    if ([self.delegate respondsToSelector:@selector(closeOpposedProgressDetailsOrOpen:)]) {
        [self.delegate closeOpposedProgressDetailsOrOpen:self.showOrHiddenButton.isSelected];
    }
}
-(HWMCircleProgressView *)CircleProgressV{
    if (!_CircleProgressV) {
        _CircleProgressV =[[HWMCircleProgressView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_CircleProgressV setBackgroundStrokeColor:RGB(111, 138, 140)];
        [_CircleProgressV setProgressStrokeColor:[UIColor whiteColor]];
        [_CircleProgressV setDigitTintColor:[UIColor whiteColor]];
        [_CircleProgressV setProgressLineWidth:2];
        [_CircleProgressV setBackgroundLineWidth:2];
        [_CircleProgressV setProgress:0.00 animated:YES];
    }
    return _CircleProgressV;
}
-(void)setModel:(HWMBillListModel *)model{
    self.titleLabel.text=model.title;
    self.stateLabel.text=model.status;
    self.timeLabel.text=model.baseInfoString;
        if (self.needMakeLine) {
            [self makeLine];
        }
    _model=model;
}
-(void)makeLine{
    NSUInteger length = [self.titleLabel.text length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)  range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, length)];
    [self.titleLabel setAttributedText:attri];
    
}
-(void)setDetailsProposalM:(HWMDetailsProposalModel *)DetailsProposalM{
    self.OpposingVotesLabel.text=[NSString stringWithFormat:@"%d ELA",[DetailsProposalM.rejectAmount intValue]];
    self.VetoVote.text=[NSString stringWithFormat:@"%d ELA",[DetailsProposalM.rejectHeight intValue]];
    [self.CircleProgressV setProgress:DetailsProposalM.rejectRatio animated:NO];
    
    
}
-(void)showInfo{
    self.showOrHiddenButton.selected=YES;
       [self showOrHiddenEvent:nil];
}
-(void)needClose{
    self.showOrHiddenButton.selected=NO;
    [self showOrHiddenEvent:nil];
}
@end
