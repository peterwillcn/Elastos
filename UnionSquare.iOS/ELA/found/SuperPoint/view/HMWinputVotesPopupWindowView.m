//
//  HMWinputVotesPopupWindowView.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWinputVotesPopupWindowView.h"


@interface HMWinputVotesPopupWindowView ()
@property (weak, nonatomic) IBOutlet UITextField *theInputNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *theNextStepButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *TagLeftLab;


@end

@implementation HMWinputVotesPopupWindowView
-(instancetype)init{
   
    self =[[NSBundle mainBundle]loadNibNamed:@"HMWinputVotesPopupWindowView" owner:nil options:nil].firstObject;
    
     [self setTestFilePlaceStringColor:self.theInputNumberTextField color:RGBA(255, 255, 255, 0.5)];
    
        [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
//        self.userInteractionEnabled=YES;
//        UITapGestureRecognizer *reTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(giveUpTheInput)];
//        [self addGestureRecognizer:reTap];
    self.theInputNumberTextField.placeholder = NSLocalizedString(@"请输入票数", nil);
    self.TagLeftLab.text = NSLocalizedString(@"投票数量", nil);
    self.titleLab.text =NSLocalizedString(@"请输入票数", nil);
    [self.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil)
                            forState:UIControlStateNormal];
    
    return self;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    
}
//-(void)giveUpTheInput{
//
//
//    [self endEditing:YES];
//}
- (IBAction)shutDownViewEvent:(id)sender {
    [self endEditing:YES];
    [self removeFromSuperview];
}
- (IBAction)maxEvent:(id)sender {
    self.theInputNumberTextField.text = @(self.votes).stringValue;
}
- (IBAction)theNextStepEvent:(id)sender {
    if ([self.theInputNumberTextField.text integerValue]<1) {
        return;
    }
    if (self.delegate) {
        [self.delegate didHadInputVoteTicket:self.theInputNumberTextField.text];
    }
}

@end
