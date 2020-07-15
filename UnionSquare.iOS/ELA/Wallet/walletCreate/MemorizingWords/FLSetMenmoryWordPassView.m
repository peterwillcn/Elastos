//
//  FLSetMenmoryWordPassView.m
//  ELA
//
//  Created by 樊晓乐 on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLSetMenmoryWordPassView.h"


@interface FLSetMenmoryWordPassView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *textfield1;

@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UIView *passWordContentView;
@property (weak, nonatomic) IBOutlet UISwitch *SWITCH;
@property (weak, nonatomic) IBOutlet UILabel *walletWordSwitchInfoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *theRulesInfoTextLabel;

@end

@implementation FLSetMenmoryWordPassView
- (IBAction)ShowHidenView:(UISwitch*)sender {
    
    self.passWordContentView.hidden = !sender.isOn;
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.passWordContentView.hidden=!self. SWITCH.isOn;
    self.SWITCH.layer.borderWidth=2.f;
    self.SWITCH.layer.borderColor=[UIColor whiteColor].CGColor; self.SWITCH.layer.cornerRadius=15.f;
    self.SWITCH.layer.masksToBounds=YES;
    self.SWITCH.transform=CGAffineTransformMakeScale(0.75, 0.75);
    [self.nextBtn setBackgroundColor:RGBA(255, 255, 255, 0.15) boldColor:[UIColor whiteColor] corner:0];
    self.walletWordSwitchInfoTextLabel.text=NSLocalizedString(@"助记词密码", nil);
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.textfield1 withTxt:NSLocalizedString(@"请输入密码", nil)];
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.textfield2 withTxt:NSLocalizedString(@"请重复已输入的助记词密码", nil)];
    self.theRulesInfoTextLabel.text=NSLocalizedString(@"长度8-16位，且至少包含字母、数字和特殊字符中的2种", nil);
     [self.nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    self.textfield1.delegate=self;
    self.textfield2.delegate=self;
    
}
- (IBAction)nextBtnClick:(UIButton*)sender {
    
    
    if (!self.passWordContentView.hidden) {
        
        if ([[FLTools share]checkWhetherThePassword:self.textfield1.text]) {
            return ;
        }
        if ([[FLTools share]checkWhetherThePassword:self.textfield2.text]) {
            return ;
        }
        if (![self.textfield2.text isEqualToString:self.textfield1.text]) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"两次密码输入不一致", nil)];
            return;
        }
    }else{
        self.textfield1.text=nil;
    }
    
    if (self.delegate) {
        [self.delegate theNextStepDWithPWD:self.textfield1.text];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
        [self.VC NotificationCenter];
   
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
        [self.VC reMovNotificationCenter];
    
    
}
@end
