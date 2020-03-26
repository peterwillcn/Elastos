//
//  HMWCopyKeyStoreViewController.m
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWCopyKeyStoreViewController.h"

@interface HMWCopyKeyStoreViewController ()
    @property (weak, nonatomic) IBOutlet UIView *walletNameBGView;
    @property (weak, nonatomic) IBOutlet UIView *KSBGView;
    @property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *KSLabel;
    @property (weak, nonatomic) IBOutlet UIButton *CKSButton;
@property (weak, nonatomic) IBOutlet UILabel *showInfoLabel;

@end

@implementation HMWCopyKeyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"导出Keystore",nil);
    self.walletNameLabel.text=self.walletName;
    self.KSLabel.text=self.keyStoreString;
    self.showInfoLabel.text=NSLocalizedString(@"请将此文本复制到一个安全的地方", nil);
    [self.CKSButton setTitle:NSLocalizedString(@"复制到剪贴板", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.walletNameBGView];
     [[HMWCommView share]makeBordersWithView:self.KSBGView];
    [[HMWCommView share]makeBordersWithView:self.CKSButton];
}
- (IBAction)copiedToTheClipboardEvent:(id)sender {
    
     [[FLTools share]showErrorInfo:NSLocalizedString(@"复制成功", nil)];
    [[FLTools share]copiedToTheClipboardWithString:self.keyStoreString];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
