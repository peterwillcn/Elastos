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
/*
 *<# #>
 */
@property(assign,nonatomic)bool isMax;

@end

@implementation HMWtransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self defultWhite];
    self.isMax=NO;
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"转账", nil);
    self.isVoteBlanceTextLabel.text=NSLocalizedString(@"是否使用投票utxo", nil);
    
    self.isAddSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
    self.isAddSwitch.layer.borderWidth=2.f;
    self.isAddSwitch.layer.cornerRadius=15.f; self.isAddSwitch.layer.masksToBounds=YES;
    self.isAddSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
    [self loadCanUserBlanceLoadDataSource];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"setting_adding_scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(scanView)];
    
       self.theAmountOfTextField.placeholder=[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"请输入金额 可用", nil),[[FLTools share]elaScaleConversionWith:self.model.iconBlance],@"ELA"];
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.transferTheAddressTextField withTxt:NSLocalizedString(@"请输入收款人地址", nil)];
   [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField withTxt:NSLocalizedString(@"请输入备注", nil)];
    [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
//    [[HMWCommView share]makeBordersWithView:self.maxButton];
    [self.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    self.theAmountOfTextField.delegate=self;
    if (self.toAddressString.length>0) {
      self.transferTheAddressTextField.text=self.toAddressString;
    }
    
    
}
-(void)loadCanUserBlanceLoadDataSource{

    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@0] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getBalance"];
    PluginResult * result =[[ELWalletManager share]getBalance:mommand];
    
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]){
        
        
        
        NSString *blanceString=[NSString stringWithFormat:@"%@",result.message[@"success"]];
          [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.theAmountOfTextField withTxt:[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"请输入金额 可用", nil),[[FLTools share]elaScaleConversionWith:blanceString],@"ELA"]];
        self.model.iconBlance=blanceString;

    }
    
}
-(void)scanView{
    __weak __typeof__(self) weakSelf = self;
    WCQRCodeScanningVC *WCQRCode=[[WCQRCodeScanningVC alloc]init];
    WCQRCode.scanBack=^(NSString *addr){
        [self SweepCodeProcessingResultsWithQRCodeString:addr];
    };
    [self QRCodeScanVC:WCQRCode];
}
-(void)SweepCodeProcessingResultsWithQRCodeString:(NSString*)QRCodeString{
    NSLog(@"解析前%@",QRCodeString);
    NSDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:[[FLTools share]QrCodeImageFromDic:QRCodeString fromVC:self oldQrCodeDic:nil]];
 
    NSLog(@"解析后%@",dic);
    if ([[FLTools share]SCanQRCodeWithDicCode:dic]){
        if ([dic[@"extra"][@"Type"] integerValue]==4) {
        self.transferTheAddressTextField.text=dic[@"data"];
        }
    }
    
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
    self.isMax=YES;
    self.theAmountOfTextField.text=@"Max";
    
}
- (IBAction)theNextStepEvent:(id)sender {
    if (self.transferTheAddressTextField.text.length==0) {
         [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入收款人地址", nil)];
        
        return;
    }
    NSString *blance;
    if (self.isMax==NO) {
        if ([self.theAmountOfTextField.text doubleValue]==0) {
              [[FLTools share]showErrorInfo:NSLocalizedString(@"金额需要大于0", nil)];
              return;
          }
          if ([self.theAmountOfTextField.text doubleValue]>[[[FLTools share]elaScaleConversionWith:self.model.iconBlance] doubleValue]) {
              
             [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
              return;
          }
         blance=[[FLTools share]elsToSela:self.theAmountOfTextField.text];
        }else{
        blance=@"-1";
    }
    NSString *isUtxo=@"1";
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"",self.transferTheAddressTextField.text,blance,self.noteTextField.text,self.noteTextField.text,isUtxo] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
    PluginResult * result =[[ELWalletManager share]accessFees:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if (![status isEqualToString:@"1"]) {
        return;
    }
    NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",result.message[@"success"]]];
    self.fee=fee;
    if ([self.theAmountOfTextField.text doubleValue]>[[[FLTools share]elaScaleConversionWith:self.model.iconBlance] doubleValue]) {
        
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
        if (self.currentWallet.TypeW==1||self.currentWallet.TypeW==3) {
            _transferDetailsPopupV.type=readOnlyWallettransfer_type;
        }
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

//    SingleSign=0,
//    SingleSignReadonly=1,
//    HowSign=2,
//    HowSignReadonly=3
    
    NSString *blance;
    if (self.isMax) {
        blance=@"-1";
    }else{
        blance=[[FLTools share]elsToSela:self.theAmountOfTextField.text];
    }
    
    if (self.currentWallet.TypeW==0) {
        NSString *isUtxo=@"1";
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"",self.transferTheAddressTextField.text,blance,self.noteTextField.text,self.noteTextField.text,pwd,isUtxo] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
        PluginResult *result = [[ELWalletManager share]CreateTransaction:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
            [self.transferDetailsPopupV removeFromSuperview];
            self.transferDetailsPopupV=nil;
            [self showSendSuccessPopuV];
        }
    }else if (self.currentWallet.TypeW==1){
        NSString *isUtxo=@"1";
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"",self.transferTheAddressTextField.text,blance,self.noteTextField.text,self.noteTextField.text,pwd,isUtxo] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]MSignAndReadOnlyCreateTransaction:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
        HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
        SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
            NSDictionary *successDic=[[NSDictionary alloc]initWithDictionary:result.message[@"success"]]; SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:successDic];
           SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
    SignatureTradingSingleQrCodeVC.subW=self.model.iconName;
        [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
    }else if (self.currentWallet.TypeW==2){
        NSString *isUtxo=@"1";
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"",self.transferTheAddressTextField.text,blance,self.noteTextField.text,self.noteTextField.text,pwd,isUtxo] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"QrCodeCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]QrCodeCreateTransaction:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
        HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
        SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
            SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:result.message[@"success"]];
          SignatureTradingSingleQrCodeVC.currentWallet=self.currentWallet; SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"]; SignatureTradingSingleQrCodeVC.subW=self.model.iconName;
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
    }else if (self.currentWallet.TypeW==3){
        NSString *isUtxo=@"1";
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"",self.transferTheAddressTextField.text,blance,self.noteTextField.text,self.noteTextField.text,pwd,isUtxo] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"QrCodeCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]MSignAndReadOnlyCreateTransaction:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
        HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
        SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
            SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:result.message[@"success"]];
            SignatureTradingSingleQrCodeVC.currentWallet=self.currentWallet; SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
            SignatureTradingSingleQrCodeVC.subW=self.model.iconName;
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
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
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.theAmountOfTextField) {
        if ([self.theAmountOfTextField.text isEqualToString:@"Max"]) {
            self.theAmountOfTextField.text=nil;
            self.isMax=NO;
        }
    }
    
    
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
    if (self.isMax) {
        self.isMax=NO;
    }
    return YES;
}
-(void)setToAddressString:(NSString *)toAddressString{
    _toAddressString=toAddressString;
    
}

@end
