//
//  DrawBackVoteMoneyVC.m
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/2/15.
//

#import "DrawBackVoteMoneyVC.h"
#import "HMWSecurityVerificationPopView.h"
#import "ELWalletManager.h"
#import "assetDetailsModel.h"
#import "HWMTransactionDetailsView.h"
#import "HMWSendSuccessPopuView.h"

@interface DrawBackVoteMoneyVC ()<HMWSecurityVerificationPopViewDelegate,HWMTransactionDetailsViewDelegate>
@property(strong,nonatomic)HMWSecurityVerificationPopView *securityVerificationPopV;

@property (weak, nonatomic) IBOutlet UILabel *tagNodeNameLab;

@property (weak, nonatomic) IBOutlet UILabel *tagNote;

@property (weak, nonatomic) IBOutlet UIButton *drawBtn;

@property(nonatomic,strong) assetDetailsModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property(strong,nonatomic)HWMTransactionDetailsView *transactionDetailsView;
@property(copy,nonatomic)NSString *jsonString;
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@end

@implementation DrawBackVoteMoneyVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self defultWhite];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.title= NSLocalizedString(@"选举管理", nil);
    if (self.nodeName.length==0) {
        self.tagNodeNameLab.text =[NSString stringWithFormat:@"-- %@",NSLocalizedString(@"(已退出)", nil)];
    }else{
        self.tagNodeNameLab.text =[NSString stringWithFormat:@"%@ %@",self.nodeName,NSLocalizedString(@"(已退出)", nil)];
    }
    
    self.drawBtn.enabled = NO;
    if (self.CRTypeString.length==0) {
        [self DrawBackVoteMoney];
    }else{
        [self DrawBackRegistCRMoney];
    }
}
-(void)DrawBackVoteMoney{
    self.tagNote.text = NSLocalizedString(@"注销报名72小时后，方可提取质押金", nil);
    [self.drawBtn setTitle:NSLocalizedString(@"提取报名押金", nil) forState:UIControlStateNormal];
    
    
    ELWalletManager *manager;
    NSDictionary *param;
    try {
        manager = [ELWalletManager share];
        
        IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
        
        nlohmann::json info = mainchainSubWallet->GetRegisteredProducerInfo();
        NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
        
        param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
    } catch (const std:: exception &e) {
        
        NSString *errString=[self stringWithCStringCR:e.what()];
        [[FLTools share]dictionaryWithJsonString:errString];
        NSDictionary *dic=  [[FLTools share] dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        
    }
    NSDictionary *infoDic = param[@"Info"];
    NSString *URL = infoDic[@"URL"];
    if ([param[@"Info"][@"Confirms"] integerValue]>2160) {
        self.drawBtn.alpha=1.f;
        self.drawBtn.enabled=YES;
    }else{
        self.drawBtn.alpha=0.f;
        self.drawBtn.enabled=NO;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
}
-(void)DrawBackVoteMoneyWithPWD:(NSString*)pwdString{
    ELWalletManager *manager = [ELWalletManager share];
    NSString *walletId =  manager.currentWallet.masterWalletID;
    IMainchainSubWallet *wallet = [manager getWalletELASubWallet:walletId];
    NSString *ownerpublickey  =[NSString stringWithCString:wallet->GetOwnerPublicKey().c_str() encoding:NSUTF8StringEncoding];
    NSString *httpIP=[[FLTools share]http_IpFast];
    [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/getdepositcoin" header:@{} body:@{@"ownerpublickey":ownerpublickey} showHUD:YES WithSuccessBlock:^(id data) {
        CGFloat available = [data[@"data"][@"result"][@"available"] doubleValue];
        
        NSDictionary *dic=[manager RetrieveDepositFee:walletId acount:data[@"data"][@"result"][@"available"]  Pwd:pwdString];
        NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",dic[@"fee"]]];
        if ([dic[@"fee"] doubleValue]>-1) {
            self.jsonString=dic[@"JSON"];
            
            UIView *mainView =[self mainWindow];
            [mainView addSubview:self.transactionDetailsView];
            
            [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:data[@"data"][@"result"][@"available"]];
            
            
            [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.bottom.equalTo(mainView);
            }];
            
        }
        
        //           BOOL ret = [manager RetrieveDeposit:walletId acount:available  Pwd:pwdString];
        
        //           if (ret) {
        //               [self.navigationController popViewControllerAnimated:YES];
        //           }
        
        
    } WithFailBlock:^(id data) {
        
    }];
    
}

