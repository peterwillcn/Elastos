//
//  HWMSignatureTradingSingleQrCodeViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/16.
//

#import "HWMSignatureTradingSingleQrCodeViewController.h"
#import "SGQRCodeGenerateManager.h"
#import "FirstViewController.h"
#import "HW3DBannerView.h"


@interface HWMSignatureTradingSingleQrCodeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *QrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *showInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *backFistButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showInfoLabelTopOffSet;
@property (weak, nonatomic) IBOutlet UIView *PublicAddressBGVIEW;

@property (weak, nonatomic) IBOutlet UILabel *PublicAddressLable;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *QrCodeType;

@property (weak, nonatomic) IBOutlet UIView *MQRCoreView;

@property (weak, nonatomic) IBOutlet UILabel *IdentificationCodeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *IdentificationCodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *MBGQRCodeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pageIconImageView;
/*
 *<# #>
 */
@property(strong,nonatomic)HW3DBannerView *QRCodeScrllV;
/*
 *<# #>
 */
@property(copy,nonatomic)NSMutableArray *allQRCodeImageArray;
@property (weak, nonatomic) IBOutlet UIImageView *singQRCodeBGImageView;

@end

@implementation HWMSignatureTradingSingleQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    [[HMWCommView share]makeBordersWithView:self.backFistButton];
    self.IdentificationCodeTextLabel.text=NSLocalizedString(@"识别码", nil);
    self.IdentificationCodeLabel.text=[NSString stringWithFormat:@"【%@】",self.QRCodeDic[@"ID"]];
    switch (self.type) {
        case SingleSignReadOnlyToBeSigned:{
            self.QrCodeType=@"3";
            self.title=NSLocalizedString(@"待签名交易", nil);
              [self.backFistButton setTitle:NSLocalizedString(@"已完成签名，立即广播", nil) forState:UIControlStateNormal];self.showInfoLabel.text=NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil);
               NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            if (qrcArray.count==1) {
                 self.QrCodeImageView.image =[[FLTools share] imageWithSize:700.f andColorWithRed:1 Green:3 Blue:5 andQRString:self.QRCodeString];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
            }else if (qrcArray.count>1){
                self.QrCodeImageView.alpha=0.f;
                self.singQRCodeBGImageView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=1.f;
                self.MQRCoreView.alpha=1.f;
                [self allQRCodeImageViewDataArray:qrcArray];
                
            }
            
            break;
            
        }
        case SingleSignReadOnlySignedDeals:{
          self.QrCodeType=@"3";
            self.title=NSLocalizedString(@"已签名交易", nil); self.showInfoLabel.text=NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil);
            NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            if (qrcArray.count==1) {
                
                self.QrCodeImageView.image =[[FLTools share] imageWithSize:700.f andColorWithRed:1 Green:3 Blue:5 andQRString:self.QRCodeString];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
            }else if (qrcArray.count>1){
                self.QrCodeImageView.alpha=0.f;
                self.singQRCodeBGImageView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=1.f;
                self.MQRCoreView.alpha=1.f;
                [self allQRCodeImageViewDataArray:qrcArray];
                
            }
            
        }
            break;
        case HowSignToBeSigned:
        {
             self.title=NSLocalizedString(@"待签名交易", nil);
             self.QrCodeType=@"2";
            [self.backFistButton setTitle:NSLocalizedString(@"返回首页", nil) forState:UIControlStateNormal];
            self.showInfoLabel.text=[NSString stringWithFormat:@"%@(%@%@%@%@)",NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil),NSLocalizedString(@"已签名：", nil),@"1",NSLocalizedString(@"待签名：", nil),@"2"];
            NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            if (qrcArray.count==1) {
                self.QrCodeImageView.image =[[FLTools share] imageWithSize:700.f andColorWithRed:1 Green:3 Blue:5 andQRString:self.QRCodeString];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
            }else if (qrcArray.count>1){
                self.QrCodeImageView.alpha=0.f;
                self.singQRCodeBGImageView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=1.f;
                self.MQRCoreView.alpha=1.f;
                [self allQRCodeImageViewDataArray:qrcArray];
                
            }
            break;
            
        }
        case HowSignSignedDeals:
        {
            
            self.title=NSLocalizedString(@"已签名交易", nil);
            self.QrCodeType=@"2";
            [self.backFistButton setTitle:NSLocalizedString(@"返回首页", nil) forState:UIControlStateNormal];
            self.showInfoLabel.text=[NSString stringWithFormat:@"%@(%@%@%@%@)",NSLocalizedString(@"请使用含有主私钥的钱包签名当前交易", nil),NSLocalizedString(@"已签名：", nil),@"1",NSLocalizedString(@"待签名：", nil),@"0"];
            NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            if (qrcArray.count==1) {
                self.QrCodeImageView.image =[[FLTools share] imageWithSize:700.f andColorWithRed:1 Green:3 Blue:5 andQRDic:self.QRCodeDic];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
            }else if (qrcArray.count>1){
                self.QrCodeImageView.alpha=0.f;
                self.singQRCodeBGImageView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=1.f;
                self.MQRCoreView.alpha=1.f;
                [self allQRCodeImageViewDataArray:qrcArray];
                
            }
            break;
            
        }
        case ExportReadOnlyWallet:
        {
            
            self.QrCodeType=@"1";
            self.title=NSLocalizedString(@"导出只读钱包", nil);
            self.backFistButton.alpha=0.f;
            self.showInfoLabel.text=NSLocalizedString(@"扫描二维码可创建单签只读钱包", nil);
            self.MQRCoreView.alpha=0.f;
            self.MBGQRCodeImageView.alpha=0.f;
           self.QrCodeImageView.image =[[FLTools share] imageWithSize:1100.f andColorWithRed:3 Green:3 Blue:5 andQRDic:self.QRCodeDic];
            break;
            
        }
        case LookhHowSignThePublicKey:
        {
            self.title=NSLocalizedString(@"多签公钥", nil);
            self.PublicAddressBGVIEW.alpha=1.f;
            self.showInfoLabelTopOffSet.constant=120;
            self.QrCodeType=@"2";
            self.PublicAddressLable.text=self.QRCodeString;
            [self.backFistButton setTitle:NSLocalizedString(@"复制多签公钥", nil) forState:UIControlStateNormal];
            self.showInfoLabel.text=NSLocalizedString(@"扫描二维码可创建多签钱包", nil);
            NSDictionary *QRDic =[[FLTools share]CreateQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWalletIdChain:@"ELA"];
        
            self.QrCodeImageView.image =[[FLTools share] imageWithSize:700.f andColorWithRed:1 Green:3 Blue:5 andQRDic:QRDic];
            self.MQRCoreView.alpha=0.f;
            self.MBGQRCodeImageView.alpha=0.f;
            break;
            
        }
        default:
            break;
    }
     self.navigationController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareInfo)];
  
  
}
-(HW3DBannerView *)QRCodeScrllV{
    if (!_QRCodeScrllV) {
        _QRCodeScrllV = [HW3DBannerView initWithFrame:CGRectMake(0, 0, 240, 200) imageSpacing:5 imageWidth:180];
        _QRCodeScrllV.autoScroll=NO;
        _QRCodeScrllV.clipsToBounds=YES;
        _QRCodeScrllV.showPageControl=NO;
        _QRCodeScrllV.imageHeightPoor = 10; //
        [self.MQRCoreView insertSubview:_QRCodeScrllV aboveSubview:self.MBGQRCodeImageView];
       __weak __typeof(self) weakSelf = self;
      CGPoint center=CGPointMake(AppWidth/2, self.MBGQRCodeImageView.center.y);
        _QRCodeScrllV.center=center;
        _QRCodeScrllV.scrollImageIndex = ^(NSInteger currentIndex) {
               __strong __typeof(weakSelf) self = weakSelf;
            NSString *imageNameString=[NSString stringWithFormat:@"page%lu_%lu",(unsigned long)self.allQRCodeImageArray.count,currentIndex+1];
            self.pageIconImageView.image=[UIImage imageNamed:imageNameString];
        };
    
    }

    return _QRCodeScrllV;
}
-(void)shareInfo{
    if (self.QrCodeImageView.alpha==1) {
        [self mq_share:[NSArray arrayWithObject:self.QrCodeImageView.image]];
        
    }else{
        if (self.allQRCodeImageArray.count>0) {
            [self mq_share:self.allQRCodeImageArray];
        }
    }
    
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
        case SingleSignReadOnlyToBeSigned:{
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.fromModel.iconName,self.substringAddress,self.addressTextField.text,[[FLTools share]elsToSela:self.enterTheAmountTextField.text],self.noteTextField.text,self.noteTextField.text] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@" publishtransaction"];
            result=[[ELWalletManager share] publishtransaction:mommand];
            
        }
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
-(void)setSubW:(NSString *)subW{
    _subW=subW;
}
-(void)setType:(QrCodeType)type{
    _type=type;
}
-(void)allQRCodeImageViewDataArray:(NSArray*)arr{
    
    for (__strong NSString  *QRString in arr) {
   UIImage *image =[[FLTools share] imageWithSize:350.f andColorWithRed:1 Green:3 Blue:5 andQRString:QRString];
        [self.allQRCodeImageArray addObject:image];
    }
    self.pageIconImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"page%lu_1",(unsigned long)self.allQRCodeImageArray.count]];
    self.QRCodeScrllV.data=self.allQRCodeImageArray;
    
}
-(NSMutableArray *)allQRCodeImageArray{
    if (!_allQRCodeImageArray) {
        _allQRCodeImageArray =[[NSMutableArray alloc]init];
    }
    return _allQRCodeImageArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

@end
