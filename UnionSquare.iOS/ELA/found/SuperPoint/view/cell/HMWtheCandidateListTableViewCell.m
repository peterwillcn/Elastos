//
//  HMWtheCandidateListTableViewCell.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWtheCandidateListTableViewCell.h"


@interface HMWtheCandidateListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *BGView;

@end

@implementation HMWtheCandidateListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeBordersWithView:self.BGView];
  

    // Initialization code
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
             self.contryName.text =locationLabelString;
        });
   
    NSLog(@"model.index====%ld",(long)model.index);
    self.indexLab.text = [NSString stringWithFormat:@"NO.%@",@(model.index+1).stringValue];
    self.percentLab.text = [NSString stringWithFormat:@"%@ %@",[[FLTools share]DownTheValue:model.voterate withLength:2],@"%"];
    
}
- (IBAction)btnAction:(id)sender {
    if (self.delegate) {
        [self.delegate selecet:self.model action:1];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.BGView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.15];
    
    if (selected) {
        
          [self.isSelectBtn setImage:[UIImage imageNamed:@"found_vote_select"] forState:UIControlStateNormal];
    }else{
      [self.isSelectBtn setImage:[UIImage imageNamed:@"asset_linkman"] forState:UIControlStateNormal];
    }
    // Configure the view for the selected state
}

@end
