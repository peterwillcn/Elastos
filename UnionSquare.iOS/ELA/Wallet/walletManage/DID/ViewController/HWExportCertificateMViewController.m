//
//  HWExportCertificateMViewController.m
//  elastos wallet
//
//  Created by  on 2020/3/24.
//

#import "HWExportCertificateMViewController.h"
#import "HWMDIDManager.h"
#import "HMWSendSuccessPopuView.h"

@interface HWExportCertificateMViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dirNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@property(assign,nonatomic)BOOL needDe;
@end

@implementation HWExportCertificateMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"导出凭证", nil);
    [self.saveButton setTitle:NSLocalizedString(@"保存至本地", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.saveButton];
    [[HMWCommView share]makeBordersWithView:self.shareButton];
    [self.shareButton setTitle:NSLocalizedString(@"分享", nil) forState:UIControlStateNormal];

    self.dirNameLabel.text=[NSString stringWithFormat:@"%@_%@_%@.jwt",[self.currentWallet.didString substringFromIndex:self.currentWallet.didString.length-6],[[FLTools share]getNowTimeTimestampS],self.model.didName];
}
- (IBAction)saveEvent:(id)sender {
    BOOL isSuccess= [[HWMDIDManager shareDIDManager]GenerateLocalCredentialsWithFielNameWithFielName: self.dirNameLabel.text];
    if (isSuccess) {
        [self showSendSuccessViewWithType:1];
    }else{
        [[FLTools share]showErrorInfo:NSLocalizedString(@"保存失败", nil)];
        
    }
    
}
- (IBAction)shareEvent:(id)sender {


    NSArray *items=[[HWMDIDManager shareDIDManager]shareJWTWithmastWalletID:self.currentWallet.masterWalletID   withFileName:self.dirNameLabel.text needDlea:^(BOOL de) {
        self.needDe=de;
    }];
    [self mq_share:items];
    
}
-(void)mq_share:(NSArray *)items{
    if (items.count == 0) {
        return;
    }
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    activityVC.excludedActivityTypes = [self excludetypes];
    
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
        if (self.needDe) {
            //NSLog(@"需要删除");
        }
        
        
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

-(void)showSendSuccessViewWithType:(NSInteger)type{
    self.sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    switch (type) {
        case 0:
        {
            self.sendSuccessPopuV.type=sendDealType;
            break;
            
        }
        case 1:{
            self.sendSuccessPopuV.type=saveSuccessType;
            break;
        }
            
        default:
            break;
    }
    
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV=nil;
//        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

@end
