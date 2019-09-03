//
//  HWMCRCCommitteeElectionCollectionViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/9/3.
//

#import "HWMCRCCommitteeElectionCollectionViewCell.h"


@interface HWMCRCCommitteeElectionCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *NoIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *VotesAndPercentagesLabel;

@end

@implementation HWMCRCCommitteeElectionCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeBordersWithView:self.contentView];
    self.NoIndexLabel.layer.cornerRadius=2.f;
    self.NoIndexLabel.layer.masksToBounds=YES;
}
-(void)setModel:(FLCoinPointInfoModel *)model{
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconImageUrl] placeholderImage:[UIImage imageNamed:@"found_vote_initial_r"]];
    
    self.nickNameLabel.text = model.nickname;
    //  self.theValueOfLabel.text = model.votes;
    NSString *votes =[NSString stringWithFormat:@"%ld %@",(long)[model.votes integerValue],NSLocalizedString(@"票", nil)];
    NSString *voterateString=[NSString stringWithFormat:@" | %.2f%@",[model.voterate doubleValue],@"%"];
    self.VotesAndPercentagesLabel.text=[NSString stringWithFormat:@"%@%@",votes,voterateString];
    if (model.index>11) {
        self.NoIndexLabel.text=[NSString stringWithFormat:@"%ld",(long)model.index+1];
    }else{
        self.NoIndexLabel.text=[NSString stringWithFormat:@"NO.%ld",(long)model.index+1];
        
    }
//    if (model.index==1) {
//        self.iconImageView.image = [UIImage imageNamed:@"gold"];
//    }else if (model.index==2){
//        self.iconImageView.image = [UIImage imageNamed:@"Argentum"];
//
//    }else if (model.index==3){
//        self.iconImageView.image = [UIImage imageNamed:@"copper"];
//
//    }else{
//        self.iconImageView.image = nil;
//
//    }
    _model = model;
    
}
@end
