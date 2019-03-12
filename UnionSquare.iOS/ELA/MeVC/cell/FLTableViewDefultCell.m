//
//  FLTableViewDefultCell.m
//  FLWALLET
//
//  Created by fxl on 2018/6/11.
//  Copyright © 2018年 fxl. All rights reserved.
//

#import "FLTableViewDefultCell.h"


@interface FLTableViewDefultCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation FLTableViewDefultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeBordersWithView:self.bgView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
