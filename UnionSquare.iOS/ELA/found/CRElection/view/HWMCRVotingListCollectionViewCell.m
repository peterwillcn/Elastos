//
//  HWMCRVotingListCollectionViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/9/4.
//

#import "HWMCRVotingListCollectionViewCell.h"

@interface HWMCRVotingListCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *NOIndexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selecIconImageView;
@property (weak, nonatomic) IBOutlet UIView *BGView;

@end

@implementation HWMCRVotingListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      [[HMWCommView share]makeBordersWithView:self];
}
-(void)setModel:(FLCoinPointInfoModel *)model{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconImageUrl] placeholderImage:[UIImage imageNamed:@"found_vote_initial_r"]];
    self.nickNameLabel.text = model.nickname;
        self.NOIndexLabel.text=[NSString stringWithFormat:@"%ld",(long)model.index+1];
        if (model.isCellSelected) {
    self.selecIconImageView.image=[UIImage imageNamed:@"found_vote_select"];
        }else{
        self.selecIconImageView.image=[UIImage imageNamed:@"found_not_select"];
        }

    _model = model;
    
}

@end
