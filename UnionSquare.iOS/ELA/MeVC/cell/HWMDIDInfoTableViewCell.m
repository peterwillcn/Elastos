//
//  HWMDIDInfoTableViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/30.
//

#import "HWMDIDInfoTableViewCell.h"

@interface HWMDIDInfoTableViewCell ()

@end

@implementation HWMDIDInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)copyEvent:(id)sender {
    if (self.infoLabel.text.length>0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"复制成功", nil)];
           [[FLTools share]copiedToTheClipboardWithString:self.infoLabel.text];
    }
}

@end
