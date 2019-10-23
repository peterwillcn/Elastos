//
//  HMWinputVotesPopupWindowView.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWinputVotesPopupWindowView.h"


@interface HMWinputVotesPopupWindowView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *theInputNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *theNextStepButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *TagLeftLab;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isMax;

@end

@implementation HMWinputVotesPopupWindowView
-(instancetype)init{
   
    self =[[NSBundle mainBundle]loadNibNamed:@"HMWinputVotesPopupWindowView" owner:nil options:nil].firstObject;

    self.isMax=NO;
        [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.theInputNumberTextField withTxt:NSLocalizedString(@"请输入票数", nil)];
        [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
    self.TagLeftLab.text = NSLocalizedString(@"投票数量", nil);
    self.titleLab.text =NSLocalizedString(@"请输入票数", nil);
    [self.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil)
                            forState:UIControlStateNormal];
    [self.theInputNumberTextField addTarget:self action:@selector(NumberChange) forControlEvents:UIControlEventValueChanged];
    self.theInputNumberTextField.delegate=self;
    
    return self;
    
    
}
-(void)NumberChange{
    if (self.isMax) {
        self.isMax=NO;
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.theInputNumberTextField) {
        if ([self.theInputNumberTextField.text isEqualToString:@"Max"]) {
           self.theInputNumberTextField.text=nil;
            self.isMax=NO;
        }
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    
}
- (IBAction)shutDownViewEvent:(id)sender {
    [self endEditing:YES];
    [self removeFromSuperview];
}
- (IBAction)maxEvent:(id)sender {
    self.isMax=YES;
    self.theInputNumberTextField.text=@"Max";
}
- (IBAction)theNextStepEvent:(id)sender {
    if ([self.theInputNumberTextField.text integerValue]<1) {
        return;
    }
    if (self.delegate) {
        [self.delegate didHadInputVoteTicket:self.theInputNumberTextField.text WithIsMax:self.isMax];
    }
}

@end
