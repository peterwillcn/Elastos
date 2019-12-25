//
//  HWMDIDListNormalTableViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/30.
//

#import "HWMDIDListNormalTableViewCell.h"

@interface HWMDIDListNormalTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *DIDNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIDAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HWMDIDListNormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.BGView.layer.cornerRadius=5.f;
    self.BGView.layer.masksToBounds=YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)copyDIDaddressEvent:(id)sender {
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
    
    
}
@end
