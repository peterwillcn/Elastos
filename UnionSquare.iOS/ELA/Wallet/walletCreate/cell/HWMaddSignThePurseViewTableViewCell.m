//
//  HWMaddSignThePurseViewTableViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/2.
//

#import "HWMaddSignThePurseViewTableViewCell.h"

@interface HWMaddSignThePurseViewTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *QrCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *pasteButton;

@end
@implementation HWMaddSignThePurseViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.signThePublicKeyTextField.placeholder=NSLocalizedString(@"请输入多签公钥", nil);
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.signThePublicKeyTextField];
    
}
- (IBAction)pasteAction:(id)sender {
     self.signThePublicKeyTextField.text=[[FLTools share]pastingTextFromTheClipboard];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)QrCodeAction:(id)sender {
    if (self.delegate) {
        [self.delegate QrCodeIndex:self.row];
    }
}

@end
