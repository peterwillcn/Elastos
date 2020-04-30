//
//  HWMHowLongTradingQrCodeViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/18.
//

#import "HWMHowLongTradingQrCodeViewController.h"
#import "FirstViewController.h"

@interface HWMHowLongTradingQrCodeViewController ()
    @property (weak, nonatomic) IBOutlet UIButton *backFistButton;
    @property (weak, nonatomic) IBOutlet UILabel *IdentificationCodeLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *codeBGImageView;
    @property (weak, nonatomic) IBOutlet UILabel *showInfoLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *pageImageView;
    
    @property (weak, nonatomic) IBOutlet UILabel *instructionsTextLabel;
    @end

@implementation HWMHowLongTradingQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.navigationController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareInfo)];
    [[HMWCommView share]makeBordersWithView:self.backFistButton];
    switch (self.QrCodeTyp) {
        case ToBeSignedDealsQrCodeType:
        self.title=NSLocalizedString(@"待签名交易", nil);
             self.showInfoLabel.text=[NSString stringWithFormat:@"%@(%@%@%@%@)",NSLocalizedString(@"请使用含有私钥的钱包签名当前交易", nil),NSLocalizedString(@"已签名：", nil),@"1",NSLocalizedString(@"待签名：", nil),@"0"];
        self.instructionsTextLabel.text=NSLocalizedString(@"请连续扫描所有二维码", nil);
        [self.backFistButton setTitle:NSLocalizedString(@"返回首页", nil) forState:UIControlStateNormal];
        break;
        case SignedDealsQrCodeType:
        self.title=NSLocalizedString(@"已签名交易", nil);
        self.showInfoLabel.text=[NSString stringWithFormat:@"%@(%@%@%@%@)",NSLocalizedString(@"请使用含有私钥的钱包签名当前交易", nil),NSLocalizedString(@"已签名：", nil),@"1",NSLocalizedString(@"待签名：", nil),@"0"];
        self.instructionsTextLabel.text=NSLocalizedString(@"请连续扫描所有二维码", nil);
        [self.backFistButton setTitle:NSLocalizedString(@"以完成签名，立即广播", nil) forState:UIControlStateNormal];
        break;
        default:
        break;
    }

}
- (IBAction)backFistAction:(id)sender {
    switch (self.QrCodeTyp) {
        case ToBeSignedDealsQrCodeType:
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[FirstViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }

        break;
        case SignedDealsQrCodeType:
        
        break;
        default:
        break;
    }
    
}
    
-(void)shareInfo{
//        [self mq_share:[NSArray arrayWithObject:self.QrCodeImageView.image]];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
