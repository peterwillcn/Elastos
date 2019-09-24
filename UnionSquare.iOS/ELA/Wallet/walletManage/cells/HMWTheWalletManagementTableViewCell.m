//
//  HMWTheWalletManagementTableViewCell.m
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWTheWalletManagementTableViewCell.h"



@interface HMWTheWalletManagementTableViewCell ()
    @property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *walletNameLabel;
    
@end
@implementation HMWTheWalletManagementTableViewCell
    



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)dic{
    
    
    _dic=dic;
    
    self.titleNameLabel.text=dic[@"title"];
    if ([dic[@"type"] isEqualToString:@"1"]) {
       self.walletNameLabel.text=dic[@"name"];
    }else{
        
        self.walletNameLabel.text=@"";
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
