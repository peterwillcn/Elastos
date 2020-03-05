//
//  HWMCreateDIDListTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/10/21.
//

#import "HWMCreateDIDListTableViewCell.h"

@interface HWMCreateDIDListTableViewCell ()

@end


@implementation HWMCreateDIDListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)deleateListInfoEvent:(id)sender {
    if (self.delegate) {
        [self.delegate deleteWithIndex:self.index];
    }
}
-(void)setIndex:(NSString *)index{
    _index=index;
}

@end
