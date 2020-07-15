//
//  showOwnerAddressTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/6/25.
//

#import "showOwnerAddressTableViewCell.h"

@interface showOwnerAddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *addreCopyTextButton;

@end

@implementation showOwnerAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeBordersWithView:self.addreCopyTextButton];
    [self.addreCopyTextButton setTitle:NSLocalizedString(@"复制收益地址", nil) forState:UIControlStateNormal];
 
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addreCopyTextAction:(id)sender {
    [UIPasteboard generalPasteboard].string = self.addreCopyTextLabel.text;
    [[FLTools share]showErrorInfo:NSLocalizedString(@"已复制到剪贴板", nil)];
}

@end
