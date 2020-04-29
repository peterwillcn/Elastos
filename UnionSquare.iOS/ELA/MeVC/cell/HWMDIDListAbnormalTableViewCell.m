//
//  HWMDIDListAbnormalTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/10/30.
//

#import "HWMDIDListAbnormalTableViewCell.h"

@interface HWMDIDListAbnormalTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *DIDNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *didStateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottmOff;

@end

@implementation HWMDIDListAbnormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.BGView.layer.cornerRadius=5.f;
    self.BGView.layer.masksToBounds=YES;
    self.didStateLabel.text=NSLocalizedString(@"暂无",nil);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setModel:(HWMDIDInfoModel *)model{
    if (self.hasSave) {
        self.timeLabel.alpha=0.f;
        self.DIDNameLabel.text=NSLocalizedString(@"个人信息",nil);
        self.stateLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"保存时间：",nil),[[FLTools share] YMDCommunityTimeConversToAllFromTimesTamp:model.editTime]];
        self.didStateLabel.alpha=0.f;
        self.bottmOff.constant=20.f;
    }else{
        self.stateLabel.alpha=0.f;
        self.bottmOff.constant=5.f;
        self.didStateLabel.alpha=1.f;
    }
    _model =model;
    
    
    
    
}
-(void)setTitleString:(NSString *)titleString{
    self.timeLabel.alpha=0.f;
    _titleString=titleString;
    self.noInfoLabel.alpha=0.f;
    NSString *timeString=self.model.editTime;
    if ([titleString isEqualToString:NSLocalizedString(@"个人信息", nil)]){
        //        if (![[FLTools share]isBlankString:self.model.infoTimeString]) {
        //            titleString=self.model.infoTimeString;
        //        }
        
    }else if ([titleString isEqualToString:NSLocalizedString(@"个人简介qe", nil)]){
        //              if (![[FLTools share]isBlankString:self.model.introductionInfoString]) {
        //                        titleString=self.model.introductionInfoString;
        //                  if ([[FLTools share]isBlankString:self.model.introduction]) {
        //                      self.noInfoLabel.alpha=1.f;
        //                      self.noInfoLabel.text=NSLocalizedString(@"暂无", nil);
        //                  }
        //              }
        
    }else if ([titleString isEqualToString:NSLocalizedString(@"社交账号", nil)]){
        //           if (![[FLTools share]isBlankString:self.model.socialAccountTimeString]) {
        //                                titleString=self.model.socialAccountTimeString;
        //                            }
    }
    self.DIDNameLabel.text=titleString;
    self.stateLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"保存时间：",nil),[[FLTools share] YMDCommunityTimeConversToAllFromTimesTamp:timeString]];
    self.stateLabel.textColor=RGBA(255, 255, 255, 0.5);
}
@end
