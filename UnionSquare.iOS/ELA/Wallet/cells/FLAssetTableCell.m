//
//  FLAssetTableCell.m
//  FLWALLET
//
//  Created by  on 2018/4/16.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLAssetTableCell.h"

@interface FLAssetTableCell  ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end


@implementation FLAssetTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ProgressCentent.layer.cornerRadius = 5;
    self.bgView.layer.borderWidth=0.5f;
    self.bgView.layer.borderColor=RGB(255, 255, 255).CGColor;
    self.bgView.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
