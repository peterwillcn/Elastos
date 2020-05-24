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
@property (weak, nonatomic) IBOutlet UIView *makeLineF;

@property (weak, nonatomic) IBOutlet UIView *makeLineT;
@property (weak, nonatomic) IBOutlet UILabel *throughLabel;

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
        
        [self.nextButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [[HMWCommView share]makeBordersWithView:self.nextButton];
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
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}
-(void)setType:(opinionType)type{
    
    if (type== againstType) {
        self.titileLabel.text=NSLocalizedString(@"确认信息", nil);
        self.hasTextInfoLable.text=NSLocalizedString(@"评议哈希", nil);
        self.opinionLabel.text=NSLocalizedString(@"投票意见", nil);
        self.feeTextLabel.text=NSLocalizedString(@"手续费", nil);
        self.opinionStateLabel.text=NSLocalizedString(@" 反对  ", nil);
        self.opinionStateLabel.backgroundColor=RGB(176, 65, 53);
    }else if (type==NOPperatingType){
        self.opinionStateLabel.text=NSLocalizedString(@" 未操作 ", nil);
        self.opinionStateLabel.backgroundColor=RGB(153, 153, 153);
    }else if (type==WaiverType){
        self.titileLabel.text=NSLocalizedString(@"确认信息", nil);
        self.hasTextInfoLable.text=NSLocalizedString(@"评议哈希", nil);
        self.opinionLabel.text=NSLocalizedString(@"投票意见", nil);
        self.feeTextLabel.text=NSLocalizedString(@"手续费", nil);
        self.opinionStateLabel.text=NSLocalizedString(@" 弃权 ", nil);
        self.opinionStateLabel.backgroundColor=RGB(0,0,0);
        
        self.opinionStateLabel.layer.borderWidth=0.5f;
        self.opinionStateLabel.layer.borderColor=[UIColor whiteColor].CGColor;
        self.opinionStateLabel.layer.masksToBounds=YES;
    }else if (type==favorType){
        self.titileLabel.text=NSLocalizedString(@"确认信息", nil);
        self.hasTextInfoLable.text=NSLocalizedString(@"评议哈希", nil);
        self.opinionLabel.text=NSLocalizedString(@"投票意见", nil);
        self.feeTextLabel.text=NSLocalizedString(@"手续费", nil);
        self.opinionStateLabel.text=NSLocalizedString(@" 赞成 ", nil);
        self.opinionStateLabel.backgroundColor=RGB(53, 176, 143);
        
    }else if (type==OpposingVotesType){
        self.hasTextInfoLable.text=NSLocalizedString(@"提案哈希", nil);
        self.opinionLabel.text=NSLocalizedString(@"反对票数", nil);
        self.opinionStateLabel.backgroundColor=[UIColor clearColor];
        [[HMWCommView share]makeBordersWithView:self.opinionStateLabel withCRRound:0.f];
        
    }else if (type==ProposalLeadType){
        self.titileLabel.text=NSLocalizedString(@"确认信息", nil);
        self.hasTextInfoLable.text=NSLocalizedString(@"反馈哈希", nil);
        self.opinionLabel.alpha=0.f;
        self.opinionStateLabel.alpha=0.f;
        self.makeLineF.alpha=0.f;
        self.makeLineT.alpha=0.f;
        self.feeLabel.alpha=0.f;
        self.feeTextLabel.alpha=0.f;
        [self.nextButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
        
    }else if (type==SecretaryGeneType){
        
        self.titileLabel.text=NSLocalizedString(@"确认信息", nil);
        self.hasTextInfoLable.text=NSLocalizedString(@"审核哈希", nil);
        //        self.opinionStateLabel.text=NSLocalizedString(@"  否决   ", nil);
        //        self.throughLabel.text=NSLocalizedString(@"  通过   ", nil);
        //        self.throughLabel.alpha=1.f;
        //        self.opinionStateLabel.backgroundColor=RGB(176, 65, 53);
        //        self.opinionStateLabel.userInteractionEnabled=YES;
        //        [[HMWCommView share]makeBordersWithView:self.throughLabel withCRRound:3.f];
        //        self.throughLabel.backgroundColor=RGB(53, 176, 143);
        //        self.throughLabel.userInteractionEnabled=YES;
        [[HMWCommView share]makeBordersWithView:self.nextButton];
        
//        [self.opinionStateLabel addGestureRecognizer:vetoTap];
        
    }else if (type==withdrawaType){
        self.titileLabel.text=NSLocalizedString(@"交易详情", nil);
        self.hasTextInfoLable.text=NSLocalizedString(@"提款地址", nil);
        self.feeTextLabel.text=NSLocalizedString(@"手续费", nil);
        self.opinionLabel.text=NSLocalizedString(@"金额", nil);
        self.opinionStateLabel.backgroundColor=[UIColor clearColor];
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
-(void)postWithHash:(NSString*)hash withVotes:(NSString*)votes withFee:(NSString*)fee{
    if (self.type==OpposingVotesType) {
        self.hasLabel.text=hash;
        self.opinionStateLabel.text=[votes stringByAppendingString:@" ELA"];
        self.feeLabel.text=fee;
    }else if (self.type==ProposalLeadType){
        self.hasLabel.text=hash;
    }else if (self.type==SecretaryGeneType){
        self.hasLabel.text=hash;
        self.feeLabel.text=fee;
    }else if (self.type==withdrawaType){
        self.hasLabel.text=hash;
        self.opinionStateLabel.text=[votes stringByAppendingString:@" ELA"];
        
        if ([votes isEqualToString:@"1"]) {
            
            self.opinionStateLabel.text=NSLocalizedString(@"  通过   ", nil);
            self.opinionStateLabel.backgroundColor=RGB(53, 176, 143);
        }else{
            self.opinionStateLabel.text=NSLocalizedString(@"  否决   ", nil);
            self.opinionStateLabel.backgroundColor=RGB(176, 65, 53);
        }
        self.feeLabel.text=fee;
    }else if (self.type==favorType){
        self.hasLabel.text=hash;
        self.feeLabel.text=fee;
    }else if (self.type==againstType){
        self.hasLabel.text=hash;
        self.feeLabel.text=fee;
    }else if (self.type==NOPperatingType){
        self.hasLabel.text=hash;
        self.feeLabel.text=fee;
    }else if (self.type==WaiverType){
        self.hasLabel.text=hash;
        self.feeLabel.text=fee;
    }else if (self.type==WaiverType){
        self.hasLabel.text=hash;
        self.feeLabel.text=fee;
    }
    
}

@end
