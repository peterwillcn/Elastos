//
//  HMWModifyTheWalletNameViewController.m
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWModifyTheWalletNameViewController.h"
#import "FMDBWalletModel.h"
#import "HMWFMDBManager.h"
@interface HMWModifyTheWalletNameViewController ()
    @property (weak, nonatomic) IBOutlet UITextField *nNickNameTextField;
    @property (weak, nonatomic) IBOutlet UIButton *confirmTheChangeButton;

    
@end

@implementation HMWModifyTheWalletNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"修改钱包名称", nil);
    [self.confirmTheChangeButton setTitle:NSLocalizedString(@"确认修改", nil) forState:UIControlStateNormal];

    [[HMWCommView share]makeBordersWithView:self.confirmTheChangeButton];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.nNickNameTextField withTxt:NSLocalizedString(@"请输入新的钱包名称", nil)];
}
- (IBAction)confirmTheChangeEvent:(id)sender {
    if (![[FLTools share]checkWalletName:self.nNickNameTextField.text]) {
        
        
        return;
    }
    
    FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
    model.walletName=self.nNickNameTextField.text;
    model.walletID=self.wallet.masterWalletID;
    if ([[HMWFMDBManager sharedManagerType:walletType]updateRecordWallet:model]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"钱包名修改成功", nil)];
         [[NSNotificationCenter defaultCenter]postNotificationName:updataWallet object:@"index"];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        [[FLTools share]showErrorInfo:NSLocalizedString(@"钱包名修改失败", nil)];
    }
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


@end
