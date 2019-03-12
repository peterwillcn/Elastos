//
//  FLJoinToChoseTransferInfoView.m
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/2/13.
//

#import "FLJoinToChoseTransferInfoView.h"

@implementation FLJoinToChoseTransferInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)defultView{
    FLJoinToChoseTransferInfoView *view =[[NSBundle mainBundle]loadNibNamed:@"FLJoinToChoseTransferInfoView" owner:nil options:nil].firstObject;
    view.titleLab.text =NSLocalizedString(@"报名押金", nil);
    view.tagTitleLab.text = NSLocalizedString(@"金额", nil);
    view.TagfeeLab.text = NSLocalizedString(@"手续费", nil);
    [view.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];

    return view;
}
- (IBAction)theNextStepEvent:(id)sender {
    if (self.delegate) {
        [self.delegate nextBtnAction];
    }
}
- (IBAction)dismiss:(id)sender {
    [self removeFromSuperview];

}

-(void)transferDetailsWithTheAmountOf:(NSString*)amount withFee:(NSString*)fee{
    self.poundageLabel.text = fee;
    self.theAmountOfLabel.text = amount;
}
@end
