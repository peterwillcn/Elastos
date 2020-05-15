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


#import "HWMSecureAuthenticationPasswordView.h"

@interface HWMSecureAuthenticationPasswordView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *pwdLabe;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *makeSureButton;
@end

@implementation HWMSecureAuthenticationPasswordView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMSecureAuthenticationPasswordView" owner:nil options:nil].firstObject;
        self.titleLabel.text=NSLocalizedString(@"安全验证", nil);
        self.pwdLabe.text=NSLocalizedString(@"密码", nil);
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.pwdTextField withTxt:NSLocalizedString(@"请输入钱包密码", nil)];
        [self.makeSureButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [[HMWCommView share]makeBordersWithView:self.makeSureButton];
    }
    return self;
}
- (IBAction)closeViewEvent:(id)sender {
    if ([self.delegate respondsToSelector:@selector(closepwdView)]) {
        self.makeSureButton.userInteractionEnabled=YES;
        [self.delegate closepwdView];
    }
}
- (IBAction)makeSuereEvent:(id)sender {
    self.makeSureButton.userInteractionEnabled=NO;
     if (self.pwdTextField.text.length==0) {
         self.makeSureButton.userInteractionEnabled=YES;
         [[FLTools share]showErrorInfo:NSLocalizedString(@"密码不能为空", nil)];
         self.makeSureButton.userInteractionEnabled=YES;
         return;
     }
    if ([self.delegate respondsToSelector:@selector(makeSureWithPWD:)]) {
        [self.delegate makeSureWithPWD:self.pwdTextField.text];
    }
     self.makeSureButton.userInteractionEnabled=YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
