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
@property (weak, nonatomic) IBOutlet UIView *BGView;

@end

@implementation HWMVoteTheEditorialBoardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[HMWCommView share]makeBordersWithView:self.BGView];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.numberVotingTextField withTxt:NSLocalizedString(@"请输入票数", nil)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//  found_vote_select
//    found_not_select
    // Configure the view for the selected state
}
-(void)setModel:(HWMCRListModel *)model{
    self.nickNameLabel.text =model.nickname;
         self.locationLabel.text = [[FLTools share]contryNameTransLateByCode: model.location.integerValue];
         self.indexNumberLabel.text = [NSLocalizedString(@"当前排名：", nil) stringByAppendingString:@([model.index intValue ]+1).stringValue];
         self.AccountedLabel.text = [NSString stringWithFormat:@"%@ %.5lf %@",NSLocalizedString(@"投票占比：", nil),model.voterate.floatValue*100,@"%"];
         self.totalNumberVotesLabel.text=[NSString stringWithFormat:@"%@ %ld %@",NSLocalizedString(@"得票总数：", nil),[model.votes longValue],NSLocalizedString(@"票", nil)];
    NSString *imageNameString=@"found_not_select";
    if (_model.isCellSelected) {
         imageNameString=@"found_vote_select";
    }else{
         imageNameString=@"found_not_select";
    }
    self.isSelectedImageView.image =[UIImage imageNamed:imageNameString];
    _model=model;
}
-(void)setIndex:(NSIndexPath *)index{
    _index =index;
    
}
- (IBAction)addVote:(id)sender {
    self.model.isCellSelected=!self.model.isCellSelected;
    //  found_vote_select
    //    found_not_select
    NSString *imageNameString=@"found_not_select";
    if (self.model.isCellSelected) {
        
        imageNameString=@"found_vote_select";
    }else{
     
        imageNameString=@"found_not_select";
        
    }
    self.isSelectedImageView.image =[UIImage imageNamed:imageNameString];
    if (self.deleagte) {
        [self.deleagte addVoteWithIndex:self.index withVotes:self.numberVotingTextField.text];
    }
}
-(void)valuechanged{
    
    
    
    if (self.deleagte) {
        [self.deleagte VoteValueChangeWithIndex:self.index withVotes:self.numberVotingTextField.text];
    }
    
}
@end
