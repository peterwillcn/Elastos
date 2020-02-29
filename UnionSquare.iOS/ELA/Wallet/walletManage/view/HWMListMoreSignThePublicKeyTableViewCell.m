//
//  HWMListMoreSignThePublicKeyTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/9/10.
//

#import "HWMListMoreSignThePublicKeyTableViewCell.h"


@implementation HWMListMoreSignThePublicKeyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.BGView.layer.cornerRadius=5.f;
self.BGView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
