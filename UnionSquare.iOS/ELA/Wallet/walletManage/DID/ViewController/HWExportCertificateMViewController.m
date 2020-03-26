//
//  HWExportCertificateMViewController.m
//  elastos wallet
//
//  Created by  on 2020/3/24.
//

#import "HWExportCertificateMViewController.h"

@interface HWExportCertificateMViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dirNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation HWExportCertificateMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self defultWhite];
     [self setBackgroundImg:@""];
     self.title=NSLocalizedString(@"导出凭证", nil);
    [self.saveButton setTitle:NSLocalizedString(@"保存至本地", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.saveButton];
    [[HMWCommView share]makeBordersWithView:self.shareButton];
    [self.shareButton setTitle:NSLocalizedString(@"分享", nil) forState:UIControlStateNormal];
    self.dirNameLabel.text=[NSString stringWithFormat:@"%@_%@_%@",self.model.didName,[[FLTools share]getNowTimeTimestampS],[self.currentWallet.didString substringFromIndex:self.currentWallet.didString.length-6]];
}
- (IBAction)saveEvent:(id)sender {
}
- (IBAction)shareEvent:(id)sender {
}

@end
