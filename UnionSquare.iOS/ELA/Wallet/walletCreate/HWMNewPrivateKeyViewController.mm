//
//  HWMNewPrivateKeyViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import "HWMNewPrivateKeyViewController.h"
#import "ELWalletManager.h"
#import "DAConfig.h"
#import "HWMSignThePurseViewController.h"
#import "FLdoubleWalletVC.h"

@interface HWMNewPrivateKeyViewController ()<UITextFieldDelegate,FLdoubleWalletVCDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pwdfield1;
@property (weak, nonatomic) IBOutlet UITextField *pwdfield2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UILabel *showInfoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *pwdShowInfoTextLabel;
@end

@implementation HWMNewPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self defultWhite];
    [self setBackgroundImg:@""];
    self.title = NSLocalizedString(@"新建私钥", nil);
    self.pwdfield1.placeholder=NSLocalizedString(@"请输入密码", nil);
    self.pwdfield2.placeholder=NSLocalizedString(@"请再次输入确认钱包密码", nil);
    self.pwdShowInfoTextLabel.text=NSLocalizedString(@"长度8-16位，且至少包含字母、数字和特殊字符中的2种", nil);
    
    [self.btn1 setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15] boldColor:[UIColor whiteColor] corner:0];
    self.pwdfield1.secureTextEntry=YES;
    self.pwdfield2.secureTextEntry=YES;
    [self.view setLabelSpace:self.showInfoTextLabel withValue:NSLocalizedString(@"     密码用于保护私钥和交易授权，强度非常重要. elastos不存储密码，也无法帮您找回，请务必牢记", nil) withFont:[UIFont systemFontOfSize:10]];
    [self.btn1 setTitle:NSLocalizedString(@"确认创建", nil) forState:UIControlStateNormal];
}
- (IBAction)click1:(id)sender {
    
    if ([[FLTools share]checkWhetherThePassword:self.pwdfield1.text]) {
        return ;
    }
    if ([[FLTools share]checkWhetherThePassword:self.pwdfield2.text]) {
        return ;
    }
    if (![self.pwdfield1.text isEqualToString:self.pwdfield2.text]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"两次密码输入不一致", nil)];
        return;
    }
    NSString *languageStringMword;
    
    NSString *languageString=[DAConfig userLanguage];
    if ([languageString  containsString:@"en"]) {
        languageStringMword=@"english";
    }else if ([languageString  containsString:@"zh"]){
        
        languageStringMword=@"chinese";
    }
    
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[languageStringMword] callbackId:@"" className:@"Wallet" methodName:@"generateMnemonic"];
    PluginResult *result=[[ELWalletManager share]generateMnemonic:mommand];
    NSString *mnemonic=result.message[@"success"];
    NSString *walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    NSString *masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:walletID];
    FLWallet *wallet=[[FLWallet alloc]init];
  
    wallet.passWord=self.pwdfield1.text;
   
    wallet.mnemonic=mnemonic;
    wallet.walletID=masterWalletID;
    FLdoubleWalletVC *vc = [[FLdoubleWalletVC alloc]init];
    vc.Wallet=wallet;
    vc.createType=3;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField becomeFirstResponder];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)backTheWallet:(FLWallet*)wallet{
        if (self.delegate) {
            [self.delegate backTheMnemonicWord:wallet.mnemonic withPWD:wallet.passWord withPhrasePassword:wallet.mnemonicPWD];
        }
}
@end
