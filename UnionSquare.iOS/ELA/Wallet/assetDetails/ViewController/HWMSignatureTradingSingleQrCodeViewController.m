//
//  HWMSignatureTradingSingleQrCodeViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/16.
//

#import "HWMSignatureTradingSingleQrCodeViewController.h"
#import "SGQRCodeGenerateManager.h"
#import "FirstViewController.h"

@interface HWMSignatureTradingSingleQrCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *showInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *backFistButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showInfoLabelTopOffSet;
@property (weak, nonatomic) IBOutlet UIView *PublicAddressBGVIEW;

@property (weak, nonatomic) IBOutlet UILabel *PublicAddressLable;
@end

@implementation HWMSignatureTradingSingleQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.navigationController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareInfo)];
    [[HMWCommView share]makeBordersWithView:self.backFistButton];
    switch (self.type) {
        case SingleSignReadOnlyToBeSigned:
            self.title=NSLocalizedString(@"待签名交易", nil);
              [self.backFistButton setTitle:NSLocalizedString(@"已完成签名，立即广播", nil) forState:UIControlStateNormal];self.showInfoLabel.text=NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil);
            break;
        case SingleSignReadOnlySignedDeals:
               self.title=NSLocalizedString(@"已签名交易", nil); self.showInfoLabel.text=NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil);
            break;
        case HowSignToBeSigned:
        {
             self.title=NSLocalizedString(@"待签名交易", nil);
            [self.backFistButton setTitle:NSLocalizedString(@"返回首页", nil) forState:UIControlStateNormal];
            self.showInfoLabel.text=[NSString stringWithFormat:@"%@(%@%@%@%@)",NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil),NSLocalizedString(@"已签名：", nil),@"1",NSLocalizedString(@"待签名：", nil),@"2"];
            break;
            
        }
        case HowSignSignedDeals:
        {
            self.title=NSLocalizedString(@"已签名交易", nil);
            [self.backFistButton setTitle:NSLocalizedString(@"返回首页", nil) forState:UIControlStateNormal];
            self.showInfoLabel.text=[NSString stringWithFormat:@"%@(%@%@%@%@)",NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil),NSLocalizedString(@"已签名：", nil),@"1",NSLocalizedString(@"待签名：", nil),@"0"];
            break;
            
        }
        case ExportReadOnlyWallet:
        {
            self.title=NSLocalizedString(@"导出只读钱包", nil);
            self.backFistButton.alpha=0.f;
            self.showInfoLabel.text=NSLocalizedString(@"扫描二维码可创建单签只读钱包", nil);
            self.navigationController.navigationItem.rightBarButtonItem=nil;
         
            
            break;
            
        }
        case LookhHowSignThePublicKey:
        {
            self.title=NSLocalizedString(@"多签公钥", nil);
            self.PublicAddressBGVIEW.alpha=1.f;
            self.showInfoLabelTopOffSet.constant=99;
            self.PublicAddressLable.text=self.QRCodeString;
            [self.backFistButton setTitle:NSLocalizedString(@"复制多签公钥", nil) forState:UIControlStateNormal];
            self.showInfoLabel.text=NSLocalizedString(@"扫描二维码可创建多签钱包", nil);
            self.navigationController.navigationItem.rightBarButtonItem=nil;
            break;
            
        }
        default:
            break;
    }
    self.QrCodeImageView.image =[[FLTools share] imageWithSize:750.f andColorWithRed:1 Green:3 Blue:5 andQRDic:self.QRCodeDic];
}
-(void)shareInfo{
    [self mq_share:[NSArray arrayWithObject:self.QrCodeImageView.image]];
    
}
-(void)mq_share:(NSArray *)items{
    if (items.count == 0) {
        return;
    }
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    activityVC.excludedActivityTypes = [self excludetypes];
    
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
    };
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)backFistAction:(id)sender {
    
    switch (self.type) {
        case SingleSignReadOnlyToBeSigned:
            
//            [self.backFistButton setTitle:NSLocalizedString(@"已完成签名，立即广播", nil) forState:UIControlStateNormal];
            break;
        case SingleSignReadOnlySignedDeals:
       
            break;
        case HowSignToBeSigned:
        {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[FirstViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            break;
            
        }
        case HowSignSignedDeals:
        {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[FirstViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            break;
            
        }
        case ExportReadOnlyWallet:
        {
           
            break;
            
        }
        case LookhHowSignThePublicKey:
        {
            [UIPasteboard generalPasteboard].string = self.QRCodeString;
            [[FLTools share]showErrorInfo:NSLocalizedString(@"多签公钥已复制到粘贴板", nil)];
            
        }
        default:
            break;
    }
    
}
-(NSArray *)excludetypes{
    
    NSMutableArray *excludeTypesM =  [NSMutableArray arrayWithArray:@[//UIActivityTypePostToFacebook,
                                                                      UIActivityTypePostToTwitter,
                                                                      UIActivityTypePostToWeibo,
                                                                      UIActivityTypeMessage,
                                                                      UIActivityTypeMail,
                                                                      UIActivityTypePrint,
                                                                      UIActivityTypeCopyToPasteboard,
                                                                      UIActivityTypeAssignToContact,
                                                                      UIActivityTypeSaveToCameraRoll,
                                                                      UIActivityTypeAddToReadingList,
                                                                      UIActivityTypePostToFlickr,
                                                                      UIActivityTypePostToVimeo,
                                                                      UIActivityTypePostToTencentWeibo,
                                                                      UIActivityTypeAirDrop,
                                                                      UIActivityTypeOpenInIBooks]];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
        [excludeTypesM addObject:UIActivityTypeMarkupAsPDF];
    }
    
    return excludeTypesM;
}
-(void)setQRCodeString:(NSString *)QRCodeString{
    _QRCodeString=QRCodeString;
    
}
-(void)setQRCodeDic:(NSDictionary *)QRCodeDic{
    _QRCodeDic=QRCodeDic;
    
}
@end
