//
//  HMWmyContactListTableViewCell.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWmyContactListTableViewCell.h"


@interface HMWmyContactListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *BGView;


@end

@implementation HMWmyContactListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeBordersWithView:self.BGView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
