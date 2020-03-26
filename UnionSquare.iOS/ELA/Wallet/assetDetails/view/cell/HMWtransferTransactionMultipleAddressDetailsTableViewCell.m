//
//  HMWtransferTransactionMultipleAddressDetailsTableViewCell.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtransferTransactionMultipleAddressDetailsTableViewCell.h"


@interface HMWtransferTransactionMultipleAddressDetailsTableViewCell ()


@end

@implementation HMWtransferTransactionMultipleAddressDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.orderDetailsLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
