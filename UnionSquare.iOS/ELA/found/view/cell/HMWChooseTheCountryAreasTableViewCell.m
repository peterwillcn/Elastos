//
//  HMWChooseTheCountryAreasTableViewCell.m
//  FLWALLET
//
//  Created by 韩铭文 on 2018/10/31.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import "HMWChooseTheCountryAreasTableViewCell.h"


@interface HMWChooseTheCountryAreasTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *countriesLabel;

@property (weak, nonatomic) IBOutlet UILabel *mobilePhoneCodeLabel;


@end

@implementation HMWChooseTheCountryAreasTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMoDict:(NSDictionary *)moDict{
    _moDict=moDict;
    self.countriesLabel.text=[[FLTools share]contryNameTransLateByCode:[moDict[@"mobileCode"] integerValue]] ;
    
    self.mobilePhoneCodeLabel.text=[NSString stringWithFormat:@"+%@",moDict[@"mobileCode"]];
    
    
}

@end
