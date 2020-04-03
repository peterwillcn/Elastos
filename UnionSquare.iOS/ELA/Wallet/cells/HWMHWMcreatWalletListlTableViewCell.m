//
//  HWMHWMcreatWalletListlTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/7/2.
//

#import "HWMHWMcreatWalletListlTableViewCell.h"


@interface HWMHWMcreatWalletListlTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *walletTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@end
@implementation HWMHWMcreatWalletListlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDic:(NSDictionary *)dic{
    self.iconImageView.image=[UIImage imageNamed:dic[@"image"]];
    self.walletTypeLabel.text=dic[@"name"];
    
}
@end
