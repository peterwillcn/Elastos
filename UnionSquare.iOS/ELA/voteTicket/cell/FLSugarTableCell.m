//
//  FLSugarTableCell.m
//  FLWALLET
//
//  Created by  on 2018/7/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLSugarTableCell.h"
//#import "UIImageView+WebCache.h"
@implementation FLSugarTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-(void)setModel:(FLSugarModel *)model
{
    _model = model;
 
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
