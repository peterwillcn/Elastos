//
//  HMWChooseTheCountryAreasTableViewCell.m
//  FLWALLET
//
//  Created by  on 2018/10/31.
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
    self.countriesLabel.text=[NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(moDict[@"countries"], nil) ,moDict[@"countries"]];
    
    self.mobilePhoneCodeLabel.text=[NSString stringWithFormat:@"+%@",moDict[@"mobileCode"]];
    
    
}

@end
