//
//  HMWtheWalletListTableViewCell.m
//  ELA
//
//  Created by  on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtheWalletListTableViewCell.h"


@interface HMWtheWalletListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *blanceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labeSuperLeftOffSet;
@end

@implementation HMWtheWalletListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FMDBWalletModel *)model{
    _model=model;
    
 
   
//       self.walletAddressLabel.text=model.walletAddress;
    NSString *imageName=@"single_wallet";
    switch (model.TypeW) {
        case SingleSign:
            imageName=@"single_wallet";
         self.walletNameLabel.text=  [NSString stringWithFormat:@"%@",model.walletName];
            break;
        case SingleSignReadonly:
            imageName=@"single_walllet_readonly";
             self.walletNameLabel.text=  [NSString stringWithFormat:@"%@",model.walletName];
            break;
        case HowSign:
            imageName=@"multi_wallet";
            self.walletNameLabel.text=  [NSString stringWithFormat:@"%@",model.walletName];
            break;
        case HowSignReadonly:
            imageName=@"multi_wallet_readonly";
             self.walletNameLabel.text=[NSString stringWithFormat:@"%@",model.walletName];
            break;
            
        default:
            break;
    }
    self.iconImageVIew.image=[UIImage imageNamed:imageName];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)setTypeString:(NSString *)typeString{
//    if ([typeString isEqualToString:@"1"]) {
//        self.labeSuperLeftOffSet.constant=17;
//        self.iconImageVIew.alpha=0.f;
//    }
//
//}

@end
