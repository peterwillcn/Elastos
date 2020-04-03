//
//  FLNetErrorView.m
//  FLWALLET
//
//  Created by  on 2018/6/21.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLNetErrorView.h"

@implementation FLNetErrorView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, AppWidth, AppHeight);
  
}
+(instancetype)defultView{
    FLNetErrorView*v = [[NSBundle mainBundle]loadNibNamed:@"FLNetErrorView" owner:nil options:nil].firstObject;
    return v;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.type==1) {
        return;
    }
    if (self.callBack) {
        self.callBack();
    }
}

-(void)setType:(NSInteger)type
{
    _type = type;
    switch (type) {
        case 1:
        {
            self.img.image = [UIImage  imageNamed:@"expect"];
            self.textLab.text = @"敬请期待....";
        }
            break;
        case 2:
        {
            self.img.image = [UIImage  imageNamed:@"cnto_empty_page"];
            self.textLab.text = @"目前暂无发送记录";
        }
            break;
        default:
            break;
    }
}
@end
