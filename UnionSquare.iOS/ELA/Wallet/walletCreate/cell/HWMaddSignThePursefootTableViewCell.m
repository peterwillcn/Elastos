//
//  HWMaddSignThePursefootTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/7/4.
//

#import "HWMaddSignThePursefootTableViewCell.h"

@implementation HWMaddSignThePursefootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      [[HMWCommView share]makeBordersWithView:self.confirmCreateButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
