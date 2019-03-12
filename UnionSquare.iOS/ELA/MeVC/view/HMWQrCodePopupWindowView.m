//
//  HMWQrCodePopupWindowView.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
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
    _walletAddressString=walletAddressString;
     self.QRViewImage.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:walletAddressString imageViewWidth:self.QRViewImage.mj_w];
    
    
}
@end
