//
//  HWMDIDInfoShowTableViewCell.m
//  elastos wallet
//
//  Created by  on 2020/2/14.
//

#import "HWMDIDInfoShowTableViewCell.h"

@implementation HWMDIDInfoShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIocnImageView.layer.cornerRadius=2.f;
    self.headIocnImageView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
