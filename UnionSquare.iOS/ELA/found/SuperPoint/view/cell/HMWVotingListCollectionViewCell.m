//
//  HMWVotingListCollectionViewCell.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWVotingListCollectionViewCell.h"

@interface HMWVotingListCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coinIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theValueOfLabel;
@property (weak, nonatomic) IBOutlet UILabel *votesLabel;

@end

@implementation HMWVotingListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[HMWCommView share]makeBordersWithView:self];

}
-(void)setModel:(FLCoinPointInfoModel *)model
{
    _model = model;
    
  self.coinNameLabel.text = model.nickname;
//  self.theValueOfLabel.text = model.votes;
    NSString *votes =[NSString stringWithFormat:@"%ld",(long)[model.votes integerValue]];
    self.votesLabel.text = [votes stringByAppendingString:NSLocalizedString(@"ELA", nil)];
    if (model.index==1) {
        self.iconImageView.image = [UIImage imageNamed:@"gold"];
    }else if (model.index==2){
        self.iconImageView.image = [UIImage imageNamed:@"Argentum"];

    }else if (model.index==3){
        self.iconImageView.image = [UIImage imageNamed:@"copper"];

    }else{
        self.iconImageView.image = nil;

    }
};





@end
