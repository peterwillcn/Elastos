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


#import "HWMCRProposalConfirmView.h"
#import "HMWpwdPopupView.h"
@interface HWMCRProposalConfirmView ()<HMWpwdPopupViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasTextInfoLable;
@property (weak, nonatomic) IBOutlet UILabel *hasLabel;
@property (weak, nonatomic) IBOutlet UILabel *opinionLabel;
@property (weak, nonatomic) IBOutlet UILabel *opinionStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property(strong,nonatomic)HMWpwdPopupView *pwdView;


@end

@implementation HWMCRProposalConfirmView

-(instancetype)init{
    self=[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMCRProposalConfirmView" owner:nil options:nil].firstObject;
        
        self.titileLabel.text=NSLocalizedString(@"确认信息", nil);
        self.hasTextInfoLable.text=NSLocalizedString(@"评议哈希", nil);
        self.opinionLabel.text=NSLocalizedString(@"投票意见", nil);
        self.feeTextLabel.text=NSLocalizedString(@"手续费", nil);
        [[HMWCommView share]makeBordersWithView:self.opinionStateLabel withCRRound:3.f];
        [[HMWCommView share]makeBordersWithView:self.nextButton];
        [self.nextButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [self setType:againstType];
        
    }
    return self;
}
- (IBAction)closeEvent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(closeCRProposalConfirmView)]) {
        [self.delegate closeCRProposalConfirmView];
    }
}
- (IBAction)nextPWDEvent:(id)sender {
    [self addSubview:self.pwdView];
}
-(void)setType:(opinionType)type{

    if (type== againstType) {
        self.opinionStateLabel.text=NSLocalizedString(@" 反对  ", nil);
   self.opinionStateLabel.backgroundColor=RGB(176, 65, 53);
    }else if (type==NOPperatingType){
        self.opinionStateLabel.text=NSLocalizedString(@" 未操作 ", nil);
        self.opinionStateLabel.backgroundColor=RGB(153, 153, 153);
    }else if (type==WaiverType){
        self.opinionStateLabel.text=NSLocalizedString(@" 弃权 ", nil);
       self.opinionStateLabel.backgroundColor=RGB(0,0,0);
       
        self.opinionStateLabel.layer.borderWidth=0.5f;
        self.opinionStateLabel.layer.borderColor=[UIColor whiteColor].CGColor;
        self.opinionStateLabel.layer.masksToBounds=YES;
    }else if (type==favorType){
        self.opinionStateLabel.text=NSLocalizedString(@" 赞成 ", nil);
      self.opinionStateLabel.backgroundColor=RGB(53, 176, 143);
        
    }else if (type==favorType){
        self.opinionLabel.text=NSLocalizedString(@"反对票数", nil);
        self.opinionStateLabel.text=NSLocalizedString(@"ELA ", nil);
        self.opinionStateLabel.backgroundColor=[UIColor clearColor];
        [[HMWCommView share]makeBordersWithView:self.opinionStateLabel withCRRound:0.f];
        
    }
    
    _type=type;
    
}

-(HMWpwdPopupView *)pwdView{
    
    if (!_pwdView) {
        _pwdView=[[HMWpwdPopupView alloc]init];
        _pwdView.delegate=self;
    }
    return _pwdView;
}
-(void)makeSureWithPWD:(NSString*)pwd{
    if ([self.delegate respondsToSelector:@selector(CRProposalConfirmWithPWD:)]) {
           [self.delegate CRProposalConfirmWithPWD:pwd];
       }
}

-(void)cancelThePWDPageView{
    [self.pwdView removeFromSuperview];
    self.pwdView=nil;
}

@end
