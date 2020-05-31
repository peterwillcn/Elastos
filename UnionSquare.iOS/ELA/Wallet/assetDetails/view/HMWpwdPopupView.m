//
//  HMWpwdPopupView.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWpwdPopupView.h"

@interface HMWpwdPopupView ()
@property (weak, nonatomic) IBOutlet UIButton *backBuuton;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *makeSureButton;
@property (weak, nonatomic) IBOutlet UILabel *pwdTextLabel;

@end


@implementation HMWpwdPopupView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWpwdPopupView" owner:nil options:nil].firstObject;
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.pwdTextField withTxt:NSLocalizedString(@"请输入您的钱包密码", nil)];
        [[HMWCommView share]makeBordersWithView:self.makeSureButton];
        self.pwdTextField.secureTextEntry=YES;
        self.pwdTextField.returnKeyType = UIReturnKeyDone;
        self.pwdTextField.delegate = self;
        [self.makeSureButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        self.pwdTextLabel.text=NSLocalizedString(@"输入密码", nil);
    }
    return self;
    
    
}
#pragma mark - delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];

    return YES;

}

//-(void)giveUpTheInput{
//
//
//    [self endEditing:YES];
//}
- (IBAction)backEvent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cancelThePWDPageView)]) {
        [self.delegate cancelThePWDPageView];
        
        
    }
}
- (IBAction)makeSureEvent:(id)sender {
    self.makeSureButton.userInteractionEnabled=NO;
    if (self.delegate) {
        if (self.pwdTextField.text.length==0) {
            self.makeSureButton.userInteractionEnabled=YES;
            [[FLTools share]showErrorInfo:NSLocalizedString(@"密码不能为空", nil)];
            return;
        }
        [self.delegate makeSureWithPWD:self.pwdTextField.text];
        self.makeSureButton.userInteractionEnabled=YES;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
@end
