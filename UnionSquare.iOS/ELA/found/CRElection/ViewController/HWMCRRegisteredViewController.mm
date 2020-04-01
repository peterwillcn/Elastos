//
//  HWMCRRegisteredViewController.m
//  elastos wallet
//
//  Created by  on 2019/8/27.
//

#import "HWMCRRegisteredViewController.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWSecurityVerificationPopView.h"
#import "FLJoinToChoseTransferInfoView.h"
#import "HMWSelectCountriesOrRegionsViewController.h"
#import "ELWalletManager.h"
#import "HWMTransactionDetailsView.h"
#import "HWMCRListModel.h"
#import "HMWCRCommitteeMemberListViewController.h"
@interface HWMCRRegisteredViewController ()<FLJoinToChoseTransferViewDelegate,HMWSelectCountriesOrRegionsViewControllerDelegate,HWMTransactionDetailsViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *MemberThePublicKeyTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *MemberThePublicKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *MembersDIDTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *MembersDIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *MemberNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *CountryORRegionTextField;
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGViewHeight;

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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *offSuperTop;
@property (weak, nonatomic) IBOutlet UIView *makeLine1;
@property (weak, nonatomic) IBOutlet UIView *makeLine2;
@end

@implementation HWMCRRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
  self.title=NSLocalizedString(@"报名参选", nil);
    self.MemberThePublicKeyTextLabel.text=NSLocalizedString(@"参选公钥", nil);
   self.MembersDIDTextLabel.text=NSLocalizedString(@"参选DID", nil);
    // Do any additional setup after loading the view from its nib.
    [self.confirmToRunButton setTitle:NSLocalizedString(@"确认参选", nil) forState:UIControlStateNormal];
    
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.MemberNameTextField withTxt:NSLocalizedString(@"请输入参选昵称（必填）", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.CountryORRegionTextField withTxt:NSLocalizedString(@"请选择国家/地区", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.URLTextField withTxt:NSLocalizedString(@"请输入竞选网址", nil)];
    self.MemberNameTextField.delegate=self;
    self.URLTextField.delegate=self;
 
    
    [[HMWCommView share]makeBordersWithView:self.confirmToRunButton];
        ELWalletManager *manager   =  [ELWalletManager share];
    invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[manager.currentWallet.masterWalletID,@"IDChain"] callbackId:manager.currentWallet.masterWalletID className:@"wallet" methodName:@"createMasterWallet"];
             NSDictionary * resultBase =[[ELWalletManager share]GetCRFirstPublicKeysAndDID:cmommand];
    self.MemberThePublicKeyLabel.text=resultBase[@"crPublicKey"];
    self.MembersDIDLabel.text=resultBase[@"did"];
    
    if (self.isUpdate) {
        [self.confirmToRunButton setTitle:NSLocalizedString(@"更新信息", nil) forState:UIControlStateNormal];
        self.title = NSLocalizedString(@"更新信息", nil);
        self.MemberNameTextField.text=self.CRmodel.nickname;
        self.CountryORRegionTextField.text=[[FLTools share]contryNameTransLateByCode:[self.CRmodel.location intValue]];
        self.URLTextField.text=self.CRmodel.url;
        self.MemberNameTextField.userInteractionEnabled=NO;
        self.MemberNameTextField.enabled=NO;
        self.offSuperTop.constant=0.f;
        self.MemberThePublicKeyLabel.alpha=0.f;
        self.MemberThePublicKeyTextLabel.alpha=0.f;
        self.MembersDIDLabel.alpha=0.f;
        self.MembersDIDTextLabel.alpha=0.f;
        self.makeLine1.alpha=0.f;
        self.makeLine2.alpha=0.f;
        self.BGViewHeight.constant=190;
        self.mobCodeString=self.CRmodel.location;
        
    }
    
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
        [[FLTools share]showErrorInfo:NSLocalizedString(@"委员昵称不能为空", nil)];
        return;
    }
    
    for (HWMCRListModel *mode in self.lastArray) {
        if ([self.MemberNameTextField.text isEqualToString:mode.nickname]) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"委员昵称已存在", nil)];
            return;
        }
    }
    for (HWMCRListModel *model in self.lastArray) {
        if ([model.nickname isEqualToString:self.MemberNameTextField.text]) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"委员昵称已存在", nil)];
            return;
        }
    }
    NSString *aumount;
    if (self.isUpdate) {
        aumount=@"0";
    }else{
         aumount=@"5000";
    }
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,@"ELA",@"",@"",[[FLTools share] elsToSela:aumount],@"",@"",@"1"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
    PluginResult * result =[[ELWalletManager share]accessFees:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if (![status isEqualToString:@"1"]) {
        return;
    }
    NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",result.message[@"success"]]];
    UIView *mainView =[self mainWindow];
    if (self.isUpdate) {
        self.transactionDetailsView.popViewTitle=NSLocalizedString(@"交易详情", nil);
          [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:@""];
    }else{
       [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:aumount];
    }
       
    [mainView addSubview:self.transactionDetailsView];
  
    [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(mainView);
    }];
}
-(void)updataNodeInfo:(NSString*)pwd{
        ELWalletManager *manager   =  [ELWalletManager share];
           IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
           FLJoinVoteInfoModel* model = [[FLJoinVoteInfoModel alloc]init];
           model.CRDIDKey    =  self.MembersDIDLabel.text ;
           model.CRownerPublickKey = self.MemberThePublicKeyLabel.text;
           model.nickName   = self.MemberNameTextField.text;
           model.url        = self.URLTextField.text;
           model.contryCode = self.mobCodeString;
           model.pwd        = pwd;
           model.ipAddress  = self.URLTextField.text;
           model.mark       = @"";
            NSArray *didStringArray=[self.currentWallet.didString componentsSeparatedByString:@":"];
            model.DIDString=didStringArray.lastObject;
           model.acount     = 5000;
        BOOL ret = [manager UpdateCRProducerWithMainchainSubWallet:manager.currentWallet.masterWalletID With:model];
      if (ret) {
           [self closeTransactionDetailsView];
           [self showSendSuccessPopuV];
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
           HMWCRCommitteeMemberListViewController *homeVC = [[HMWCRCommitteeMemberListViewController alloc] init];
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
        _transactionDetailsView.popViewTitle=NSLocalizedString(@"参选押金", nil);
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
               model.CRownerPublickKey = self.MemberThePublicKeyLabel.text;
               model.nickName   = self.MemberNameTextField.text;
               model.url        = self.URLTextField.text;
               model.contryCode = self.mobCodeString;
               model.pwd        = pwd;
               model.ipAddress  = self.URLTextField.text;
               model.mark       = @"";
               model.acount     = 5000;
               NSArray *didStringArray=[self.currentWallet.didString componentsSeparatedByString:@":"];
               model.DIDString=didStringArray.lastObject;
        CGFloat free;
        free = [manager RegisterCRWithMainchainSubWallet:manager.currentWallet.masterWalletID With:model];
    if (free>-1) {
      [self showSendSuccessPopuV];
        [self closeTransactionDetailsView];
    }
    
    
    
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
    
}
-(void)setCRmodel:(HWMCRListModel *)CRmodel{
    _CRmodel=CRmodel;
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger number=[string charactorNumber];
    if (textField==self.self.MemberNameTextField) {
         NSLog(@"MemberNameTextField===%ld-----%lu",(long)number,(unsigned long)textField.text.length);
        if (number>100) {
           
            return NO;
        }
    }
    if (textField==self.URLTextField) {
  NSLog(@"URLTextField===%ld-----%lu",(long)number,(unsigned long)textField.text.length);
        if (number>100) {
            
                  return NO;
              }
    }
    return YES;
}
-(void)setLastArray:(NSArray *)lastArray{
    _lastArray=lastArray;
    
}

@end
