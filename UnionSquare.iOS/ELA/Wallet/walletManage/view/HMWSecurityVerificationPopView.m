//
//  HMWSecurityVerificationPopView.m
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWSecurityVerificationPopView.h"

@interface HMWSecurityVerificationPopView ()
    @property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
    
    @property (weak, nonatomic) IBOutlet UIButton *determineThePasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *securityTextLabel;

@end


@implementation HMWSecurityVerificationPopView
-(instancetype)init{
    self =[super init];
    if (self){
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWSecurityVerificationPopView" owner:nil options:nil].firstObject;
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.pwdTextField withTxt:NSLocalizedString(@"请输入钱包密码", nil)];
        self.pwdTextField.secureTextEntry = YES ;
//        self.userInteractionEnabled=YES;
//        UITapGestureRecognizer *reTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(giveUpTheInput)];
//        [self addGestureRecognizer:reTap];
        self.pwdTextField.secureTextEntry=YES;
        [self.determineThePasswordButton  setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal] ;
        [self.cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        self.securityTextLabel.text=NSLocalizedString(@"安全验证", nil);
    }
    
    return self;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
//-(void)giveUpTheInput{
//
//
//    [self endEditing:YES];
//}
- (IBAction)closeViewEvent:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(takeOutOrShutDown)]){
        [self.delegate takeOutOrShutDown];
    }
    
}
    
- (IBAction)determineThePasswordEvent:(id)sender {
    if (self.pwdTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入钱包密码", nil)];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(makeSureWithPWD:)]) {
        [self.delegate makeSureWithPWD:self.pwdTextField.text];
    }
    
    
    
}
@end
