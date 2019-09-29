//
//  HWMVoteTheEditorialBoardTableViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/9/3.
//

#import "HWMVoteTheEditorialBoardTableViewCell.h"


@interface HWMVoteTheEditorialBoardTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *isSelectedImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccountedLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberVotesLabel;

@end

@implementation HWMVoteTheEditorialBoardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(HWMCRListModel *)model{
    self.nickNameLabel.text =model.nickname;
         self.locationLabel.text = [[FLTools share]contryNameTransLateByCode: model.location.integerValue];
         self.indexNumberLabel.text = [@""stringByAppendingString:@([model.index intValue ]+1).stringValue];
         self.AccountedLabel.text = [NSString stringWithFormat:@"%.5lf %@",model.voterate.floatValue*100,@"%"];
         self.totalNumberVotesLabel.text=[NSString stringWithFormat:@"%ld %@",[model.votes longValue],NSLocalizedString(@"票", nil)];
    _model=model;
}

@end
