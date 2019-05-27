//
//  HMWaddressListTableViewCell.m
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWaddressListTableViewCell.h"


@interface HMWaddressListTableViewCell ()

@end

@implementation HMWaddressListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addressLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)copyWalletAddrssEvent:(id)sender {
    [[FLTools share]copiedToTheClipboardWithString:self.addressLabel.text];
}


@end
