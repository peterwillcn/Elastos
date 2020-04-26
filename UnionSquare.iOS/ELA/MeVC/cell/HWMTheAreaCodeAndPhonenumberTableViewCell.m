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
    [self addRigehtView];
    
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
-(void)addRigehtView{
    
    self.theArNumberTextField.leftView=[self tfRightViewWithText:@"区号" withWidt:60];
    self.MobilePhoneTextField.leftView=[self tfRightViewWithText:@"手机号" withWidt:70];
    self.MobilePhoneTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    
}
-(UIView*)tfRightViewWithText:(NSString*)text withWidt:(CGFloat)wd{
    UIView *rgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, wd, 44)];
    
    UILabel *labe=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,wd, 44)];
    labe.numberOfLines=0;
    labe.text=[NSString stringWithFormat:@"%@   ",NSLocalizedString(text, nil)];
    labe.textColor=RGBA(255, 255, 255, 0.5);
    labe.font=[UIFont systemFontOfSize:14];
    labe.textAlignment=NSTextAlignmentLeft;
    [rgView  addSubview:labe];
    
    return rgView;
    
}
@end
