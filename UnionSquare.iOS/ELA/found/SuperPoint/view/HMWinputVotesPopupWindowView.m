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

    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.theInputNumberTextField withTxt:NSLocalizedString(@"请输入票数", nil)];
        [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
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
