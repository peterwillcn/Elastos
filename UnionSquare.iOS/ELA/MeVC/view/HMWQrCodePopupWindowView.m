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
        NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:walletAddressString WithType:@"4" withSubWall:@"ELA"];
    _walletAddressString=walletAddressString;
     self.QRViewImage.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:qrcArray.firstObject imageViewWidth:self.QRViewImage.mj_w];
    
    
}
@end
