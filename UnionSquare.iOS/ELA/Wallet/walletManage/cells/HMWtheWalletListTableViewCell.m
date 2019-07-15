//
//  HMWtheWalletListTableViewCell.m
//  ELA
//
//  Created by  on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtheWalletListTableViewCell.h"


@interface HMWtheWalletListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *blanceLabel;

@end

@implementation HMWtheWalletListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(FMDBWalletModel *)model{
    _model=model;
    
    self.walletNameLabel.text=model.walletName;
   
//       self.walletAddressLabel.text=model.walletAddress;
    
    if (model.balanceString.length>0) {
      self.blanceLabel.text=model.balanceString;
    }
   
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
