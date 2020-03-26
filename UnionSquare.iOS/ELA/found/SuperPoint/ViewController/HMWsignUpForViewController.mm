//
//  HMWsignUpForViewController.m
//  ELA
//
//  Created by  on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWsignUpForViewController.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWtransferViewController.h"
#import "FLVoteTicketTransferVC.h"
#import "ELWalletManager.h"
#import "HMWSelectCountriesOrRegionsViewController.h"
#import "HWMTransactionDetailsView.h"
#import "HMWFMDBManager.h"
#import "FMDBWalletModel.h"
#import "HMWtheSuperNodeElectionViewController.h"

@interface HMWsignUpForViewController ()<HMWSelectCountriesOrRegionsViewControllerDelegate,HWMTransactionDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *theNameOfTheNodeMakeView;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@property (weak, nonatomic) IBOutlet UITextField *theNameOfTheNodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *thePublicKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *ipAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *countriesTextField;
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmToRunButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseTheCountryBuuton;

@property(nonatomic,assign)NSString *mobCodeString;
@property(strong,nonatomic)HWMTransactionDetailsView *transactionDetailsView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offY;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offHight;

@end

@implementation HMWsignUpForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"报名参选", nil);
    if (self.currentWallet==nil) {
                NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
                   FMDBWalletModel *model =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
        self.currentWallet=[[FLWallet alloc]init];
            self.currentWallet.masterWalletID =model.walletID;
            self.currentWallet.walletName     =model.walletName;
            self.currentWallet.walletAddress  = model.walletAddress;
            self.currentWallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
            self.currentWallet.TypeW  = model.TypeW;
        self.currentWallet.didString=model.didString;
         
    }
    
    // Do any additional setup after loading the view from its nib.
    [self.confirmToRunButton setTitle:NSLocalizedString(@"确认参选", nil) forState:UIControlStateNormal];
    
 [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.theNameOfTheNodeTextField withTxt:NSLocalizedString(@"请输入节点名称（必填）", nil)];
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.thePublicKeyTextField withTxt:NSLocalizedString(@"请输入节点公钥（必填）", nil)];
 [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.countriesTextField withTxt:NSLocalizedString(@"请选择国家/地区", nil)];
    
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.URLTextField withTxt:NSLocalizedString(@"请输入节点官网URL（必填)", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.ipAddressTextField withTxt:NSLocalizedString(@"请输入网络地址（必填）", nil)];

 [[HMWCommView share]makeBordersWithView:self.confirmToRunButton];
    ELWalletManager *manager   =  [ELWalletManager share];
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
      NSString * ownerPubKey = [NSString stringWithCString:mainchainSubWallet->GetOwnerPublicKey().c_str() encoding:NSUTF8StringEncoding];
    self.thePublicKeyTextField.text=ownerPubKey;
    if (self.model.nickName.length!=0) {
        [self.confirmToRunButton setTitle:NSLocalizedString(@"更新信息", nil) forState:UIControlStateNormal];
        self.title = NSLocalizedString(@"更新信息", nil);
//        self.theNameOfTheNodeTextField.alpha=0.f;
  self.theNameOfTheNodeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.theNameOfTheNodeTextField.enabled=NO;
        self.thePublicKeyTextField.text=self.model.ownerPublickKey;
        self.URLTextField.text=self.model.url;
        self.countriesTextField.text=[[FLTools share]contryNameTransLateByCode:self.model.contryCode.integerValue];
        self.theNameOfTheNodeTextField.text=self.model.nickName;
        
    }

}
- (IBAction)chooseTheCountryEvent:(id)sender {
    HMWSelectCountriesOrRegionsViewController *vc=[[HMWSelectCountriesOrRegionsViewController alloc]init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)confirmToRunEvent:(id)sender {
    if (self.theNameOfTheNodeTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入节点名称（必填）", nil)];
        return;
    }
    
    if (self.thePublicKeyTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入节点公钥", nil)];
        return;
    }
    
//    if (self.ipAddressTextField.text.length==0) {
//        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入网络地址（必填）", nil)];
//        return;
//    }
    if (self.countriesTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请选择国家/地区", nil)];

        return;
    }
    if (self.URLTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入节点官网URL（必填)", nil)];

        return;
    }
    NSString *numberString;
    if (self.model) {
        numberString=@"0";
    }else{
         numberString=@"5000";
    }
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,@"ELA",@"",@"",[[FLTools share] elsToSela:numberString],@"",@"",@"1"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
    PluginResult * result =[[ELWalletManager share]accessFees:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if (![status isEqualToString:@"1"]) {
        return;
    }
    NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",result.message[@"success"]]];

    UIView *mainView =[self mainWindow];
     [mainView addSubview:self.transactionDetailsView];
    if (self.model) {
        self.transactionDetailsView.popViewTitle=NSLocalizedString(@"交易详情", nil);
         [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:@""];
       
    }else{
         [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:numberString];
    }

    
    
    [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(mainView);
    }];
}
-(void)updataNodeInfo:(NSString*)pwd{
    
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    
    
    self.model.pubKey     =  [NSString stringWithCString:mainchainSubWallet->GetOwnerPublicKey().c_str() encoding:NSUTF8StringEncoding] ;
    self.model.nodePubKey = self.thePublicKeyTextField.text;
    self.model.ownerPublickKey=self.thePublicKeyTextField.text;
    self.model.nickName   = self.theNameOfTheNodeTextField.text;
    self.model.url        = self.URLTextField.text;
    self.model.contryCode = self.mobCodeString;
    self.model.pwd        = pwd;
    self.model.ipAddress  = self.ipAddressTextField.text;
    self.model.mark       = @"";
    self.model.acount     = 5000;
    
 BOOL ret = [manager UpdateProducerWithMainchainSubWallet:mainchainSubWallet With:self.model];
    if (ret) {
        [self closeTransactionDetailsView];
        [self showSendSuccessPopuV];
//        [[FLTools share]showErrorInfo:NSLocalizedString(@"变更成功", nil)];
    }
//    else{
//        [[FLTools share]showErrorInfo:NSLocalizedString(@"交易失败", nil)];
//    }
    
    
    
}

