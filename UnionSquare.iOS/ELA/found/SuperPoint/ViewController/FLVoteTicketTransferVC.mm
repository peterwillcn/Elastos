//
//  FLVoteTicketTransferVC.m
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/1/26.
//

#import "FLVoteTicketTransferVC.h"
#import "HMWtransferDetailsPopupView.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWChooseSideChainViewController.h"
#import "ELWalletManager.h"
#import "HMWpwdPopupView.h"
@interface FLVoteTicketTransferVC ()<HMWtransferDetailsPopupViewDelegate,HMWpwdPopupViewDelegate,HMWChooseSideChainViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *transferTheAddressTextField;
@property (weak, nonatomic) IBOutlet UIButton *theContactButton;
@property (weak, nonatomic) IBOutlet UITextField *theAmountOfTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *theNextStepButton;
@property (weak, nonatomic) IBOutlet UIButton *maxButton;

/*
 *<# #>
 */
@property(strong,nonatomic)HMWtransferDetailsPopupView *transferDetailsPopupV;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;

@property(nonatomic,assign)NSInteger walletBalance;
@property(strong,nonatomic)HMWpwdPopupView *pwdPopupV;

@end

@implementation FLVoteTicketTransferVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"转账", nil);
    [self.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.transferTheAddressTextField withTxt:NSLocalizedString(@"请输入收款人地址", nil)];
    
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.theAmountOfTextField withTxt:[NSString stringWithFormat:@"%@%@ ELA)",NSLocalizedString(@"请输入金额 可用", nil),[[FLTools share]elaScaleConversionWith:[@(self.walletBalance) stringValue]]]];
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField withTxt:NSLocalizedString(@"请输入备注", nil)];
    [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
    [[HMWCommView share]makeBordersWithView:self.maxButton];
    
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    String balanceSt = mainchainSubWallet->GetBalance();
    NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
    NSInteger balance=[balanceString integerValue];
   self.walletBalance =balance;
  
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self defultWhite];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(voteTicketResult:) name:TransactionStatusChanged object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:TransactionStatusChanged object:nil];
}
-(void)voteTicketResult:(NSNotification*)notice
{
 
//    NSDictionary *dic=@{@"txid":[NSString stringWithUTF8String:txid.c_str()],
//                        @"status":[NSString stringWithUTF8String:status.c_str()],
//                        @"desc":[NSString stringWithUTF8String:desc.dump().c_str()],
//                        };
    NSDictionary *param = notice.object;
    NSString *state = param[@"status"];
   
    [self.sendSuccessPopuV removeFromSuperview];
    if ([state isEqualToString:@"Updated"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (IBAction)pasteEvent:(id)sender {
    
    
    self.transferTheAddressTextField.text=[[FLTools share]pastingTextFromTheClipboard];
}
- (IBAction)theContactEvent:(id)sender {
    self.theContactButton.userInteractionEnabled=NO;
    HMWChooseSideChainViewController *chooseSideChainVC=[[HMWChooseSideChainViewController alloc]init];
    chooseSideChainVC.type=chooseFriendsType;
//    chooseSideChainVC.supportOfTheCurrencyArray=self.supportOfTheCurrencyArray;
    chooseSideChainVC.delegate=self;
    [self.navigationController pushViewController:chooseSideChainVC animated:YES]; self.theContactButton.userInteractionEnabled=YES;
}
- (IBAction)maxAmountEvent:(id)sender {
    self.theAmountOfTextField.text=[[FLTools share]elaScaleConversionWith:@(self.walletBalance).stringValue];
}
- (IBAction)theNextStepEvent:(id)sender {
    
    if (self.transferTheAddressTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入收款人地址", nil)];
        return;
    }
    if ([self.theAmountOfTextField.text doubleValue]==0 ) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"金额需要大于0", nil)];
        return;
    }
    if ([self.theAmountOfTextField.text doubleValue]>[[[FLTools share]elaScaleConversionWith:@(self.walletBalance).stringValue] doubleValue]) {
        
        [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
        return;
    }
//
//    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,self.addressArray.firstObject,self.transferTheAddressTextField.text,self.theAmountOfTextField.text,self.noteTextField.text,@"22"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
//
//    NSString *fee=[[FLTools share]elaScaleConversionWith:[[ELWalletManager share]accessFees:mommand]];
//
//    [self.transferDetailsPopupV transferDetailsWithToAddress:self.transferTheAddressTextField.text withTheAmountOf:[NSString stringWithFormat:@"%@%@",  self.theAmountOfTextField.text,self.model.iconName] withFee:[NSString stringWithFormat:@"%@%@",  fee,self.model.iconName]];
    
    self.theNextStepButton.userInteractionEnabled=NO;
    
    
    
    [self.view addSubview:self.pwdPopupV];
    [self.pwdPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    self.theNextStepButton.userInteractionEnabled=YES;
}
-(HMWtransferDetailsPopupView *)transferDetailsPopupV{
    if (!_transferDetailsPopupV) {
        _transferDetailsPopupV =[[HMWtransferDetailsPopupView alloc]init];
        _transferDetailsPopupV.delegate=self;
    }
    
    return _transferDetailsPopupV;
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    }
    
    return _sendSuccessPopuV;
}
-(HMWpwdPopupView *)pwdPopupV{
    if (!_pwdPopupV) {
        _pwdPopupV=[[HMWpwdPopupView alloc]init];
        _pwdPopupV.delegate=self;
    }
    return _pwdPopupV;
}
-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    
}
-(void)hiddenSendSuccessPopuV{
    [self.sendSuccessPopuV removeFromSuperview];
    self.sendSuccessPopuV=nil;
    
    
}
#pragma mark ---------HMWtransferDetailsPopupViewDelegate----------

-(void)closeThePage{
    
    [self.transferDetailsPopupV removeFromSuperview];
    self.transferDetailsPopupV=nil;
}
-(void)pwdAndInfoWithPWD:(NSString *)pwd{
//    [self.transferDetailsPopupV removeFromSuperview];
//    self.transferDetailsPopupV=nil;
//    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,self.addressArray.firstObject,self.transferTheAddressTextField.text,self.theAmountOfTextField.text,self.noteTextField.text,@"22",pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
//
//    PluginResult *result = [[ELWalletManager share]CreateTransaction:mommand];
//    NSString *statue=[NSString stringWithFormat:@"%@",result.status];
//
//    if ([statue isEqualToString:@"1"]) {
//        [self showSendSuccessPopuV];
//    }

    
}
-(void)makeSureWithPWD:(NSString*)pwd{
    if (pwd.length==0) {
        return;
    }
    self.infoModel.pwd = pwd;
    self.infoModel.acount = self.theAmountOfTextField.text.integerValue;
    self.infoModel.mark = self.noteTextField.text;
    
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
   NSInteger fee= [[ELWalletManager share]RegisterProducerWithMainchainSubWallet:mainchainSubWallet With:self.infoModel];
    if (fee>-1) {
    [self showSendSuccessPopuV];
    }
  
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)choosedFriedsMode:(friendsModel*)model{
    self.transferTheAddressTextField.text=model.address;
}
@end
