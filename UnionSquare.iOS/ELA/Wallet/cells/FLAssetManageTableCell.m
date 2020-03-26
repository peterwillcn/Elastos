//
//  FLAssetManageTableCell.m
//  FLWALLET
//
//  Created by  on 2018/4/26.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLAssetManageTableCell.h"

@interface FLAssetManageTableCell()

@property (weak, nonatomic) IBOutlet UISwitch *swich;

@end


@implementation FLAssetManageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
  self.swich.layer.borderColor=[UIColor whiteColor].CGColor;
   self.swich.layer.borderWidth=2.f;
    self.swich.layer.cornerRadius=15.f; self.swich.layer.masksToBounds=YES;
    self.swich.transform=CGAffineTransformMakeScale(0.75, 0.75);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(FLAllKindBi *)data
{
    _data = data;
    if (data.walletAddress) {
        self.swich.on  =YES;
    }else{
        self.swich.on = NO;
    }
  
}
- (IBAction)changeState:(UISwitch*)sender {
    
    if (self.delegate) {
        [self.delegate swichChange:self.swich model:self.data];
    }
}

@end
