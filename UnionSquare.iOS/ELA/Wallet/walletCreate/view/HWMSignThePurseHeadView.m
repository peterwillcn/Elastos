//
//  HWMSignThePurseHeadView.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/2.
//

#import "HWMSignThePurseHeadView.h"

@interface HWMSignThePurseHeadView ()
@property (weak, nonatomic) IBOutlet UISwitch *isAddSwitch;
@property (weak, nonatomic) IBOutlet UILabel *NumberSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *readOnlyLabel;

@end

@implementation HWMSignThePurseHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMSignThePurseHeadView" owner:nil options:nil].firstObject;
        self.NumberSignatureLabel.text=NSLocalizedString(@"签名数量", nil);
        self.readOnlyLabel.text=NSLocalizedString(@"只读", nil); self.isAddSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
        self.isAddSwitch.layer.borderWidth=2.f;
        self.isAddSwitch.layer.cornerRadius=15.f; self.isAddSwitch.layer.masksToBounds=YES;
        self.isAddSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
          [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField: self.walletNameTextField];
        self.walletNameTextField.placeholder=NSLocalizedString(@"请设置钱包名称", nil);
        self.addPurseButton.layer.borderColor=RGBA(255, 255, 255, 0.5).CGColor;
        self.addPurseButton.layer.borderWidth=0.5;
        self.addPurseButton.layer.masksToBounds=YES;
    }
    
    return self;
    
    
}

@end
