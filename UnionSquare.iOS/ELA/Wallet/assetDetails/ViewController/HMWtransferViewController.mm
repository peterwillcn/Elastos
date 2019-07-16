//
//  HMWtransferViewController.m
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtransferViewController.h"
#import "HMWtransferDetailsPopupView.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWChooseSideChainViewController.h"
#import "ELWalletManager.h"
#import "WCQRCodeScanningVC.h"
#import "ScanQRCodeViewController.h"
#import "HWMSignatureTradingSingleQrCodeViewController.h"


@interface HMWtransferViewController ()<HMWtransferDetailsPopupViewDelegate,HMWChooseSideChainViewControllerDelegate,UITextFieldDelegate>
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

@property (weak, nonatomic) IBOutlet UILabel *isVoteBlanceTextLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isAddSwitch;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *fee;
@end

@implementation HMWtransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"转账", nil);
    self.isVoteBlanceTextLabel.text=NSLocalizedString(@"是否使用投票utxo", nil);
    
    self.isAddSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
    self.isAddSwitch.layer.borderWidth=2.f;
    self.isAddSwitch.layer.cornerRadius=15.f; self.isAddSwitch.layer.masksToBounds=YES;
    self.isAddSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
//    [self loadCanUserBlanceLoadDataSource];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"setting_adding_scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(scanView)];
       self.theAmountOfTextField.placeholder=[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"请输入金额 可用", nil),[[FLTools share]elaScaleConversionWith:self.model.iconBlance],@"ELA"];
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.transferTheAddressTextField];
    
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.theAmountOfTextField];
   [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField];
    [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
    [[HMWCommView share]makeBordersWithView:self.maxButton];
    [self.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
   
    self.noteTextField.placeholder=NSLocalizedString(@"请输入备注", nil);
    self.theAmountOfTextField.delegate=self;
    
    self.transferTheAddressTextField.placeholder=NSLocalizedString(@"请输入收款人地址", nil);
    
}
//- (IBAction)isAddOrCloseEvent:(id)sender {
//   
//}
-(void)loadCanUserBlanceLoadDataSource{
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@0] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getBalance"];
    PluginResult * result =[[ELWalletManager share]getBalance:mommand];
    
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]){
        
        
        
        NSString *blanceString=[NSString stringWithFormat:@"%@",result.message[@"success"]];
        
        self.theAmountOfTextField.placeholder=[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"请输入金额 可用", nil),[[FLTools share]elaScaleConversionWith:blanceString],@"ELA"];
        self.model.iconBlance=blanceString;

    }
    
}
-(void)scanView{
            __weak __typeof__(self) weakSelf = self;
    ScanQRCodeViewController *scanQRCodeVC = [[ScanQRCodeViewController alloc]init];
   scanQRCodeVC.scanBack = ^(NSString *addr) {
        
        weakSelf.transferTheAddressTextField.text=addr;
        
    };
    [self QRCodeScanVC:scanQRCodeVC];
}
- (IBAction)pasteEvent:(id)sender {
    
    
    self.transferTheAddressTextField.text=[[FLTools share]pastingTextFromTheClipboard];
}
- (IBAction)theContactEvent:(id)sender {
    self.theContactButton.userInteractionEnabled=NO;
    HMWChooseSideChainViewController *chooseSideChainVC=[[HMWChooseSideChainViewController alloc]init];
    chooseSideChainVC.type=chooseFriendsType;
    chooseSideChainVC.supportOfTheCurrencyArray=self.supportOfTheCurrencyArray;
    chooseSideChainVC.delegate=self;
    [self.navigationController pushViewController:chooseSideChainVC animated:YES]; self.theContactButton.userInteractionEnabled=YES;
}
- (IBAction)maxAmountEvent:(id)sender {
    self.theAmountOfTextField.text=[[FLTools share]elaScaleConversionWith:self.model.iconBlance];
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
    if ([self.theAmountOfTextField.text doubleValue]>[[[FLTools share]elaScaleConversionWith:self.model.iconBlance] doubleValue]) {
        
       [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
        return;
    }
    NSString *isUtxo=@"1";
//    if (self.isAddSwitch.isOn) {
//        isUtxo=@"1";
//    }
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"",self.transferTheAddressTextField.text,[[FLTools share]elsToSela:self.theAmountOfTextField.text],self.noteTextField.text,self.noteTextField.text,isUtxo] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
    PluginResult * result =[[ELWalletManager share]accessFees:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if (![status isEqualToString:@"1"]) {
        return;
    }
    NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",result.message[@"success"]]];
    self.fee=fee;
    if ([self.theAmountOfTextField.text doubleValue]+[self.fee doubleValue]>[[[FLTools share]elaScaleConversionWith:self.model.iconBlance] doubleValue]) {
        
        [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
        return;
    }
    [self.transferDetailsPopupV transferDetailsWithToAddress:self.transferTheAddressTextField.text withTheAmountOf:[NSString stringWithFormat:@"%@ %@",  self.theAmountOfTextField.text,@"ELA"] withFee:[NSString stringWithFormat:@"%@%@",fee,@"ELA"]];
    
    UIView *manView=[self mainWindow];
    
    [manView addSubview:self.transferDetailsPopupV];
    [self.transferDetailsPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.bottom.equalTo(manView);
    }];
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
-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV =nil;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
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
    [self.transferDetailsPopupV removeFromSuperview];
    self.transferDetailsPopupV=nil;
//    SingleSign=0,
//    SingleSignReadonly=1,
//    HowSign=2,
//    HowSignReadonly=3
    if (self.currentWallet.TypeW==0) {
        NSString *isUtxo=@"1";
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"",self.transferTheAddressTextField.text,[[FLTools share]elsToSela:self.theAmountOfTextField.text],self.noteTextField.text,self.noteTextField.text,pwd,isUtxo] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
        PluginResult *result = [[ELWalletManager share]CreateTransaction:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
            [self showSendSuccessPopuV];
        }
    }else if (self.currentWallet.TypeW==1){
        HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
        SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
        [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        
        
    }else if (self.currentWallet.TypeW==2){
        HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
        SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
        [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        
    }else if (self.currentWallet.TypeW==3){
        HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
        SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
        [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
    }
    
    

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
    
}
-(void)setModel:(assetsListModel *)model{
    _model=model;
    
}

-(void)choosedFriedsMode:(friendsModel*)model{
self.transferTheAddressTextField.text=model.address;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    NSCharacterSet *cs;
    
    if ([textField isEqual:self.theAmountOfTextField]) {
        
        NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
        
        if (NSNotFound == nDotLoc && 0 != range.location) {
            
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
            
        }
        
        else {
            
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
            
        }
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if (!basicTest) {
            
            
            
            //            [self showMyMessage:@"只能输入数字和小数点"];
            
            return NO;
            
        }
        
        if (NSNotFound != nDotLoc && range.location > nDotLoc + 4) {
            
            //            [self showMyMessage:@"小数点后最多三位"];
            
            return NO;
            
        }
        
    }
    
    return YES;
}
@end
