//
//  HWMSignatureTradingSingleQrCodeViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/16.
//

#import "HWMSignatureTradingSingleQrCodeViewController.h"
#import "SGQRCodeGenerateManager.h"
#import "FirstViewController.h"
#import "HW3DBannerView.h"
#import "ELWalletManager.h"
#import "HMWSendSuccessPopuView.h"


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
@property (weak, nonatomic) IBOutlet UIView *QRBGView;
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
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;

@end

@implementation HWMSignatureTradingSingleQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    [[HMWCommView share]makeBordersWithView:self.backFistButton];
 
    self.IdentificationCodeLabel.text=[NSString stringWithFormat:@"%@【%@】",NSLocalizedString(@"识别码", nil),self.QRCodeSignatureDic[@"ID"]];
    switch (self.type) {
        case SingleSignReadOnlyToBeSigned:{
            self.QrCodeType=@"3";
            self.title=NSLocalizedString(@"待签名交易", nil);
            self.backFistButton.alpha=0.f;
            if (self.SignStatus.isSignCom) {
               [self.backFistButton setTitle:NSLocalizedString(@"已完成签名，立即广播", nil) forState:UIControlStateNormal]; self.title=NSLocalizedString(@"已签名交易", nil);
                  self.backFistButton.alpha=1.f;
            }
            self.IdentificationCodeLabel.alpha=0.f;
            self.showInfoLabel.text=NSLocalizedString(@"请使用含有私钥的钱包签名当前交易", nil);
//               NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            NSDictionary *qrDic=[[FLTools share] CreateQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWalletIdChain:self.subW];
            NSString *qrString=[[FLTools share] returnJSONStringWithDictionary:qrDic];
            
//            if (qrcArray.count==1) {
                 self.QrCodeImageView.image =[[FLTools share] imageWithSize:1100.f andColorWithRed:3 Green:3 Blue:5 andQRString:qrString];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
            self.QRBGView.alpha=1.f;
                
//            }else if (qrcArray.count>1){
//                self.QrCodeImageView.alpha=0.f;
//                self.singQRCodeBGImageView.alpha=0.f;
//                self.MBGQRCodeImageView.alpha=1.f;
//                self.MQRCoreView.alpha=1.f;
//                [self allQRCodeImageViewDataArray:qrcArray];
//
//            }
            
            break;
            
        }
        case SingleSignReadOnlySignedDeals:{
          self.QrCodeType=@"3";
            self.title=NSLocalizedString(@"待签名交易", nil); self.showInfoLabel.text=NSLocalizedString(@"请使用含有私钥的钱包签名当前交易", nil);
            NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            if (qrcArray.count==1) {
                
                self.QrCodeImageView.image =[[FLTools share] imageWithSize:1100.f andColorWithRed:1 Green:3 Blue:5 andQRString:self.QRCodeString];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
                self.QRBGView.alpha=1.f;
            }else if (qrcArray.count>1){
                self.QrCodeImageView.alpha=0.f;
                self.singQRCodeBGImageView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=1.f;
                self.MQRCoreView.alpha=1.f;
                self.QRBGView.alpha=0.f;
                [self allQRCodeImageViewDataArray:qrcArray];
                
            }
            
        }
            break;
        case HowSignToBeSigned:
        {
                self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareInfo)];
             self.title=NSLocalizedString(@"待签名交易", nil);
             [self GetTransactionSignedInfo];
             self.QrCodeType=@"3";
            [self.backFistButton setTitle:NSLocalizedString(@"返回首页", nil) forState:UIControlStateNormal];
            NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            if (qrcArray.count==1) {
                self.QrCodeImageView.image =[[FLTools share] imageWithSize:700.f andColorWithRed:1 Green:3 Blue:5 andQRString:self.QRCodeString];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
                self.QRBGView.alpha=1.f;
            }else if (qrcArray.count>1){
                self.IdentificationCodeTextLabel.alpha=1.f;
                self.QrCodeImageView.alpha=0.f;
                self.singQRCodeBGImageView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=1.f;
                self.MQRCoreView.alpha=1.f;
                self.QRBGView.alpha=0.f;
                [self allQRCodeImageViewDataArray:qrcArray];
                
            }
            break;
            
        }
        case HowSignSignedDeals:
        {
                self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareInfo)];
             [self GetTransactionSignedInfo];
            self.title=NSLocalizedString(@"待签名交易", nil);
            self.QrCodeType=@"3";
            
            [self.backFistButton setTitle:NSLocalizedString(@"返回首页", nil) forState:UIControlStateNormal];
            NSArray *qrcArray=[[FLTools share]CreateArrayQrCodeImage:self.QRCodeString WithType:self.QrCodeType withSubWall:self.subW];
            if (qrcArray.count==1) {
                self.QrCodeImageView.image =[[FLTools share] imageWithSize:700.f andColorWithRed:1 Green:3 Blue:5 andQRDic:self.QRCodeSignatureDic];
                self.MQRCoreView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=0.f;
                self.QRBGView.alpha=1.f;
            }else if (qrcArray.count>1){
                self.IdentificationCodeTextLabel.alpha=1.f;
                self.QrCodeImageView.alpha=0.f;
                self.singQRCodeBGImageView.alpha=0.f;
                self.MBGQRCodeImageView.alpha=1.f;
                self.MQRCoreView.alpha=1.f;
                self.QRBGView.alpha=0.f;
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
            self.QRBGView.alpha=1.f;
            self.QrCodeImageView.image =[[FLTools share] imageWithSize:1100.f andColorWithRed:3 Green:3 Blue:5 andQRDic:self.QRCodeSignatureDic];
            break;
            
        }
        case LookhHowSignThePublicKey:
        {
                self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareInfo)];
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
            self.QRBGView.alpha=0.f;
            break;
            
        }
        default:
            break;
    }
    
