//
//  HWMTheAreaCodeAndPhonenumberTableViewCell.m
//  elastos wallet
//
//  Created by  on 2019/10/25.
//

#import "HWMTheAreaCodeAndPhonenumberTableViewCell.h"

@implementation HWMTheAreaCodeAndPhonenumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectIndexView:(id)sender {
    if (self.delegate) {
        [self.delegate delegateViewWithDic:self.dic];
    }
}
-(void)setDic:(NSDictionary *)dic{
    _dic=dic;
}
@end
