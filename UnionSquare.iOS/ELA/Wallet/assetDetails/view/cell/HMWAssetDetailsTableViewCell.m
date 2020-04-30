//
//  HMWAssetDetailsTableViewCell.m
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWAssetDetailsTableViewCell.h"

@interface HMWAssetDetailsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *theNumberOfLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end

@implementation HMWAssetDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor=[UIColor clearColor];
    self.addressTextLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
//    asset_trade_record_out
//    asset_trade_record_in
    
//    self.stateLabel.text=@"已确认";
//    self.stateLabel.textColor=RGB(61, 169, 255);
//    self.stateLabel.text=@"确认中";
//    self.stateLabel.textColor=RGB(131, 255,122);
    
//    self.stateLabel.text=@"未打包";
//    self.stateLabel.textColor=RGB(255, 67,84);
    
    
    // Initialization code
}
-(void)setNiceNameString:(NSString *)niceNameString{
    _niceNameString=niceNameString;
    
}
-(void)setModel:(assetDetailsModel *)model{
    NSString *receivedOrSend;
    _model=model;
    NSString *imageString;
    if ([model.Direction isEqualToString:@"Received"]) {
        receivedOrSend=@"+";
        imageString=@"asset_trade_record_in";
          self.addressTextLabel.text=[NSString stringWithFormat:@"%@%@ %@",receivedOrSend,[[FLTools share]elaScaleConversionWith:model.Amount],self.niceNameString];
    }else if ([model.Direction isEqualToString:@"Sent"]){
       imageString=@"asset_trade_record_out";
       receivedOrSend=@"-";
          self.addressTextLabel.text=[NSString stringWithFormat:@"%@%@ %@",receivedOrSend,[[FLTools share]elaScaleConversionWith:model.Amount],self.niceNameString];
    }else if ([model.Direction isEqualToString:@"Deposit"]){
        imageString=@"asset_trade_record_lock";
        if ([model.Amount floatValue]>0) {
            receivedOrSend=@"-";
            self.addressTextLabel.text=[NSString stringWithFormat:@"%@%@ %@",receivedOrSend,[[FLTools share]elaScaleConversionWith:model.Amount],self.niceNameString];
        }else{
            self.addressTextLabel.text=[NSString stringWithFormat:@"%@ %@",[[FLTools share]elaScaleConversionWith:model.Amount],self.niceNameString];
        }
       
    }
    else{
        imageString=@"asset_trade_record_self";
          self.addressTextLabel.text=[NSString stringWithFormat:@"%@ %@",[[FLTools share]elaScaleConversionWith:model.Amount],self.niceNameString];
    }
     self.iconImageView.image=[UIImage imageNamed:imageString];
    self.timerLabel.text=[[FLTools share]YMDCommunityTimeConversToAllFromTimesTamp: model.Timestamp];
    self.theNumberOfLabel.text=model.Amount;
    if ([model.Status isEqualToString:@"Confirmed"]){
        self.stateLabel.text=
        NSLocalizedString(@"已确认", nil);
      
        self.stateLabel.textColor=RGB(61, 169, 255);
    }else if ([model.Status isEqualToString:@"Pending"]){
        self.stateLabel.text=  NSLocalizedString(@"确认中", nil);
        self.stateLabel.textColor=RGB(131, 255,122);
        self.timerLabel.text=@"--:--";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
