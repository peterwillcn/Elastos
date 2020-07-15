//
//  HMWModifyTheWalletPasswordViewController.m
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWModifyTheWalletPasswordViewController.h"

#import "ELWalletManager.h"


@interface HMWModifyTheWalletPasswordViewController ()
    @property (weak, nonatomic) IBOutlet UITextField *oldPWDTextField;
    
    @property (weak, nonatomic) IBOutlet UITextField *nPWDTextField;
    @property (weak, nonatomic) IBOutlet UITextField *againPWDTextField;
    @property (weak, nonatomic) IBOutlet UIButton *confirmTheChangeButton;
    
@end

@implementation HMWModifyTheWalletPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.oldPWDTextField.secureTextEntry =YES;
    
   self.nPWDTextField.secureTextEntry =YES;
   self.againPWDTextField.secureTextEntry =YES;
     [self.confirmTheChangeButton setTitle:NSLocalizedString(@"确认修改", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.oldPWDTextField withTxt:NSLocalizedString(@"请输入原钱包密码", nil)];
       [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.nPWDTextField withTxt:NSLocalizedString(@"请输入新的钱包密码", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.againPWDTextField withTxt:NSLocalizedString(@"请再次输入确认钱包密码", nil)];
}
- (IBAction)confirmTheChangeEvent:(id)sender {
   
    if ([[FLTools share]checkWhetherThePassword:self.oldPWDTextField.text]) {
        return ;
    }
    
    if ([[FLTools share]checkWhetherThePassword:self.nPWDTextField.text]) {
        return ;
    }
    if ([[FLTools share]checkWhetherThePassword:self.againPWDTextField.text]) {
        return ;
    }
    if (![self.againPWDTextField.text isEqualToString:self.nPWDTextField.text]) {
        
        [[FLTools share]showErrorInfo:NSLocalizedString(@"两次密码输入不一致", nil)];
        return;
    }
    
     self.confirmTheChangeButton.userInteractionEnabled=NO;
    

    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.oldPWDTextField.text,self.nPWDTextField.text] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"changePassword"];
    
    
    
    
    PluginResult *result= [[ELWalletManager share]changePassword:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if([status isEqualToString:@"1"]){
        [[FLTools share]showErrorInfo:NSLocalizedString(@"修改成功！", nil)];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    self.nPWDTextField.secureTextEntry=YES;
    self.oldPWDTextField.secureTextEntry=YES;
    self.againPWDTextField.secureTextEntry=YES;
    self.confirmTheChangeButton.userInteractionEnabled=YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
