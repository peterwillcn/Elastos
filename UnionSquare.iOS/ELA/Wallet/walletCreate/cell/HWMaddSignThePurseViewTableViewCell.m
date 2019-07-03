//
//  HWMaddSignThePurseViewTableViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/2.
//

#import "HWMaddSignThePurseViewTableViewCell.h"
#import "ScanQRCodeViewController.h"

@interface HWMaddSignThePurseViewTableViewCell ()
@property (weak, nonatomic) IBOutlet UITextField *signThePublicKeyTextField;
@property (weak, nonatomic) IBOutlet UIButton *QrCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *pasteButton;

@end
@implementation HWMaddSignThePurseViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.signThePublicKeyTextField];
    self.signThePublicKeyTextField.placeholder=NSLocalizedString(@"请输入多签公钥", nil);
}
- (IBAction)pasteAction:(id)sender {
     self.signThePublicKeyTextField.text=[[FLTools share]pastingTextFromTheClipboard];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)QrCodeAction:(id)sender {
//    __weak __typeof__(self) weakSelf = self;
//    ScanQRCodeViewController *scanQRCodeVC = [[ScanQRCodeViewController alloc]init];
//    scanQRCodeVC.scanBack = ^(NSString *addr) {
//        
//    weakSelf.signThePublicKeyTextField.text=addr;
//        
//    };
//    [self QRCodeScanVC:scanQRCodeVC];
}

@end
