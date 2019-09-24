//
//  HMWQrCodePopupWindowView.m
//  ELA
//

#import "HMWQrCodePopupWindowView.h"
#import "SGQRCodeGenerateManager.h"


@interface HMWQrCodePopupWindowView ()
@property (weak, nonatomic) IBOutlet UIImageView *QRViewImage;

@end

@implementation HMWQrCodePopupWindowView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWQrCodePopupWindowView" owner:nil options:nil].firstObject;
        self.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ancelThePage)];
        [self addGestureRecognizer:tag];
        
    }
    
    return self;
    
    
}
-(void)ancelThePage{
    
    if ([self.delegate performSelector:@selector(QrCodePopupWindowHidde)]) {
        [self.delegate QrCodePopupWindowHidde];
    }

}
-(void)setWalletAddressString:(NSString *)walletAddressString{
    NSDictionary *dic=[[FLTools share]CreateQrCodeImage:walletAddressString WithType:@"4" withSubWalletIdChain:@"ELA"];
    _walletAddressString=walletAddressString;
     self.QRViewImage.image =[[FLTools share] imageWithSize:1100.f andColorWithRed:3 Green:3 Blue:5 andQRDic:dic];
}
@end
