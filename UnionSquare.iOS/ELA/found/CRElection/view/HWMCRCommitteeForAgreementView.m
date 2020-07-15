//
//  HWMCRCommitteeForAgreementView.m
//  elastos wallet
//
//  Created by  on 2019/11/26.
//

#import "HWMCRCommitteeForAgreementView.h"


@interface HWMCRCommitteeForAgreementView ()
@property (weak, nonatomic) IBOutlet UILabel *agreeTextInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeTextInfoButton;

@property (weak, nonatomic) IBOutlet UILabel *titleInfo;
@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIButton *makeSureButton;
@end


@implementation HWMCRCommitteeForAgreementView
-(instancetype)init{
   
    self =[[NSBundle mainBundle]loadNibNamed:@"HWMCRCommitteeForAgreementView" owner:nil options:nil].firstObject;
    [self setBackgroundImg]; self.titleInfo.text=NSLocalizedString(@"CR委员参选协议", nil);
    self.makeSureButton.layer.borderWidth=0.5f;
    self.makeSureButton.layer.borderColor=RGBA(255, 255, 255, 0.5).CGColor;
    self.infoTextView.editable=NO;
    [self.makeSureButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    self.agreeTextInfoLabel.text=NSLocalizedString(@"我已阅读并同意以上条款", nil);
    [[HMWCommView share]makeBordersWithView:self.infoBGView];
    self.infoTextView.text=NSLocalizedString(@"cragreementcontent", nil);
    self.infoBGView.layer.cornerRadius=5.f;
    self.makeSureButton.enabled=NO;
    return self;
}
- (IBAction)closeView:(id)sender {
    if (self.delegate) {
        [self.delegate closeView];
    }
}
- (IBAction)makeSureEvent:(id)sender {
    if (self.delegate) {
        [self.delegate Agreed];
    }
}
- (IBAction)RefusedEvent:(id)sender {
    if (self.delegate) {
           [self.delegate closeView];
       }
}
-(void)setBackgroundImg{
    UIImageView *bg = [[UIImageView alloc]initWithFrame:self.bounds];
        [self CAGradientColorFrome:RGB(83, 136, 136) withToColor:RGB(16, 47, 58) withView:bg];
    [self insertSubview:bg atIndex:0];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

-(void)CAGradientColorFrome:(UIColor*)fclolr withToColor:(UIColor*)tcolor withView:(UIView*)view{
CAGradientLayer *gl = [CAGradientLayer layer];
gl.frame = CGRectMake(0,0,AppWidth,AppHeight);
gl.colors = @[(__bridge id)fclolr.CGColor,(__bridge id)tcolor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer addSublayer:gl];
    
}
- (IBAction)agreeTextInfoEvent:(id)sender {
    
    self.agreeTextInfoButton.selected=!self.agreeTextInfoButton.selected;
    [self updaIcon];
}
-(void)updaIcon{
    if (self.agreeTextInfoButton.selected) {
        self.selectedImageView.image=[UIImage imageNamed:@"found_vote_select"];
       [self setBackgroundImg];
             [[HMWCommView share]makeBordersWithView:self.makeSureButton];
       self.makeSureButton.enabled=YES;
    }else{
         self.selectedImageView.image=[UIImage imageNamed:@"found_not_select"];
        self.makeSureButton.layer.borderWidth=0.5f;
        self.makeSureButton.layer.borderColor=RGBA(255, 255, 255, 0.5).CGColor;
        self.makeSureButton.enabled=NO;
        
    }
    self.makeSureButton.selected=self.agreeTextInfoButton.selected;
    
}
@end
