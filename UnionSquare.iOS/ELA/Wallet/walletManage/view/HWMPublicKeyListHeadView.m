//
//  HWMPublicKeyListHeadView.m
//  elastos wallet
//
//  Created by  on 2019/9/10.
//

#import "HWMPublicKeyListHeadView.h"

@interface HWMPublicKeyListHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *NoSignatureTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *NoSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *PublicKeyNoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *PublicKeyNoLabel;
@property (weak, nonatomic) IBOutlet UIView *NoInfoBGView;


@end



@implementation HWMPublicKeyListHeadView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMPublicKeyListHeadView" owner:nil options:nil].firstObject;
       self.NoSignatureTextLabel.text=NSLocalizedString(@"签名数量", nil);
        self.PublicKeyNoTextLabel.text=NSLocalizedString(@"公钥数量", nil);
              self.NoInfoBGView.layer.borderWidth=0.5;
        self.NoInfoBGView.layer.borderColor=RGBA(255, 255, 255, 0.5).CGColor; self.NoInfoBGView.layer.cornerRadius=2.f;
self.NoInfoBGView.layer.masksToBounds=YES;
        
    }
    
    return self;
    
    
}
-(void)TheTotalNoMSignature:(NSString*)n withNoSignature:(NSString*)m{
    self.NoSignatureLabel.text=m;
    self.PublicKeyNoLabel.text=n;
}

@end
