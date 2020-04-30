//
//  HMWImKeystoreView.m
//  ELA
//
//  Created by  on 2019/1/4.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWImKeystoreView.h"
#import "UIViewController+FLVCExt.h"

@interface HMWImKeystoreView ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *keyStoreTextView;
@property (weak, nonatomic) IBOutlet UITextField *walletNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyStorePWDTextField;
@property (weak, nonatomic) IBOutlet UITextField *walletPWDTextField;

@property (weak, nonatomic) IBOutlet UIButton *confirmTheImportButton;
@property (weak, nonatomic) IBOutlet UILabel *showInfoTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *againWalletPWDTextField;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *palceString;
@end

@implementation HMWImKeystoreView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWImKeystoreView" owner:nil options:nil].firstObject;
        self.palceString=NSLocalizedString(@"请输入Keystore文本内容", nil);
        self.keyStoreTextView.text=self.palceString;
        self.showInfoTextLabel.text=NSLocalizedString(@"长度8-16位，且至少包含字母、数字和特殊字符中的2种", nil);
        [self.confirmTheImportButton setTitle:NSLocalizedString(@"确认导入", nil) forState:UIControlStateNormal];
        self.keyStoreTextView.delegate=self;
        [[HMWCommView share]makeBordersWithView:self.keyStoreTextView];
        [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.walletNameTextField withTxt:NSLocalizedString(@"请输入钱包名称", nil)];
        [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.keyStorePWDTextField withTxt:NSLocalizedString(@"请输入Keystore密码", nil)];
        [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.walletPWDTextField withTxt:NSLocalizedString(@"请输入8至16位钱包密码", nil)];
        [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.againWalletPWDTextField withTxt:NSLocalizedString(@"请再次输入确认密码", nil)];
        [[HMWCommView share]makeBordersWithView:self.confirmTheImportButton];
        self.walletPWDTextField.secureTextEntry=YES;
        self.keyStorePWDTextField.secureTextEntry=YES;
        self.againWalletPWDTextField.secureTextEntry=YES;
        self.againWalletPWDTextField.delegate=self;
        
    }
    
    return self;
    
    
}
- (IBAction)confirmTheImportEvent:(id)sender {
    if (![[FLTools share]checkWalletName:self.walletNameTextField.text]) {
        
        
        return;
    }
    if (self.keyStorePWDTextField.text.length==0) {
        
        [[FLTools share]showErrorInfo:NSLocalizedString(@"keyStore密码不能为空", nil)];
        return;
    }
    if ([[FLTools share]checkWhetherThePassword:self.walletPWDTextField.text]) {
        return ;
    }
    if ([[FLTools share]checkWhetherThePassword:self.againWalletPWDTextField.text]) {
        return ;
    }
    
    
    
    
    if (![self.walletPWDTextField.text isEqualToString:self.againWalletPWDTextField.text]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"两次密码输入不一致", nil)];
        return;
    }
    
    FLWallet *wallet=[[FLWallet alloc]init];
    wallet.keyStore=self.keyStoreTextView.text;
    wallet.walletName=self.walletNameTextField.text;
    wallet.privateKey=self.keyStorePWDTextField.text;
    wallet.passWord=self.walletPWDTextField.text;
    if ([self.delegate respondsToSelector:@selector(imKeystoreViewWithWallet:)]) {
        [self.delegate imKeystoreViewWithWallet:wallet];
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.keyStoreTextView.text isEqualToString:self.palceString]) {
           self.keyStoreTextView.text=@"";
    }
    self.keyStoreTextView.textColor=[UIColor whiteColor];
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.keyStoreTextView.text.length==0) {
        self.keyStoreTextView.text=self.palceString;
        self.keyStoreTextView.textColor=RGBA(255, 255, 255, 0.5);
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField==self.againWalletPWDTextField) {
        [self.VC NotificationCenter];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField==self.againWalletPWDTextField) {
        [self.VC reMovNotificationCenter];
    }
    
    
}
@end
