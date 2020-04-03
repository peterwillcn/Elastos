//
//  HMWtransferTransactionSingleAddressDetailsView.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtransferTransactionSingleAddressDetailsView.h"

@interface HMWtransferTransactionSingleAddressDetailsView ()
@property (weak, nonatomic) IBOutlet UILabel *transactionNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendTheAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *poundageLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *theNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *poundageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *poundageTop;
@property (weak, nonatomic) IBOutlet UIButton *transactionDetailsButton;

@property (weak, nonatomic) IBOutlet UILabel *addressTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *theNumberTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *noteTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *feeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendBlanceTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionAmountTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *TransactionNumberTextLabel;

@end

@implementation HMWtransferTransactionSingleAddressDetailsView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWtransferTransactionSingleAddressDetailsView" owner:nil options:nil].firstObject;
                [[HMWCommView share]makeBordersWithView:self.bgView];
       self.addressTextLabel.text= NSLocalizedString(@"接收地址", nil);
    self.timeTextLabel.text=NSLocalizedString(@"确认时间", nil);
self.theNumberTextLabel.text=NSLocalizedString(@"确认次数", nil);
       
        self.noteTextLabel.text=NSLocalizedString(@"备注", nil);
        self.feeTextLabel.text=NSLocalizedString(@"手续费", nil);
    self.sendBlanceTextLabel.text=NSLocalizedString(@"发送金额", nil);
        self.transactionAmountTextLabel.text=NSLocalizedString(@"交易金额", nil);
        self.TransactionNumberTextLabel.text=NSLocalizedString(@"交易号", nil);
    }
    
    return self;
}


- (IBAction)checkTheTransactionDetailsEvent:(id)sender {
    self.transactionDetailsButton.userInteractionEnabled=NO;
    
    self.transactionDetailsButton.userInteractionEnabled=YES;
}

-(void)setType:(transactionSingleType)type{
    _type=type;
    if (type==0) {
        
       self.poundageHeight.constant=0.f;
        self.poundageTop.constant=0.f;
        
    }else if (type==1){
        
        
    }
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
@end
