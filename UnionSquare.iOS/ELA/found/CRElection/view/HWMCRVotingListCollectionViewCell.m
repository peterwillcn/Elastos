//
//  HWMCRVotingListCollectionViewCell.m
//  elastos wallet
//
//  Created by  on 2019/9/4.
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
-(void)setModel:(HWMCRListModel *)model{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
    self.nickNameLabel.text = model.nickname;
        self.NOIndexLabel.text=[NSString stringWithFormat:@"%ld",(long)[model.index integerValue]];
        if (model.isCellSelected==NO) {
            if (model.isNewCellSelected) {
                self.selecIconImageView.image=[UIImage imageNamed:@"found_vote_select"];
                }else{
               self.selecIconImageView.image=[UIImage imageNamed:@"found_not_select"];
              }
            }else{
               self.selecIconImageView.image=[UIImage imageNamed:@"selected_already"];
            }

    _model = model;
    
}
@end
