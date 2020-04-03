//
//  HWMSingleSignReadOnlyWalletViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/10.
//

#import "HWMSingleSignReadOnlyWalletViewController.h"
#import "AppDelegate.h"
#import "FLPrepareVC.h"
#import "FLFLTabBarVC.h"
#import "ELWalletManager.h"
#import "FMDBWalletModel.h"
#import "HMWFMDBManager.h"

@interface HWMSingleSignReadOnlyWalletViewController ()
@property (weak, nonatomic) IBOutlet UITextField *walletNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *btn1;

@end

@implementation HWMSingleSignReadOnlyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"创建单签只读钱包", nil);
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.walletNameTextField withTxt:NSLocalizedString(@"请输入钱包名称", nil)];
    [self.btn1 setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.15] boldColor:[UIColor whiteColor] corner:0];
    [self.btn1 setTitle:NSLocalizedString(@"确认创建", nil) forState:UIControlStateNormal];
}

- (IBAction)ConfirmToCreate:(id)sender {
    if (![[FLTools share]checkWalletName:self.walletNameTextField.text]) {
        return;
    }
    
  NSString *walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    
    
    //
   NSString *masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:walletID];
    
    
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[masterWalletID,self.jsonString] callbackId:masterWalletID className:@"Wallet" methodName:@"CreateImportReadonlyWallet"];
    PluginResult *result= [[ELWalletManager share]CreateImportReadonlyWallet:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if([status isEqualToString:@"1"]){
        
        invokedUrlCommand *subCmommand=[[invokedUrlCommand alloc]initWithArguments:@[masterWalletID,@"ELA",@"10000"] callbackId:masterWalletID className:@"Wallet" methodName:@"createMasterWallet"];
        
        PluginResult *subResult= [[ELWalletManager share] createSubWallet:subCmommand];
        NSString *status =[NSString stringWithFormat:@"%@",subResult.status];
        
        if([status isEqualToString:@"1"]){
            
            FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
            model.walletID=masterWalletID;
            model.walletName=self.walletNameTextField.text;
            model.TypeW=SingleSignReadonly;
            [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
            sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
            sideModel.walletID=model.walletID;
            sideModel.sideChainName=@"ELA";
            
            sideModel.sideChainNameTime=@"--:--";
            sideModel.thePercentageCurr=@"0";
            sideModel.thePercentageMax=@"100";
            
            [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
            [self successfulSwitchingRootVC];
            
            
        }
      
        [self
         successfulSwitchingRootVC];
    }
    
    
}
-(void)successfulSwitchingRootVC{
    [[FLTools share]showErrorInfo:NSLocalizedString(@"创建成功", nil)];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appdelegate.window.rootViewController;
    if ([rootViewController.childViewControllers.firstObject isKindOfClass:[FLPrepareVC class]]) {
        FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
        appdelegate.window.rootViewController=tabVC;
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:updataCreateWallet object:nil ];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
-(void)setJsonString:(NSString *)jsonString{
    _jsonString = jsonString;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
