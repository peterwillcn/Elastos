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
    //    [[HMWCommView share]makeBordersWithView:self.LimitThatLabel];
//    self.LimitThatLabel.backgroundColor=RGBA(83, 136, 136, 1);
//    self.LimitThatLabel.layer.cornerRadius=2.f;
//    self.LimitThatLabel.layer.masksToBounds=YES;
    self.intPutTextField.delegate=self;
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
- (IBAction)done:(id)sender {
    [self endEditing:YES];
    
}
@end
