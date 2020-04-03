//
//  FLCapitalView.m
//  FLWALLET
//
//  Created by  on 2018/4/16.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLCapitalView.h"
@interface FLCapitalView ()
@property (weak, nonatomic) IBOutlet UIButton *QRBtn;
@end

@implementation FLCapitalView
//二维码点击
- (IBAction)QRClick:(id)sender {
    if (self.delegaate) {
        [self.delegaate capitalViewDidClick:1];
    }
}

//备份点击
- (IBAction)copyBtnClick:(UIButton*)sender {
    if (self.delegaate) {
        [self.delegaate capitalViewDidClick:3];
    }
}



@end
