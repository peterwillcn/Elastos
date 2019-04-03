//
//  HMWsignUpForViewController.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWsignUpForViewController.h"
#import "FLJoinToChoseTransferInfoView.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWtransferViewController.h"
#import "FLVoteTicketTransferVC.h"
#import "ELWalletManager.h"
#import "HMWSelectCountriesOrRegionsViewController.h"
#import "HMWpwdPopupView.h"
@interface HMWsignUpForViewController ()<HMWSelectCountriesOrRegionsViewControllerDelegate,FLJoinToChoseTransferViewDelegate,HMWpwdPopupViewDelegate>
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


/*
 *<# #>
 */
@property(strong,nonatomic)FLJoinToChoseTransferInfoView *transferDetailsPopupV;

@property(strong,nonatomic)HMWpwdPopupView *pwdPopupV;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offY;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offHight;

@end

@implementation HMWsignUpForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@"tab_bg"];
//     self.pwdPopupV.userInteractionEnabled=NO;
    self.title=NSLocalizedString(@"报名参选", nil);
    self.theNameOfTheNodeTextField.placeholder =NSLocalizedString(@"请输入节点名称（必填）", nil);
    self.thePublicKeyTextField.placeholder    =NSLocalizedString(@"请输入节点公钥（必填）", nil);
    self.countriesTextField.placeholder       =NSLocalizedString(@"请选择国家/地区", nil);
    self.URLTextField.placeholder             =NSLocalizedString(@"请输入节点官网URL（必填)", nil);
    self.ipAddressTextField.placeholder       = NSLocalizedString(@"请输入网络地址（必填）", nil);
    
    // Do any additional setup after loading the view from its nib.
    [self.confirmToRunButton setTitle:NSLocalizedString(@"确认参选", nil) forState:UIControlStateNormal];
    
 [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.theNameOfTheNodeTextField];
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.thePublicKeyTextField];
 [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.countriesTextField];
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.URLTextField];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.ipAddressTextField];

 [[HMWCommView share]makeBordersWithView:self.confirmToRunButton];
    ELWalletManager *manager   =  [ELWalletManager share];
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
      NSString * nodePubKey = [NSString stringWithCString:mainchainSubWallet->GetPublicKeyForVote().c_str() encoding:NSUTF8StringEncoding];
    self.thePublicKeyTextField.text=nodePubKey;
    if (self.model.nickName.length!=0) {
        [self.confirmToRunButton setTitle:NSLocalizedString(@"更新信息", nil) forState:UIControlStateNormal];
        self.title = NSLocalizedString(@"更新信息", nil);
//        self.theNameOfTheNodeTextField.alpha=0.f;
        self.theNameOfTheNodeTextField.enabled=NO;
//        self.theNameOfTheNodeMakeView.alpha=0.f;
//        self.offY.constant=0.f;
//        self.offHight.constant=240;
        self.URLTextField.text=self.model.url;
        self.countriesTextField.text=[[FLTools share]contryNameTransLateByCode:self.model.contryCode.integerValue];
        self.theNameOfTheNodeTextField.text=self.model.nickName;
        
    }

}

-(FLJoinToChoseTransferInfoView *)transferDetailsPopupV{
    if (!_transferDetailsPopupV) {
        _transferDetailsPopupV =[FLJoinToChoseTransferInfoView defultView];
        _transferDetailsPopupV.delegate=self;
    }
    
    return _transferDetailsPopupV;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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

    [self.view addSubview:self.pwdPopupV];
    [self.pwdPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(HMWpwdPopupView *)pwdPopupV{
    if (!_pwdPopupV) {
        _pwdPopupV=[[HMWpwdPopupView alloc]init];
        _pwdPopupV.delegate=self;
    }
    return _pwdPopupV;
    
}

-(void)cancelThePWDPageView
{
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV = nil;
}
-(void)makeSureWithPWD:(NSString*)pwd{
    if (pwd.length==0) {
        return;
    }
    self.pwdPopupV.userInteractionEnabled=NO;
    if (self.model) {
        
        [self updataNodeInfo:pwd];
        
        
    }else{
        
    ELWalletManager *manager   =  [ELWalletManager share];
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    FLJoinVoteInfoModel* model = [[FLJoinVoteInfoModel alloc]init];
    
    model.pubKey     =  [NSString stringWithCString:mainchainSubWallet->GetPublicKeyForVote().c_str() encoding:NSUTF8StringEncoding] ;
    
    model.nodePubKey = self.thePublicKeyTextField.text;

    model.nickName   = self.theNameOfTheNodeTextField.text;
    model.url        = self.URLTextField.text;
    model.contryCode = self.mobCodeString;
    model.pwd        = pwd;
    model.ipAddress  = self.ipAddressTextField.text;
    model.mark       = @"";
    model.acount     = 5000;
    
 CGFloat free   =  [manager RegisterProducerWithMainchainSubWallet:mainchainSubWallet With:model];
    [self.pwdPopupV removeFromSuperview];
     self.pwdPopupV  = nil;
    if (free ==0 ) {
        return;
    }
    
    [self.view addSubview:self.transferDetailsPopupV];
    [self.transferDetailsPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
        if (self.delegate) {
            [self.delegate hasSignUp];
        }
    
    [self.transferDetailsPopupV transferDetailsWithTheAmountOf:@"5000" withFee: @(free/unitNumber).stringValue];
    }
    
     self.pwdPopupV.userInteractionEnabled=NO;
    

    
}
-(void)updataNodeInfo:(NSString*)pwd{
    
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    
    
    self.model.pubKey     =  [NSString stringWithCString:mainchainSubWallet->GetPublicKeyForVote().c_str() encoding:NSUTF8StringEncoding] ;
    self.model.nodePubKey = self.thePublicKeyTextField.text;
//    self.model.nodePubKey = [NSString stringWithCString:mainchainSubWallet->GetPublicKeyForVote().c_str() encoding:NSUTF8StringEncoding];
    self.model.nickName   = self.theNameOfTheNodeTextField.text;
    self.model.url        = self.URLTextField.text;
    self.model.contryCode = self.mobCodeString;
    self.model.pwd        = pwd;
    self.model.ipAddress  = self.ipAddressTextField.text;
    self.model.mark       = @"";
    self.model.acount     = 5000;
    
 BOOL ret = [manager UpdateProducerWithMainchainSubWallet:mainchainSubWallet With:self.model];
    
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV  = nil;
    if (ret) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"变更成功", nil)];
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
    
    [self.transferDetailsPopupV removeFromSuperview];
    self.transferDetailsPopupV=nil;
    [self.navigationController popViewControllerAnimated:YES];

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
 
    NSString *mainid = [ELWalletManager share].currentWallet.masterWalletID;
    IMainchainSubWallet *mainWallet = [[ELWalletManager share]getWalletELASubWallet:mainid];
    
    self.thePublicKeyTextField.text    = [NSString stringWithUTF8String: mainWallet->GetPublicKeyForVote().c_str()];
    
    self.countriesTextField.text       =[[FLTools share]contryNameTransLateByCode:model.contryCode.integerValue];
    self.mobCodeString = model.contryCode;
    self.URLTextField.placeholder           = model.url;
    self.ipAddressTextField.placeholder     =model.ipAddress;
    
   
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.view endEditing:YES];
}

@end
