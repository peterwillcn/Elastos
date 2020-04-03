//
//  FLGoToIdentyAlertView.m
//  FLWALLET
//
//  Created by  on 2018/7/13.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLGoToIdentyAlertView.h"
@interface FLGoToIdentyAlertView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
@implementation FLGoToIdentyAlertView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.contentView setBackgroundColor:nil boldColor:nil corner:5];
}
- (IBAction)dissmiss:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)click:(UIButton*)sender {
    [self removeFromSuperview];
    if (self.viewCallBack) {
        self.viewCallBack(self.type);
    }
}
-(void)setType:(NSInteger)type
{
    _type = type;
    switch (type) {
        case 0:
            {
                self.titleLab.text = @"未认证用户只支持领取3个项目糖果,如您要继续领取糖果，请先实名认证。";
                self.lab2.text = @"可在“我的-实名认证”中进行认证";
                [self.btn setTitle:@"立即认证" forState:UIControlStateNormal];

            }
            break;
        case 3:
        {
            self.titleLab.text = @"未认证用户只支持领取3个项目糖果,您的认证未能通过审核，请重新认证";
            [self.btn setTitle:@"查看详情" forState:UIControlStateNormal];
            self.lab2.text = @"可在“我的-实名认证”中查看详情";
        }
            break;
        case 2:
        {
            self.titleLab.text = @"未认证用户只支持领取3个项目糖果,您的认证正在审核中，请耐心等待";
            [self.btn setTitle:@"查看详情" forState:UIControlStateNormal];
            self.lab2.text = @"可在“我的-实名认证”中查看详情";
        }
            break;
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
