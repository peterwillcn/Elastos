//
//  HMWSendSuccessPopuView.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWSendSuccessPopuView.h"

@interface HMWSendSuccessPopuView ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *showInfoLabel;

@end

@implementation HMWSendSuccessPopuView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWSendSuccessPopuView" owner:nil options:nil].firstObject;
        [[HMWCommView share]makeBordersWithView:self.BGView];
       
        self.showInfoLabel.text=NSLocalizedString(@"交易发送成功，\n 请耐心等待交易确认", nil);
        
    }
    
    return self;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    self.hidden = YES;
}
@end