#pragma mark ---------HMWtransferDetailsPopupViewDelegate----------


-(void)nextBtnAction{
//    [self pwdAndInfo];
    


}



//-(void)pwdAndInfo{
//
//    [self showSendSuccessPopuV];
//
//}
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
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV=nil;
            HMWtheSuperNodeElectionViewController *homeVC = [[HMWtheSuperNodeElectionViewController alloc] init];
                               UIViewController *target = nil;
                               for (UIViewController * controller in self.navigationController.viewControllers) {
                                   if ([controller isKindOfClass:[homeVC class]]) {
                                       target = controller;
                                   }
                               }
                               if (target) {
                                   [self.navigationController popToViewController:target animated:YES];
                               }
                       
    });
    
}

-(void)selectTheCountryAreasModel:(NSDictionary *)modelDic{
    
    self.mobCodeString = modelDic[@"mobileCode"];
  
    
    self.countriesTextField.text = NSLocalizedString(modelDic[@"countries"], nil);

    
    
}
-(void)setModel:(FLJoinVoteInfoModel *)model
{
    _model= model;
 self.theNameOfTheNodeTextField.text = model.nickName;
    self.theNameOfTheNodeTextField.enabled = NO;
 
//    NSString *mainid = [ELWalletManager share].currentWallet.masterWalletID;
//    IMainchainSubWallet *mainWallet = [[ELWalletManager share]getWalletELASubWallet:mainid];
    
    self.thePublicKeyTextField.text    =model.ownerPublickKey;
    
    self.countriesTextField.text       =[[FLTools share]contryNameTransLateByCode:model.contryCode.integerValue];
    self.mobCodeString = model.contryCode;
    self.URLTextField.text        = model.url;
    
    self.ipAddressTextField.text  =model.ipAddress;
    
   
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.view endEditing:YES];
}
-(HWMTransactionDetailsView *)transactionDetailsView{
    
    if (!_transactionDetailsView) {
        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];
        _transactionDetailsView.popViewTitle=NSLocalizedString(@"参选押金", nil);
        _transactionDetailsView.delegate=self;
    }
    return _transactionDetailsView;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{

    if (pwd.length==0) {
            return;
        }
        if (self.model) {
            
            [self updataNodeInfo:pwd];
//            [self closeTransactionDetailsView];
            
        }else{
            
        ELWalletManager *manager   =  [ELWalletManager share];
        IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
        FLJoinVoteInfoModel* model = [[FLJoinVoteInfoModel alloc]init];
        
        model.pubKey     =  [NSString stringWithCString:mainchainSubWallet->GetOwnerPublicKey().c_str() encoding:NSUTF8StringEncoding] ;
        
        model.ownerPublickKey = self.thePublicKeyTextField.text;
    model.nodePubKey=self.thePublicKeyTextField.text;
        model.nickName   = self.theNameOfTheNodeTextField.text;
        model.url        = self.URLTextField.text;
        model.contryCode = self.mobCodeString;
        model.pwd        = pwd;
        model.ipAddress  = self.ipAddressTextField.text;
        model.mark       = @"";
        model.acount     = 5000;
       
     CGFloat free   =  [manager RegisterProducerWithMainchainSubWallet:mainchainSubWallet With:model];
          
            if (free>-1) {
                 [self closeTransactionDetailsView];
                [self showSendSuccessPopuV];
                if (self.delegate) {
                    [self.delegate hasSignUp];
          }
            }
        
        }

        
}
-(void)closeTransactionDetailsView{
    [self.transactionDetailsView removeFromSuperview];
    self.transactionDetailsView=nil;
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
}

@end
