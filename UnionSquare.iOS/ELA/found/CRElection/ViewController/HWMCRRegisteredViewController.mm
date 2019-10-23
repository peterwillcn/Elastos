//
//  HWMCRRegisteredViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/8/27.
//

#import "HWMCRRegisteredViewController.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWSecurityVerificationPopView.h"
#import "FLJoinToChoseTransferInfoView.h"
#import "HMWSelectCountriesOrRegionsViewController.h"
#import "ELWalletManager.h"
#import "HWMTransactionDetailsView.h"

@interface HWMCRRegisteredViewController ()<FLJoinToChoseTransferViewDelegate,HMWSelectCountriesOrRegionsViewControllerDelegate,HWMTransactionDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *MemberThePublicKeyTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *MemberThePublicKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *MembersDIDTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *MembersDIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *MemberNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *CountryORRegionTextField;
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;

@property (weak, nonatomic) IBOutlet UIButton *confirmToRunButton;
/*
 *<# #>
 */
//@property(strong,nonatomic)HMWSecurityVerificationPopView *securityVerificationPopV;
@property(strong,nonatomic)FLJoinToChoseTransferInfoView *transferDetailsPopupV;
/*
 *
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *mobCodeString;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMTransactionDetailsView *transactionDetailsView;
@end

@implementation HWMCRRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
  self.title=NSLocalizedString(@"报名参选", nil);
    self.MemberThePublicKeyTextLabel.text=NSLocalizedString(@"委员公钥", nil);
   self.MembersDIDTextLabel.text=NSLocalizedString(@"委员DID", nil);
    // Do any additional setup after loading the view from its nib.
    [self.confirmToRunButton setTitle:NSLocalizedString(@"确认参选", nil) forState:UIControlStateNormal];
    
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.MemberNameTextField withTxt:NSLocalizedString(@"请输入委员名称（必填）", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.CountryORRegionTextField withTxt:NSLocalizedString(@"请选择国家/地区", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.URLTextField withTxt:NSLocalizedString(@"请输入竞选网址", nil)];

 
    
    [[HMWCommView share]makeBordersWithView:self.confirmToRunButton];
    ELWalletManager *manager   =  [ELWalletManager share];
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    NSString * CROwnerPublicKey = [NSString stringWithCString:mainchainSubWallet->GetCROwnerPublicKey().c_str() encoding:NSUTF8StringEncoding];
    
    NSString *CROwnerDID = [NSString stringWithCString:mainchainSubWallet->GetCROwnerDID().c_str() encoding:NSUTF8StringEncoding];
    self.MemberThePublicKeyLabel.text=CROwnerPublicKey;
    self.MembersDIDLabel.text=CROwnerDID;
    
    if (self.isUpdate) {
        [self.confirmToRunButton setTitle:NSLocalizedString(@"更新信息", nil) forState:UIControlStateNormal];
        self.title = NSLocalizedString(@"更新信息", nil);
        self.MemberNameTextField.text=self.CRmodel.nickname;
        self.CountryORRegionTextField.text=[[FLTools share]contryNameTransLateByCode:[self.CRmodel.location intValue]];
        self.URLTextField.text=self.CRmodel.url;
        
    }
        //        self.theNameOfTheNodeTextField.alpha=0.f;
//        self.theNameOfTheNodeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
//        self.theNameOfTheNodeTextField.enabled=NO;
//        self.thePublicKeyTextField.text=self.model.ownerPublickKey;
//        self.URLTextField.text=self.model.url;
//        self.countriesTextField.text=[[FLTools share]contryNameTransLateByCode:self.model.contryCode.integerValue];
//        self.theNameOfTheNodeTextField.text=self.model.nickName;
//
//    }
    
}
//-(HMWSecurityVerificationPopView *)securityVerificationPopV{
//    if (!_securityVerificationPopV) {
//        _securityVerificationPopV =[[HMWSecurityVerificationPopView alloc]init];
//        _securityVerificationPopV.backgroundColor=[UIColor clearColor];
//        _securityVerificationPopV.delegate=self;
//    }
//
//    return _securityVerificationPopV;
//}

-(FLJoinToChoseTransferInfoView *)transferDetailsPopupV{
    if (!_transferDetailsPopupV) {
        _transferDetailsPopupV =[FLJoinToChoseTransferInfoView defultView];
        _transferDetailsPopupV.delegate=self;
    }
    
    return _transferDetailsPopupV;
}
- (IBAction)chooseTheCountryEvent:(id)sender {
    HMWSelectCountriesOrRegionsViewController *vc=[[HMWSelectCountriesOrRegionsViewController alloc]init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)confirmToRunEvent:(id)sender {
    if (self.MemberNameTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入委员名称（必填）", nil)];
        return;
    }
    if (self.CountryORRegionTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请选择国家/地区", nil)];
        
        return;
    }
    if (self.URLTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入竞选网址", nil)];
        
        return;
    }
   
    
//    [self.view addSubview:self.securityVerificationPopV ];
//    [self.securityVerificationPopV  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.view);
//    }];
    
    //
    //    FLVoteTicketTransferVC *transferVC=[[FLVoteTicketTransferVC alloc]init];
    //    transferVC.infoModel = model;
    //    [self.navigationController pushViewController:transferVC animated:YES];
    
    //    UIView *manView=[self mainWindow];
    //    [manView addSubview:self.transferDetailsPopupV];
    //    [self.transferDetailsPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.top.bottom.equalTo(manView);
    //    }];
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,@"ELA",@"",@"",@"5000",@"",@"",@"1"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
    PluginResult * result =[[ELWalletManager share]accessFees:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if (![status isEqualToString:@"1"]) {
        return;
    }
    NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",result.message[@"success"]]];
    
    
    
    UIView *mainView =[self mainWindow];
    [mainView addSubview:self.transactionDetailsView];
    [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:@"5000"];
    [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(mainView);
    }];
}
-(void)updataNodeInfo:(NSString*)pwd{
            [self closeTransactionDetailsView];
        ELWalletManager *manager   =  [ELWalletManager share];
           IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
           FLJoinVoteInfoModel* model = [[FLJoinVoteInfoModel alloc]init];

           model.CRDIDKey    =  self.MembersDIDLabel.text ;
   //
           model.CRownerPublickKey = self.MemberThePublicKeyLabel.text;

           model.nickName   = self.MemberNameTextField.text;
           model.url        = self.URLTextField.text;
           model.contryCode = self.mobCodeString;
           model.pwd        = pwd;
           model.ipAddress  = self.URLTextField.text;
           model.mark       = @"";
           model.acount     = 5000;
  BOOL ret = [manager UpdateCRProducerWithMainchainSubWallet:mainchainSubWallet With:model];
      if (ret) {
          [[FLTools share]showErrorInfo:NSLocalizedString(@"变更成功", nil)];
           [self showSendSuccessPopuV];
      }else{
          [[FLTools share]showErrorInfo:NSLocalizedString(@"交易失败", nil)];
      }
    
    
}

#pragma mark ---------HMWtransferDetailsPopupViewDelegate----------

-(void)cancelShow
{
    [self.transferDetailsPopupV removeFromSuperview];
    self.transferDetailsPopupV=nil;
}
-(void)nextBtnAction{
    [self pwdAndInfo];
    
    
    
}



-(void)pwdAndInfo{
    
    [self.transferDetailsPopupV removeFromSuperview];
    self.transferDetailsPopupV=nil;
    [self showSendSuccessPopuV];
    
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV=nil;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

-(void)selectTheCountryAreasModel:(NSDictionary *)modelDic{
    
    self.mobCodeString = modelDic[@"mobileCode"];
    
    
    self.CountryORRegionTextField.text = NSLocalizedString(modelDic[@"countries"], nil);
    
    
    
}
//-(void)setModel:(FLJoinVoteInfoModel *)model
//{
//    _model= model;
//    self.theNameOfTheNodeTextField.text = model.nickName;
//    self.theNameOfTheNodeTextField.enabled = NO;
//
//    //    NSString *mainid = [ELWalletManager share].currentWallet.masterWalletID;
//    //    IMainchainSubWallet *mainWallet = [[ELWalletManager share]getWalletELASubWallet:mainid];
//
//    self.thePublicKeyTextField.text    =model.ownerPublickKey;
//
//    self.countriesTextField.text       =[[FLTools share]contryNameTransLateByCode:model.contryCode.integerValue];
//    self.mobCodeString = model.contryCode;
//    self.URLTextField.placeholder           = model.url;
//    self.ipAddressTextField.placeholder     =model.ipAddress;
//
//
//
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.view endEditing:YES];
}
-(HWMTransactionDetailsView *)transactionDetailsView{
    
    if (!_transactionDetailsView) {
        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];
        _transactionDetailsView.popViewTitle=@"参选押金";
        _transactionDetailsView.delegate=self;
    }
    return _transactionDetailsView;
}
#pragma mark ---------HWMTransactionDetailsView----------
-(void)closeTransactionDetailsView{
    [self.transactionDetailsView removeFromSuperview];
    self.transactionDetailsView=nil;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{
    
    if (self.isUpdate) {
        [self updataNodeInfo:pwd];
        return;
       }
    
    ELWalletManager *manager   =  [ELWalletManager share];
               IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
               FLJoinVoteInfoModel* model = [[FLJoinVoteInfoModel alloc]init];

               model.CRDIDKey    =  self.MembersDIDLabel.text ;
       //
               model.CRownerPublickKey = self.MemberThePublicKeyLabel.text;

               model.nickName   = self.MemberNameTextField.text;
               model.url        = self.URLTextField.text;
               model.contryCode = self.mobCodeString;
               model.pwd        = pwd;
               model.ipAddress  = self.URLTextField.text;
               model.mark       = @"";
               model.acount     = 5000;
        CGFloat free;
        free = [manager         RegisterCRWithMainchainSubWallet:mainchainSubWallet With:model];
        [self closeTransactionDetailsView];
        [self showSendSuccessPopuV];
    
    
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
    
}
-(void)setCRmodel:(HWMCRListModel *)CRmodel{
    _CRmodel=CRmodel;
    
}
@end
