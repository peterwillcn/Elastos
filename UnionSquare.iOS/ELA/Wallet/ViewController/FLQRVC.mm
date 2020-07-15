//
//  FLQRVC.m
//  FLWALLET
//
//  Created by  on 2018/4/17.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLQRVC.h"
#import "SGQRCodeGenerateManager.h"
@interface FLQRVC ()

@property (weak, nonatomic) IBOutlet UIImageView *QRViewImage;
@property (weak, nonatomic) IBOutlet UILabel *addrLab;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end

@implementation FLQRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.title = NSLocalizedString(@"收款码", nil);
//    Localized(@"收款码");
    [self.addrLab setBackgroundColor:nil boldColor:nil corner:5];
    [self.btn1 setBackgroundColor:defultColor boldColor:nil corner:5];
    [self.btn2 setBackgroundColor:[UIColor whiteColor] boldColor:defultColor corner:5];
    
        self.addrLab.text = self.addr;
       // self.QRViewImage.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:self.addr imageViewWidth:self.QRViewImage.mj_w];
}
-(void)fenxiang{
    
    [self shareArray:@[self.addr]];
    
}
- (IBAction)CopyAddr:(UIButton*)sender {
    UIPasteboard *bord = [UIPasteboard generalPasteboard];
    bord.string = self.addr;
   [[FLTools share]showErrorInfo:NSLocalizedString(@"收款地址已复制成功", nil)];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self defultBack];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


@end
