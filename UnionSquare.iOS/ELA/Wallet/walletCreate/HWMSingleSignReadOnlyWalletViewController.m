//
//  HWMSingleSignReadOnlyWalletViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/10.
//

#import "HWMSingleSignReadOnlyWalletViewController.h"
#import "ScanQRCodeViewController.h"

@interface HWMSingleSignReadOnlyWalletViewController ()
@property (weak, nonatomic) IBOutlet UITextField *walletNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@end

@implementation HWMSingleSignReadOnlyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"创建单签只读钱包", nil);
    self.walletNameTextField.placeholder=NSLocalizedString(@"请输入钱包名称", nil);
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.walletNameTextField];
    [self.btn1 setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15] boldColor:[UIColor whiteColor] corner:0];
    [self.btn1 setTitle:NSLocalizedString(@"确认创建", nil) forState:UIControlStateNormal];
}

- (IBAction)ConfirmToCreate:(id)sender {
    if (![[FLTools share]checkWalletName:self.walletNameTextField.text]) {
        
        
        return;
    }
}
@end
