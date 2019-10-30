//
//  HWMDIDInfoTableViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/30.
//

#import "HWMDIDInfoTableViewCell.h"

@interface HWMDIDInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation HWMDIDInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)copyEvent:(id)sender {
}

@end
