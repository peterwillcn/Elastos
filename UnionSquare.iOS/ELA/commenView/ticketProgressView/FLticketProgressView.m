//
//  FLticketProgressView.m
//  FLWALLET
//
//  Created by  on 2018/11/15.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import "FLticketProgressView.h"

@interface FLticketProgressView ()
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end
@implementation FLticketProgressView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.contenView.layer.cornerRadius = 5;
}
-(void)setType:(NSInteger)type
{
    _type = type;
    switch (type) {
        case 1:
            {
                self.contenView.mj_size = CGSizeMake(240, 240);
                
            }
            break;
        case 2 :
        {
           self.contentHeight.constant = 140;
            self.img.hidden = YES;
            self.subText.hidden = YES;
        }
            break;
            
        default:
            break;
    }

}
- (IBAction)clickBack:(id)sender {
    if (self.delegate) {
        [self.delegate flview:self ClickType:self.type];
    }
}
- (IBAction)removeView:(id)sender {
    [self removeFromSuperview];
}

@end
