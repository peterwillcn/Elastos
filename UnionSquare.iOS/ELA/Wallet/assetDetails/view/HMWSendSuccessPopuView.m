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
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation HMWSendSuccessPopuView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWSendSuccessPopuView" owner:nil options:nil].firstObject;
        [[HMWCommView share]makeBordersWithView:self.BGView];
       
        self.showInfoLabel.text=NSLocalizedString(@"交易发送成功，\n 请耐心等待交易确认", nil);
        self.showImageView.image=[UIImage imageNamed:@"window_waiting"];
    }
    
    return self;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    self.hidden = YES;
}
-(void)setType:(SendSuccessType)type{
    
    
    if (type==sendDealType) {
        
    }else if (type==saveSuccessType){
         self.showInfoLabel.text=NSLocalizedString(@"保存成功", nil);
        
    }else if (type==SignatureSuccessType){
            self.showInfoLabel.text=NSLocalizedString(@"签名发送成功", nil);
    }else if (type==SignatureFailureType){
            self.showInfoLabel.text=NSLocalizedString(@"签名发送失败，请稍后重试", nil);
         self.showImageView.image=[UIImage imageNamed:@"window_waiting_failed"];
    }
    _type=type;
}
@end