self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareInfo)];
    self.IdentificationCodeTextLabel.text=[NSString stringWithFormat:@"%@ %@%@%lu %@",NSLocalizedString(@"第", nil),@"1",@"/",(unsigned long)self.allQRCodeImageArray.count,NSLocalizedString(@"张", nil)];
   
    if (self.SignStatus.isSignCom) {
                self.title=NSLocalizedString(@"已签名交易", nil);
        self.backFistButton.alpha=1;
         [self.backFistButton setTitle:NSLocalizedString(@"已完成签名，立即广播", nil) forState:UIControlStateNormal];
    }
}
-(HW3DBannerView *)QRCodeScrllV{
    if (!_QRCodeScrllV) {
        _QRCodeScrllV = [HW3DBannerView initWithFrame:CGRectMake(0, 0, 260, 260) imageSpacing:0 imageWidth:260];
        _QRCodeScrllV.autoScroll=NO;
        _QRCodeScrllV.clipsToBounds=YES;
        _QRCodeScrllV.showPageControl=NO;
        _QRCodeScrllV.imageHeightPoor = 0; //
        [self.MQRCoreView insertSubview:_QRCodeScrllV aboveSubview:self.MBGQRCodeImageView];
       __weak __typeof(self) weakSelf = self;
      CGPoint center=CGPointMake(AppWidth/2, self.MBGQRCodeImageView.center.y);
        _QRCodeScrllV.center=center;
        _QRCodeScrllV.scrollImageIndex = ^(NSInteger currentIndex) {
               __strong __typeof(weakSelf) self = weakSelf;
   
            self.IdentificationCodeTextLabel.text=[NSString stringWithFormat:@"%@ %ld%@%lu %@",NSLocalizedString(@"第", nil),currentIndex+1,@"/",(unsigned long)self.allQRCodeImageArray.count,NSLocalizedString(@"张", nil)];
        };
    
    }

    return _QRCodeScrllV;
}
-(void)shareInfo{
//    [self mq_share:[NSArray arrayWithObjects:[self getNormalImage:self.view], nil]];
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
    if (self.SignStatus.isSignCom) {
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.subW,self.QRCodeString] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"publishtransaction"];
        PluginResult *result = [[ELWalletManager share]publishtransaction:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]){
            [self showSendSuccessPopuV];
        }
        return;
    }
    
    switch (self.type) {
        case SingleSignReadOnlyToBeSigned:
        {
//            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.fromModel.iconName,self.substringAddress,self.addressTextField.text,[[FLTools share]elsToSela:self.enterTheAmountTextField.text],self.noteTextField.text,self.noteTextField.text] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@" publishtransaction"];
//            result=[[ELWalletManager share] publishtransaction:mommand];
       
            
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
        if (@available(iOS 11.0, *)) {
            [excludeTypesM addObject:UIActivityTypeMarkupAsPDF];
        } else {
            // Fallback on earlier versions
        }
    }
    
    return excludeTypesM;
}
-(void)setQRCodeString:(NSString *)QRCodeString{
    _QRCodeString=QRCodeString;
    
}
-(void)setQRCodeSignatureDic:(NSDictionary *)QRCodeSignatureDic{
    _QRCodeSignatureDic=QRCodeSignatureDic;
    
}
-(void)setSubW:(NSString *)subW{
    _subW=subW;
}
-(void)setType:(QrCodeType)type{
    _type=type;
}
-(void)allQRCodeImageViewDataArray:(NSArray*)arr{
    
    for (__strong NSString *QRDic in arr) {
   UIImage *image =[[FLTools share] imageWithSize:1200.f andColorWithRed:3 Green:3 Blue:5 andQRString:QRDic];
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
- (UIImage *)getNormalImage:(UIView *)view {
    
    CGSize s = view.bounds.size;
  //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，设置为[UIScreen mainScreen].scale可以保证转成的图片不失真。
    UIGraphicsBeginImageContextWithOptions(s, NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)GetTransactionSignedInfo{
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.subW, self.QRCodeString] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"GetTransactionSignedInfo"];
    PluginResult * result =[[ELWalletManager share]GetTransactionSignedInfo:mommand];
    if ([result.status  isEqual:@1]) {
        HWMSignStatusModel *SignStatusModel=[[HWMSignStatusModel alloc]init];
        SignStatusModel.Signers=0;
        NSArray *SignArry=[NSArray arrayWithArray:result.message[@"success"]];
        for (NSDictionary *dic in SignArry) {
           SignStatusModel.N=dic[@"N"];
          SignStatusModel.M=dic[@"M"];
            NSObject *obj=dic[@"Signers"];
            if ([obj isKindOfClass:[NSArray class]]) {
               SignStatusModel.Signers=[NSArray arrayWithArray:dic[@"Signers"]].count;
            }
            if ([dic[@"SignType"] isEqualToString:@"MultiSign"]) {
               SignStatusModel.isHowSign=YES;
                if ([SignStatusModel.M integerValue]>SignStatusModel.Signers) {
                    SignStatusModel.isSignCom=NO;
                    NSObject *obj=dic[@"Signers"];
                    
                    if ([obj isKindOfClass:[NSArray class]]) {
                        SignStatusModel.Signers=[NSArray arrayWithArray:dic[@"Signers"]].count;
                    }
                }else{
                   SignStatusModel.isSignCom=YES;
                }
                //
            }else{
                SignStatusModel.isHowSign=NO;
                SignStatusModel.M=@"1";
            }
            
        }
        NSInteger n=[SignStatusModel.M integerValue]-SignStatusModel.Signers;
        self.showInfoLabel.text=[NSString stringWithFormat:@"%@(%@%lu，%@%lu)",NSLocalizedString(@"请使用含有私钥的钱包签名当前交易", nil),NSLocalizedString(@"已签名：", nil), (unsigned long)SignStatusModel.Signers,NSLocalizedString(@"待签名：", nil), n];
           if (n<0||n==0) {
            self.title=NSLocalizedString(@"已签名交易", nil);
           }
        }
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
    
}
-(void)setSignStatus:(HWMSignStatusModel *)SignStatus{
    _SignStatus=SignStatus;
    
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    }
    
    return _sendSuccessPopuV;
}
-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenSendSuccessPopuV];
    });
}
-(void)hiddenSendSuccessPopuV{
    [self.sendSuccessPopuV removeFromSuperview];
    self.sendSuccessPopuV=nil;
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FirstViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
@end
