//
//  AboutELAWalletViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/6/21.
//

#import "AboutELAWalletViewController.h"

@interface AboutELAWalletViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appTheVersionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *appInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeTheLogButton;
@property (weak, nonatomic) IBOutlet UILabel *sdkTheVersionNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *TheProblemOfFeedbackButton;
@property (weak, nonatomic) IBOutlet UIButton *RunLogButton;

@end

@implementation AboutELAWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    NSString *appTheVersionNumberString=NSLocalizedString(@"当前版本号V", nil);
    self.appTheVersionNumberLabel.text=[NSString stringWithFormat:@"%@ %@",appTheVersionNumberString, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.appInfoLabel.text=NSLocalizedString(@"ELAWallet是安全、便捷的专业亦来云SPV轻节点客户端钱包，支持亦来云全生态数字资产。", nil);
    [self makeBordersWithView:self.seeTheLogButton];
    [self.seeTheLogButton setTitle:NSLocalizedString(@"查看更新日志", nil) forState:UIControlStateNormal];
    [self.TheProblemOfFeedbackButton setTitle:NSLocalizedString(@"问题反馈", nil) forState:UIControlStateNormal];
    [self.RunLogButton setTitle:NSLocalizedString(@"运行日志", nil) forState:UIControlStateNormal];
    self.sdkTheVersionNumberLabel.text=[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"当前sdk版本号：", nil),@"v0.4.0-39-gf6fd6a80"];
    
}
- (IBAction)seeTheLogAction:(id)sender {
}
- (IBAction)TheProblemOfFeedbackAction:(id)sender {
    [UIPasteboard generalPasteboard].string = @"contact@elastos.org";
    [[FLTools share]showErrorInfo:NSLocalizedString(@"客服邮箱已复制到粘贴板", nil)];
}
- (IBAction)RunLogAction:(id)sender {
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
