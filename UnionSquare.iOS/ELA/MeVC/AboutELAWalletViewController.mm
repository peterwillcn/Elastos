//
//  AboutELAWalletViewController.m
//  elastos wallet
//
//  Created by  on 2019/6/21.
//

#import "AboutELAWalletViewController.h"
#import "HWMVUpdateLogWebViewController.h"
#import "ELWalletManager.h"

@interface AboutELAWalletViewController ()< UIDocumentInteractionControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *appTheVersionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *appInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeTheLogButton;
@property (weak, nonatomic) IBOutlet UILabel *sdkTheVersionNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *TheProblemOfFeedbackButton;
@property (weak, nonatomic) IBOutlet UIButton *RunLogButton;
@end

@implementation AboutELAWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    NSString *appTheVersionNumberString=NSLocalizedString(@"当前版本号", nil);
    self.appTheVersionNumberLabel.text=[NSString stringWithFormat:@"%@ %@",appTheVersionNumberString, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.appInfoLabel.text=NSLocalizedString(@"ELA Wallet是安全、可信的SPV轻节点钱包，支持DPoS选举及亦来云全生态数字资产。", nil);
    [self makeBordersWithView:self.seeTheLogButton];
    [self.seeTheLogButton setTitle:NSLocalizedString(@"查看更新日志", nil) forState:UIControlStateNormal];
    [self.TheProblemOfFeedbackButton setTitle:NSLocalizedString(@"反馈邮件", nil) forState:UIControlStateNormal];
    [self.RunLogButton setTitle:NSLocalizedString(@"运行日志", nil) forState:UIControlStateNormal];
    
    self.sdkTheVersionNumberLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"当前sdk版本号", nil),[[ELWalletManager share] EMWMGetVersion]];
    
}
- (IBAction)seeTheLogAction:(id)sender {
    
    HWMVUpdateLogWebViewController *HWMVUpdateLogWebVC=[[HWMVUpdateLogWebViewController alloc]init];
//   HWMVUpdateLogWebVC.title=NSLocalizedString(@"更新日志", nil);
    [self.navigationController pushViewController:HWMVUpdateLogWebVC animated:YES];
}
- (IBAction)TheProblemOfFeedbackAction:(id)sender {
    [UIPasteboard generalPasteboard].string = @"wallet@elastos.org";
    [[FLTools share]showErrorInfo:NSLocalizedString(@"客服邮箱已复制到粘贴板", nil)];
}
- (IBAction)RunLogAction:(id)sender {
   NSString * fileName =@"spvsdk.log";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * testDirectory = [[MyUtil getRootPath] stringByAppendingPathComponent:fileName];
    BOOL res = [fileManager fileExistsAtPath:testDirectory];
    if (res) {
        NSData *data =[NSData dataWithContentsOfFile:testDirectory];
       NSURL *URL =[NSURL fileURLWithPath:testDirectory];
        NSArray *ARR=[NSArray arrayWithObjects:data,@"log",URL,nil];
        [self mq_share:ARR];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO];
    
}

@end