-(void)DrawBackRegistCRMoney{
    self.tagNote.text = NSLocalizedString(@"    退出参选72小时后，方可提取质押金",nil);
    [self.drawBtn setTitle:NSLocalizedString(@"提取质押金", nil) forState:UIControlStateNormal];
    ELWalletManager *manager;
    NSDictionary *param;
    try {
        manager = [ELWalletManager share];
        
        IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
        
        nlohmann::json info = mainchainSubWallet->GetRegisteredCRInfo();
        NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
        
        param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
    } catch (const std:: exception &e) {
        
        NSString *errString=[self stringWithCStringCR:e.what()];
        [[FLTools share]dictionaryWithJsonString:errString];
        NSDictionary *dic=  [[FLTools share] dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        
    }
    NSDictionary *infoDic = param[@"Info"];
    NSString *URL = infoDic[@"URL"];
    if ([param[@"Info"][@"Confirms"] integerValue]>2160) {
        self.drawBtn.alpha=1.f;
        self.drawBtn.enabled=YES;
    }else{
        self.drawBtn.alpha=0.f;
        self.drawBtn.enabled=NO;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
}
-(void)DrawBackRegistCRMoneyWithPWD:(NSString*)pwdString{
    ELWalletManager *manager = [ELWalletManager share];
    NSString *walletId =  manager.currentWallet.masterWalletID;
    invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[walletId,@"IDChain"] callbackId:manager.currentWallet.masterWalletID className:@"wallet" methodName:@"createMasterWallet"];
    NSDictionary * resultBase =[[ELWalletManager share]GetCRFirstPublicKeysAndDID:cmommand];
    //    self.MemberThePublicKeyLabel.text=resultBase[@"crPublicKey"];
    NSString *ownerpublickey=resultBase[@"cid"];
    NSString *httpIP=[[FLTools share]http_IpFast];
    [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/getcrdepositcoin" header:@{} body:@{@"did":ownerpublickey} showHUD:YES WithSuccessBlock:^(id data) {
        CGFloat available = [data[@"data"][@"result"][@"available"] doubleValue];
        NSDictionary *dic=[manager RetrieveCRDepositTransactionFee:walletId acount:data[@"data"][@"result"][@"available"] Pwd:@""];
        NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",dic[@"fee"]]];
        if ([dic[@"fee"] doubleValue]>-1) {
            self.jsonString=dic[@"JSON"];
            
            UIView *mainView =[self mainWindow];
            [mainView addSubview:self.transactionDetailsView];
            
            [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:data[@"data"][@"result"][@"available"]];
            
            
            [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.bottom.equalTo(mainView);
            }];
            
        }
        //        BOOL ret = [manager  RetrieveCRDepositTransaction:walletId acount:available  Pwd:pwdString];
        //        [self takeOutOrShutDown];
        //        if (ret) {
        //            [self.navigationController popViewControllerAnimated:YES];
        //        }
    } WithFailBlock:^(id data) {
        
    }];
}
- (IBAction)drawBackAction:(id)sender {
    if (self.CRTypeString.length==0) {
        [self DrawBackVoteMoneyWithPWD:@""];
    }else{
        [self DrawBackRegistCRMoneyWithPWD:@""];
    }
    
    
}
-(HMWSecurityVerificationPopView *)securityVerificationPopV{
    if (!_securityVerificationPopV) {
        _securityVerificationPopV =[[HMWSecurityVerificationPopView alloc]init];
        _securityVerificationPopV.backgroundColor=[UIColor clearColor];
        _securityVerificationPopV.delegate=self;
    }
    
    return _securityVerificationPopV;
}

-(void)takeOutOrShutDown{
    [self.securityVerificationPopV removeFromSuperview];
    self.securityVerificationPopV=nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (NSString *)stringWithCStringCR:(String)string
{
    
    NSString *str = [NSString stringWithCString:string.c_str() encoding:NSUTF8StringEncoding];
    return str;
}
-(void)setCRTypeString:(NSString *)CRTypeString{
    _CRTypeString=CRTypeString;
}
-(void)setNodeName:(NSString *)nodeName{
    
    _nodeName=nodeName;
}
-(HWMTransactionDetailsView *)transactionDetailsView{
    
    if (!_transactionDetailsView) {
        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];
        _transactionDetailsView.popViewTitle=NSLocalizedString(@"交易详情", nil);
        _transactionDetailsView.delegate=self;
        _transactionDetailsView.DetailsType=TransactionDetails;
    }
    return _transactionDetailsView;
}
#pragma mark ---------HWMTransactionDetailsView----------
-(void)closeTransactionDetailsView{
    [self.transactionDetailsView removeFromSuperview];
    self.transactionDetailsView=nil;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{
    ELWalletManager *manager = [ELWalletManager share];
    NSString *walletId =  manager.currentWallet.masterWalletID;
    IMainchainSubWallet *wallet = [manager getWalletELASubWallet:walletId];
    if (self.CRTypeString.length==0) {
        BOOL ret = [manager  RetrieveCRDepositTransaction:walletId acount:5000  Pwd:pwd withJSONString:self.jsonString];
        if (ret) {
            [self closeTransactionDetailsView];
            [self showSendSuccessPopuV];
        }
        
    }else{
        BOOL ret = [manager RetrieveDeposit:walletId acount:5000  Pwd:pwd withJSONString:self.jsonString];
        if (ret) {
            [self closeTransactionDetailsView];
            [self showSendSuccessPopuV];
        }
    }
    
    
}
-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenSendSuccessPopuV];
        [self.navigationController popViewControllerAnimated:YES];
    });
}
-(void)hiddenSendSuccessPopuV{
    [self.sendSuccessPopuV removeFromSuperview];
    self.sendSuccessPopuV=nil;
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    }
    
    return _sendSuccessPopuV;
}
-(void)setNodeModel:(FLCoinPointInfoModel *)nodeModel{
    _nodeModel =nodeModel;
}
-(void)setCRModel:(HWMCRListModel *)CRModel{
    _CRModel=CRModel;
    
}
@end
