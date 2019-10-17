//
//  HMWExportTheMnemonicWordViewController.m
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//
#import "HMWExportTheMnemonicWordViewController.h"
#import "HMWverifyTheMnemonicWordViewController.h"
@interface HMWExportTheMnemonicWordViewController ()
@property (weak, nonatomic) IBOutlet UILabel *theMnemonicWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *againTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmTheExportButton;
@property (weak, nonatomic) IBOutlet UISwitch *isShowPWDViewSwitch;
@property (weak, nonatomic) IBOutlet UIView *passWordContentView;
@property (weak, nonatomic) IBOutlet UILabel *WalletWordInfoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *showInfoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletWordSwitchInfoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *theRulesInfoTextLabel;

@end

@implementation HMWExportTheMnemonicWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    NSLocalizedString(@"确认导出", nil);
    
    self.title=NSLocalizedString(@"导出助记词", nil);
    [self.confirmTheExportButton setTitle:NSLocalizedString(@"确认导出", nil) forState:UIControlStateNormal];
    self.WalletWordInfoTextLabel.text=NSLocalizedString(@"抄写下您的钱包助记词", nil);
    self.showInfoTextLabel.text=NSLocalizedString(@"请在纸上抄下您的助记词 \n 助记词丢失您将永远失去自己的钱包", nil);
    self.walletWordSwitchInfoTextLabel.text=NSLocalizedString(@"助记词密码", nil);   self.theRulesInfoTextLabel.text=NSLocalizedString(@"长度8-16位，且至少包含字母、数字和特殊字符中的2种", nil);
    
    [[HMWCommView share]makeBordersWithView:self.theMnemonicWordLabel];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.pwdTextField withTxt:NSLocalizedString(@"请输入密码", nil)];
     [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.againTextField withTxt:NSLocalizedString(@"请重复已输入的助记词密码", nil)];
    [[HMWCommView share]makeBordersWithView:self.confirmTheExportButton];
    self.isShowPWDViewSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
    self.isShowPWDViewSwitch.layer.borderWidth=2.f;
    self.isShowPWDViewSwitch.layer.cornerRadius=15.f; self.isShowPWDViewSwitch.layer.masksToBounds=YES;
 self.isShowPWDViewSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
    self.passWordContentView.hidden = !self.isShowPWDViewSwitch.isOn;
    self.theMnemonicWordLabel.text=self.theMnemonicWord;
    self.pwdTextField.secureTextEntry=YES;
    self.againTextField.secureTextEntry=YES;
}
- (IBAction)ShowHidenView:(UISwitch*)sender {
    
    self.passWordContentView.hidden = !sender.isOn;
    
}


- (IBAction)confirmTheExportEvent:(id)sender {
HMWverifyTheMnemonicWordViewController*VerifyTheMnemonicWordVC=[[HMWverifyTheMnemonicWordViewController alloc]init];
    self.currentWallet.mnemonic=self.theMnemonicWord;
    VerifyTheMnemonicWordVC.Wallet=self.currentWallet;
    VerifyTheMnemonicWordVC.FormeType=@"2";
    [self.navigationController pushViewController:VerifyTheMnemonicWordVC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
