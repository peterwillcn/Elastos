//
//  HWMSignThePurseHeadView.m
//  elastos wallet
//
//  Created by  on 2019/7/2.
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
        self.SingleAddressSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
          self.SingleAddressSwitch.layer.borderWidth=2.f;
          self.SingleAddressSwitch.layer.cornerRadius=15.f;
          self.SingleAddressSwitch.layer.masksToBounds=YES;
      self.SingleAddressSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
        [self.addPurseButton setTitle:NSLocalizedString(@"添加私钥", nil) forState:UIControlStateNormal];
          [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField: self.walletNameTextField withTxt:NSLocalizedString(@"请设置钱包名称", nil)];
        [[HMWCommView share]makeBordersWithView:self.self.addPurseButton];
        self.addPurseButton.layer.borderColor=RGBA(255, 255, 255, 1).CGColor;
        self.addPurseButton.layer.borderWidth=1;
        self.addPurseButton.layer.masksToBounds=YES;
        
        [self addSingChuange:nil];
        
    }
    
    return self;
    
    
}
- (IBAction)addSingChuange:(id)sender {
    if (self.isAddSwitch.isOn) {
        self.addPurseButton.alpha=0.5;
        self.addPurseButton.userInteractionEnabled=NO;
    }
    else{
        self.addPurseButton.alpha=1;
        self.addPurseButton.userInteractionEnabled=YES;
    }
}

@end
