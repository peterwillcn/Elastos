//
//  HMWtransferDetailsPopupView.m
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtransferDetailsPopupView.h"
#import "HMWpwdPopupView.h"

@interface HMWtransferDetailsPopupView ()<HMWpwdPopupViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *theAmountOfLabel;
@property (weak, nonatomic) IBOutlet UILabel *poundageLabel;
@property (weak, nonatomic) IBOutlet UIButton *theNextStepButton;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWpwdPopupView *pwdPopupV;
@property (weak, nonatomic) IBOutlet UILabel *theExchangeRateTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *theExchangeRateLabel;
@property (weak, nonatomic) IBOutlet UIView *theExchangeRateMakeLineView;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferTheAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *theAmountOfTextLabel;

@end


@implementation HMWtransferDetailsPopupView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWtransferDetailsPopupView" owner:nil options:nil].firstObject;
   
        [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
        self.feeLabel.text=NSLocalizedString(@"手续费", nil);
        self.transferDetailsLabel.text=NSLocalizedString(@"交易详情", nil);
        
        self.transferTheAddressLabel.text=NSLocalizedString(@"转账地址", nil);
        self.theAmountOfTextLabel.text=NSLocalizedString(@"金额", nil);
        [self.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
        self.theExchangeRateTextLabel.text=NSLocalizedString(@"汇率", nil);

    }
    
    return self;
    
    
}
-(HMWpwdPopupView *)pwdPopupV{
    if (!_pwdPopupV) {
        _pwdPopupV=[[HMWpwdPopupView alloc]init];
        _pwdPopupV.delegate=self;
    }
    return _pwdPopupV;
    
}
- (IBAction)closeEvent:(id)sender {
    
    if ([self.delegate performSelector:@selector(closeThePage)]) {
        [self.delegate closeThePage];
    }
    
}
- (IBAction)theNextStepEvent:(id)sender {
    if (self.type==readOnlyWallettransfer_type) {
        if (self.delegate) {
            [self.delegate pwdAndInfoWithPWD:nil];
            [self cancelThePWDPageView];
        }
        return;
    }
  self.theNextStepButton.userInteractionEnabled=NO;
    
    
    [self addSubview:self.pwdPopupV];
    [self.pwdPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
  self.theNextStepButton.userInteractionEnabled=YES;
    
}


-(void)makeSureWithPWD:(NSString*)pwd{
    if (pwd.length==0) {
        return;
    }
    if (self.delegate) {
        [self.delegate pwdAndInfoWithPWD:pwd];
//        [self cancelThePWDPageView];
    }
    
}






-(void)cancelThePWDPageView{
    [self.pwdPopupV removeFromSuperview];
    
    self.pwdPopupV=nil;
    
    
}
-(void)transferDetailsWithToAddress:(NSString*)address withTheAmountOf:(NSString*)amount withFee:(NSString*)fee{
    self.addressLabel.text=address;
    self.theAmountOfLabel.text=amount;
    self.poundageLabel.text=fee;
    
    
    
}
-(void)setType:(transferDetailsPopupViewType)type{
    _type=type;
    if (type==sideChainTop_UpType) {
        self.theExchangeRateTextLabel.alpha=1.f;
        self.theExchangeRateLabel.alpha=1.f;
       self.theExchangeRateMakeLineView.alpha=1.f;
    }
    
    
}
@end
