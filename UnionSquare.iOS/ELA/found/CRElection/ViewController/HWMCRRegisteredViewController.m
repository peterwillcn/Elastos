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


@interface HWMCRRegisteredViewController ()<HMWSecurityVerificationPopViewDelegate,FLJoinToChoseTransferViewDelegate,HMWSelectCountriesOrRegionsViewControllerDelegate>
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
@property(strong,nonatomic)HMWSecurityVerificationPopView *securityVerificationPopV;
@property(strong,nonatomic)FLJoinToChoseTransferInfoView *transferDetailsPopupV;
/*
 *
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *mobCodeString;

@end

@implementation HWMCRRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
  self.title=NSLocalizedString(@"报名参选", nil);
    self.MemberThePublicKeyTextLabel.text=NSLocalizedString(@"委员公钥", nil);
   self.MembersDIDTextLabel.text=NSLocalizedString(@"委员DID", nil);
    self.CountryORRegionTextField.placeholder       =NSLocalizedString(@"请选择国家/地区", nil);
    self.URLTextField.placeholder       = NSLocalizedString(@"请输入委员官网URL", nil);
    self.MemberNameTextField.placeholder       = NSLocalizedString(@"请输入委员名称（必填）", nil);
  
    // Do any additional setup after loading the view from its nib.
    [self.confirmToRunButton setTitle:NSLocalizedString(@"确认参选", nil) forState:UIControlStateNormal];
    
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.MemberNameTextField];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.CountryORRegionTextField];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.URLTextField];

 
    
    [[HMWCommView share]makeBordersWithView:self.confirmToRunButton];
//    ELWalletManager *manager   =  [ELWalletManager share];
//    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
//    NSString * ownerPubKey = [NSString stringWithCString:mainchainSubWallet->GetOwnerPublicKey().c_str() encoding:NSUTF8StringEncoding];
//    self.thePublicKeyTextField.text=ownerPubKey;
//    if (self.model.nickName.length!=0) {
//        [self.confirmToRunButton setTitle:NSLocalizedString(@"更新信息", nil) forState:UIControlStateNormal];
//        self.title = NSLocalizedString(@"更新信息", nil);
//        //        self.theNameOfTheNodeTextField.alpha=0.f;
//        self.theNameOfTheNodeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
//        self.theNameOfTheNodeTextField.enabled=NO;
//        self.thePublicKeyTextField.text=self.model.ownerPublickKey;
//        self.URLTextField.text=self.model.url;
//        self.countriesTextField.text=[[FLTools share]contryNameTransLateByCode:self.model.contryCode.integerValue];
//        self.theNameOfTheNodeTextField.text=self.model.nickName;
//
//    }
    
}
-(HMWSecurityVerificationPopView *)securityVerificationPopV{
    if (!_securityVerificationPopV) {
        _securityVerificationPopV =[[HMWSecurityVerificationPopView alloc]init];
        _securityVerificationPopV.backgroundColor=[UIColor clearColor];
        _securityVerificationPopV.delegate=self;
    }
    
    return _securityVerificationPopV;
}

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
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入委员官网URL", nil)];
        
        return;
    }
    
    [self.view addSubview:self.securityVerificationPopV ];
    [self.securityVerificationPopV  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    //
    //    FLVoteTicketTransferVC *transferVC=[[FLVoteTicketTransferVC alloc]init];
    //    transferVC.infoModel = model;
    //    [self.navigationController pushViewController:transferVC animated:YES];
    
    //    UIView *manView=[self mainWindow];
    //    [manView addSubview:self.transferDetailsPopupV];
    //    [self.transferDetailsPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.top.bottom.equalTo(manView);
    //    }];
    
    
    
}

-(void)takeOutOrShutDown{
    [self.securityVerificationPopV removeFromSuperview];
    self.securityVerificationPopV =nil;
}

-(void)makeSureWithPWD:(NSString*)pwd{
    if (pwd.length==0) {
        return;
    }
    self.securityVerificationPopV.userInteractionEnabled=NO;
//    if (self.model) {
//
//        [self updataNodeInfo:pwd];
//
//
//    }else{
    
//        ELWalletManager *manager   =  [ELWalletManager share];
//        IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
//        FLJoinVoteInfoModel* model = [[FLJoinVoteInfoModel alloc]init];
//
//        model.pubKey     =  [NSString stringWithCString:mainchainSubWallet->GetOwnerPublicKey().c_str() encoding:NSUTF8StringEncoding] ;
//
//        model.ownerPublickKey = self.thePublicKeyTextField.text;
//        model.nodePubKey=self.thePublicKeyTextField.text;
//        model.nickName   = self.theNameOfTheNodeTextField.text;
//        model.url        = self.URLTextField.text;
//        model.contryCode = self.mobCodeString;
//        model.pwd        = pwd;
//        model.ipAddress  = self.ipAddressTextField.text;
//        model.mark       = @"";
//        model.acount     = 5000;
//
    CGFloat free;
//    =  [manager RegisterProducerWithMainchainSubWallet:mainchainSubWallet With:model];
        [self takeOutOrShutDown];
        //    if (free ==0 ) {
        //        return;
        //    }
        
        
        [self.view addSubview:self.transferDetailsPopupV];
        [self.transferDetailsPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
//        if (self.delegate) {
//            [self.delegate hasSignUp];
//        }
    
        [self.transferDetailsPopupV transferDetailsWithTheAmountOf:@"5000" withFee: @(free/unitNumber).stringValue];
//    }
    
    
    
    
}
-(void)updataNodeInfo:(NSString*)pwd{
    
//    ELWalletManager *manager   =  [ELWalletManager share];
//
//    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
//
//
//    self.model.pubKey     =  [NSString stringWithCString:mainchainSubWallet->GetOwnerPublicKey().c_str() encoding:NSUTF8StringEncoding] ;
//    self.model.nodePubKey = self.thePublicKeyTextField.text;
//    self.model.ownerPublickKey=self.thePublicKeyTextField.text;
//    self.model.nickName   = self.theNameOfTheNodeTextField.text;
//    self.model.url        = self.URLTextField.text;
//    self.model.contryCode = self.mobCodeString;
//    self.model.pwd        = pwd;
//    self.model.ipAddress  = self.ipAddressTextField.text;
//    self.model.mark       = @"";
//    self.model.acount     = 5000;
//
//    BOOL ret = [manager UpdateProducerWithMainchainSubWallet:mainchainSubWallet With:self.model];
    
    [self takeOutOrShutDown];
//    if (ret) {
//        [[FLTools share]showErrorInfo:NSLocalizedString(@"变更成功", nil)];
//    }else{
//        [[FLTools share]showErrorInfo:NSLocalizedString(@"交易失败", nil)];
//    }
    
    
    
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

@end
