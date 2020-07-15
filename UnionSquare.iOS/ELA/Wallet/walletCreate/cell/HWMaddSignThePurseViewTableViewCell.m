//
//  HWMaddSignThePurseViewTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/7/2.
//

#import "HWMaddSignThePurseViewTableViewCell.h"

@interface HWMaddSignThePurseViewTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *QrCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *pasteButton;

@end
@implementation HWMaddSignThePurseViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.signThePublicKeyTextField withTxt:NSLocalizedString(@"请输入多签公钥", nil)];
    
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
