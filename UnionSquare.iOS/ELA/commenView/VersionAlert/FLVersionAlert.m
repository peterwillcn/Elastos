//
//  FLVersionAlert.m
//  FLWALLET
//
//  Created by  on 2018/7/30.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLVersionAlert.h"

@implementation FLVersionAlert
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.UpdataBtn setBackgroundColor:nil boldColor:nil corner:0];
    [self.GiveUpBtn setBackgroundColor:nil boldColor:RGBHex(0xFC8242) corner:0];
    self.contentView.layer.cornerRadius = 8;
}
+(instancetype)defultView{
    FLVersionAlert *v = [[NSBundle mainBundle]loadNibNamed:@"FLVersionAlert" owner:nil options:nil].firstObject;
    v.frame = [UIScreen mainScreen].bounds;
    return v;
}
- (IBAction)openUrl:(id)sender {
  BOOL ret =   [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:self.updataUrl]];
    if (ret) {
         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.updataUrl]];
    }
}
- (IBAction)RemoveSelf:(id)sender {
    [self removeFromSuperview];

}

@end
