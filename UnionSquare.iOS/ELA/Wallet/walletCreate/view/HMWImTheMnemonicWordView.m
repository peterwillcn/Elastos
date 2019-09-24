//
//  HMWImTheMnemonicWordView.m
//  ELA
//
//  Created by  on 2019/1/4.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWImTheMnemonicWordView.h"
#import "UIViewController+FLVCExt.h"



@interface HMWImTheMnemonicWordView ()<UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *whetherTheSingleAddressButton;
@property (weak, nonatomic) IBOutlet UITextView *theMnemonicWordTextView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextFiedl;
@property (weak, nonatomic) IBOutlet UITextField *walletNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPWDTextField;
@property (weak, nonatomic) IBOutlet UITextField *theMnemonicWordPWDTextField;

@property (weak, nonatomic) IBOutlet UIButton *confirmTheImportButton;
@property (weak, nonatomic) IBOutlet UISwitch *showOrHideThePasswordSwitch;
@property (weak, nonatomic) IBOutlet UILabel *walletWordSwitchInfoTextLabel;
@property (weak, nonatomic) IBOutlet UIView *passWordContentView;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *palceString;
@property (weak, nonatomic) IBOutlet UILabel *pwdShowInfoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *theMnemonicWordShowInfo;
@property (weak, nonatomic) IBOutlet UIView *makeLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOff;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation HMWImTheMnemonicWordView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWImTheMnemonicWordView" owner:nil options:nil].firstObject;
       self.theMnemonicWordShowInfo.text=NSLocalizedString(@"助记词导入钱包同步速度缓慢，建议创建新钱包或使用Keystore导入", nil); self.walletWordSwitchInfoTextLabel.text=NSLocalizedString(@"助记词密码（可选）", nil);
        self.palceString=NSLocalizedString(@"助记词之间请使用空格隔开", nil);
        self.theMnemonicWordTextView.text=self.palceString;
        [self.confirmTheImportButton setTitle:NSLocalizedString(@"确认导入", nil) forState:UIControlStateNormal];
      [[HMWCommView share]makeBordersWithView:self.theMnemonicWordTextView];
        [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.pwdTextFiedl withTxt:NSLocalizedString(@"请输入8至16位钱包密码", nil)];
         [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.walletNameTextField withTxt:NSLocalizedString(@"请输入钱包名称", nil)];
          [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.againPWDTextField withTxt:NSLocalizedString(@"请再次输入确认密码", nil)];
         [[HMWCommView alloc]makeTextFieldPlaceHoTextColorWithTextField:self.theMnemonicWordPWDTextField withTxt:NSLocalizedString(@"请输入当前钱包的助记词密码", nil)];
        [[HMWCommView share]makeBordersWithView:self.confirmTheImportButton];
        self.showOrHideThePasswordSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
        self.showOrHideThePasswordSwitch.layer.borderWidth=2.f;
        self.showOrHideThePasswordSwitch.layer.cornerRadius=15.f; self.showOrHideThePasswordSwitch.layer.masksToBounds=YES;
        
        self.showOrHideThePasswordSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
        self.passWordContentView.hidden = !self.showOrHideThePasswordSwitch.isOn;
        self.theMnemonicWordTextView.delegate=self;
        self.againPWDTextField.secureTextEntry=YES;
        self.pwdTextFiedl.secureTextEntry=YES;
        self.theMnemonicWordPWDTextField.secureTextEntry=YES;
        self.whetherTheSingleAddressButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.whetherTheSingleAddressButton setTitle:NSLocalizedString(@"单地址钱包", nil) forState:UIControlStateNormal];
            [self.whetherTheSingleAddressButton setTitle:NSLocalizedString(@"单地址钱包", nil) forState:UIControlStateSelected];
        self.pwdShowInfoTextLabel.text=NSLocalizedString(@"长度8-16位，且至少包含字母、数字和特殊字符中的2种", nil);
        self.theMnemonicWordPWDTextField.delegate=self;
    }
    
    return self;
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.theMnemonicWordTextView.text isEqualToString:self.palceString]) {
          self.theMnemonicWordTextView.text=@"";
    }
    
    self.theMnemonicWordTextView.textColor=[UIColor whiteColor];
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.theMnemonicWordTextView.text.length==0) {
        self.theMnemonicWordTextView.text=self.palceString;
        self.theMnemonicWordTextView.textColor=RGBA(255, 255, 255, 0.5);
    }
    
}
- (IBAction)ShowHidenView:(UISwitch*)sender {
    
    self.passWordContentView.hidden = !sender.isOn;
    
}
- (IBAction)confirmTheImportEvent:(id)sender {
    if (![self.typeString isEqualToString:@"1"]) {
        if (![[FLTools share]checkWalletName:self.walletNameTextField.text]) {
            
            
            return;
        }
    }
   
    if ([[FLTools share]checkWhetherThePassword:self.pwdTextFiedl.text]) {
        return ;
    }
    if ([[FLTools share]checkWhetherThePassword:self.againPWDTextField.text]) {
        return ;
    }
    if (![self.pwdTextFiedl.text isEqualToString:self.againPWDTextField.text]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"两次密码输入不一致", nil)];
        return;
    }
    FLWallet *wallet=[[FLWallet alloc]init];
    
    wallet.walletName=self.walletNameTextField.text;
    wallet.passWord=self.pwdTextFiedl.text;
    wallet.mnemonicPWD=self.theMnemonicWordPWDTextField.text;
    wallet.isSingleAddress=self.whetherTheSingleAddressButton.isSelected;
    wallet.mnemonic=self.theMnemonicWordTextView.text;
    
    if ([self.delegate respondsToSelector:@selector(ImTheMnemonicWordViewCompWithWallet:)]) {
        [self.delegate ImTheMnemonicWordViewCompWithWallet:wallet];
        
    }
    
    
}
- (IBAction)whetherTheSingleAddressEvent:(id)sender {
//   "单地址钱包"
    self.whetherTheSingleAddressButton.selected=!self.whetherTheSingleAddressButton.selected;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField==self.theMnemonicWordPWDTextField) {
        [self.VC NotificationCenter];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField==self.theMnemonicWordPWDTextField) {
        [self.VC reMovNotificationCenter];
    }
    
    
}
-(void)setTypeString:(NSString *)typeString{
    if ([typeString isEqualToString:@"1"]) {
        self.theMnemonicWordShowInfo.alpha=0.f;
        self.whetherTheSingleAddressButton.alpha=0.f;
        self.walletNameTextField.alpha=0.f;
        self.makeLineView.alpha=0.f;
        self.topOff.constant=0.f;
        self.viewHeight.constant=180;
    }
    _typeString=typeString;
    
    
}
@end
