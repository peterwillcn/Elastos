//
//  HWMPublicKeyListTabHeadView.m
//  elastos wallet
//
//  Created by  on 2019/9/10.
//

#import "HWMPublicKeyListTabHeadView.h"

@interface HWMPublicKeyListTabHeadView()
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;

@end


@implementation HWMPublicKeyListTabHeadView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMPublicKeyListTabHeadView" owner:nil options:nil].firstObject;
        
    }
    
    return self;
    
    
}
-(void)setType:(ListTabHeadType)type{
    if (type ==LocalPublicKeyType) {
        self.titleTextLabel.text=NSLocalizedString(@"本地公钥", nil);
    }else if (type ==ParticipatePublicKeyType){
        self.titleTextLabel.text=NSLocalizedString(@"参与公钥", nil);
    }
    _type=type;
    
    
}
@end
