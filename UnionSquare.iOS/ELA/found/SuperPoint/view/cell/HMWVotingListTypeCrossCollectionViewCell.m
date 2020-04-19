//
//  HMWVotingListTypeCrossCollectionViewCell.m
//  elastos wallet
//
//  Created by  on 2019/6/17.
//

#import "HMWVotingListTypeCrossCollectionViewCell.h"


@interface HMWVotingListTypeCrossCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *contryName;
@property (weak, nonatomic) IBOutlet UILabel *indexLab;
@property (weak, nonatomic) IBOutlet UILabel *percentLab;
@property (weak, nonatomic) IBOutlet UILabel *tickNumberLab;
@property (weak, nonatomic) IBOutlet UIImageView *coinIconImageView;

@end
@implementation HMWVotingListTypeCrossCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
       [[HMWCommView share]makeBordersWithView:self];
    self.coinIconImageView.layer.cornerRadius=15.f;
    self.coinIconImageView.layer.masksToBounds=YES;

}
-(void)setModel:(FLCoinPointInfoModel *)model
{
    _model  = model;
    self.nickName.text = model.nickname;
    
    dispatch_group_t group =  dispatch_group_create();
       __block NSString *locationLabelString;
      dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         locationLabelString= [[FLTools share]contryNameTransLateByCode:[model.location intValue]];
       });
      dispatch_group_notify(group, dispatch_get_main_queue(), ^{
             self.contryName.text = locationLabelString;
           
       });
    self.indexLab.text = [@""stringByAppendingString:@(model.index+1).stringValue];
    self.percentLab.text = [NSString stringWithFormat:@"%@ %@",[[FLTools share] DownTheValue:model.voterate withLength:2],@"%"];
    self.tickNumberLab.text=[NSString stringWithFormat:@"%ld %@",[model.votes longValue],NSLocalizedString(@"票", nil)];
     [self.coinIconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconImageUrl] placeholderImage:[UIImage imageNamed:@"point_list_ela"]];
}
-(void)setCRModel:(HWMCRListModel *)CRModel{


        self.nickName.text = CRModel.nickname;
    
    dispatch_group_t group =  dispatch_group_create();
        __block NSString *locationLabelString;
       dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          locationLabelString= [[FLTools share]contryNameTransLateByCode:[CRModel.location intValue]];
        });
       dispatch_group_notify(group, dispatch_get_main_queue(), ^{
              self.contryName.text = locationLabelString;
            
        });    
        self.indexLab.text = CRModel.index;
        self.percentLab.text = [NSString stringWithFormat:@"%@ %@",CRModel.voterate,@"%"];
        self.tickNumberLab.text=[NSString stringWithFormat:@"%ld %@",[CRModel.votes longValue],NSLocalizedString(@"票", nil)];
     self.coinIconImageView.image=[UIImage imageNamed:@"found_vote_initial"];
    if (CRModel.iconImageUrl.length>0) {
        [[FLTools share]loadUrlSVGAndPNG:CRModel.iconImageUrl WithSuccessBlock:^(id data) {
            if (data!=nil){
                self.coinIconImageView.image =data;
            }
        }];
    }
    
    _CRModel  = CRModel;
    
    
}
@end
