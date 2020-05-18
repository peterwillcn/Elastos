//
//  HMWTop_upPageForDetailsViewController.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWTop_upPageForDetailsViewController.h"
#import "HMWChooseSideChainViewController.h"
#import "ELWalletManager.h"
#import "HMWtransferDetailsPopupView.h"
#import "HMWSendSuccessPopuView.h"
#import "WCQRCodeScanningVC.h"



@interface HMWTop_upPageForDetailsViewController ()< HMWChooseSideChainViewControllerDelegate,HMWtransferDetailsPopupViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBGViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *toUpNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseSideChainButton;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *pasteButton;
@property (weak, nonatomic) IBOutlet UIButton *friendsButton;
@property (weak, nonatomic) IBOutlet UITextField *enterTheAmountTextField;
@property (weak, nonatomic) IBOutlet UIButton *maxButton;
@property (weak, nonatomic) IBOutlet UILabel *theExchangeRateLabel;

@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *theNextStepButton;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWtransferDetailsPopupView *transferDetailsPopupV;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *assetIconImageView;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *fee;
@end

@implementation HMWTop_upPageForDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"setting_adding_scan"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(scanView)];
    self.toUpNameLabel.text=[NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"充值到", nil),@"IDChain"];
//     self.toUpNameLabel.text=[NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"充值到", nil),@"ELA"];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.addressTextField withTxt:NSLocalizedString(@"请输入主链提现地址", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.enterTheAmountTextField withTxt:[NSString stringWithFormat:@"%@：%@ %@",NSLocalizedString(@"请输入金额 可用", nil),[[FLTools share] elaScaleConversionWith:self.fromModel.iconBlance],@"ELA"]];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField withTxt:NSLocalizedString(@"请输入备注", nil)];
    [[HMWCommView share] makeBordersWithView:self.theNextStepButton];
    [self.theNextStepButton setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];    
    if (self.type==mainChainWithdrawalType) {
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.addressTextField withTxt:NSLocalizedString(@"请输入主链提现地址", nil)];
        self.BGViewHeight.constant=0.f;
        self.assetIconImageView.alpha=0.f;
    }else{
        
         [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.addressTextField withTxt:NSLocalizedString(@"请输入侧链充值地址", nil)];
        
    }
    self.enterTheAmountTextField.delegate=self;
    self.theExchangeRateLabel.text=[NSString stringWithFormat:@"%@ 1:1",NSLocalizedString(@"汇率", nil)];
    
}
-(void)scanView{
    __weak __typeof__(self) weakSelf = self;
    WCQRCodeScanningVC *WCQRCode=[[WCQRCodeScanningVC alloc]init];
    WCQRCode.scanBack=^(NSString *addr){
         weakSelf.addressTextField.text=addr;
    };
    [self QRCodeScanVC:WCQRCode];
}

-(void)SweepCodeProcessingResultsWithQRCodeString:(NSString*)QRCodeString{
    self.enterTheAmountTextField.text=@"";
    self.addressTextField.text=@"";
//    //NSLog(@"解析前%@",QRCodeString);
//
//    NSDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:[[FLTools share]QrCodeImageFromDic:QRCodeString fromVC:self oldQrCodeDic:nil]];
//
//    //NSLog(@"解析后%@",dic);
//  if ([[FLTools share]SCanQRCodeWithDicCode:dic]){
//    if ([dic[@"extra"][@"Type"] integerValue]==4) {
//
//                 self.addressTextField.text=dic[@"data"];
//
//                 }else{
//
//
//                     if ([QRCodeString containsString:@"elastos:"]) {
//
//                         NSArray *elasArray=[QRCodeString componentsSeparatedByString:@":"];
//
//                         if ([elasArray.lastObject containsString:@"?amount="]) {
//
//                               NSArray *amountArray=[elasArray.lastObject componentsSeparatedByString:@"?amount="];
//
//                             self.enterTheAmountTextField.text=amountArray.lastObject;
//                                   self.addressTextField.text=amountArray.firstObject;
//
//                         }else{
//                             self.addressTextField.text=elasArray.lastObject;
//                         }
//
//                     }else if([[ELWalletManager share]IsAddressValidWithMastID:self.currentWallet.masterWalletID WithAddress:QRCodeString]){
//                         self.addressTextField.text=QRCodeString;
//
//                     }else{
//
//                         [self QrCodeScanningResultsWithString:QRCodeString withVC:self];
//
//                     }
//
//                 }
//
//             }else if([[ELWalletManager share]IsAddressValidWithMastID:self.currentWallet.masterWalletID WithAddress:QRCodeString]){
//                 self.addressTextField.text=QRCodeString;
//
//             }else{
//
//
//
//
//
//
//
//                    [self QrCodeScanningResultsWithString:QRCodeString withVC:self];
//
//
//
//
//
//             }

             

             
    if ([[ELWalletManager share]IsAddressValidWithMastID:self.currentWallet.masterWalletID WithAddress:QRCodeString]) {
           self.addressTextField.text=QRCodeString;
      }else{
           [self QrCodeScanningResultsWithString:QRCodeString withVC:self];
      }
             

             

             

         }
- (IBAction)ChooseSideChainEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pasteEvent:(id)sender {
    
    
    self.addressTextField.text=[[FLTools share]pastingTextFromTheClipboard];
    
}
- (IBAction)selectFriendsEvent:(id)sender {
    self.friendsButton.userInteractionEnabled=NO;
    HMWChooseSideChainViewController *chooseSideChainVC=[[HMWChooseSideChainViewController alloc]init];
    chooseSideChainVC.type=chooseFriendsType;
    chooseSideChainVC.delegate=self;
    [self.navigationController pushViewController:chooseSideChainVC animated:YES]; self.friendsButton.userInteractionEnabled=YES;
}
- (IBAction)maxEvent:(id)sender {
}
- (IBAction)theNextStepEvent:(id)sender {
    if (self.addressTextField.text.length==0) {
        return;
    }
    if ([self.enterTheAmountTextField.text doubleValue]==0 ) {
         [[FLTools share]showErrorInfo:NSLocalizedString(@"金额需要大于0", nil)];
        return;
    }
        if ([self.enterTheAmountTextField.text doubleValue]>[[[FLTools share]elaScaleConversionWith:self.fromModel.iconBlance] doubleValue]) {

            [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
            return;
        }
   
    PluginResult * result;
    if (self.type==sideChainTop_upType) {
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.fromModel.iconName,self.selectmModel.iconName,@"",self.addressTextField.text,[[FLTools share]elsToSela:self.enterTheAmountTextField.text],self.noteTextField.text,self.noteTextField.text,@"0"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"sideChainTop_UpFee"];
        
  result=[[ELWalletManager share]sideChainTop_UpFee:mommand];
        
      
    }
    if (self.type==mainChainWithdrawalType) {
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.fromModel.iconName,self.substringAddress,self.addressTextField.text,[[FLTools share]elsToSela:self.enterTheAmountTextField.text],self.noteTextField.text,self.noteTextField.text] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"sideChainTop_UpFee"];
  result=[[ELWalletManager share]mainChainWithdrawalFee:mommand];
       
        
  
        
    }
    
    NSString *fee=[[FLTools share]elaScaleConversionWith: [NSString stringWithFormat:@"%@",result.message[@"success"]]];
    self.fee=fee;
    if ([self.enterTheAmountTextField.text doubleValue]+[self.fee doubleValue]>[[[FLTools share]elaScaleConversionWith:self.fromModel.iconBlance] doubleValue]) {
        
        [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
        return;
    }
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if (![status isEqualToString:@"1"]) {
        return;
    }
    
    [self.transferDetailsPopupV transferDetailsWithToAddress:self.addressTextField.text withTheAmountOf:[NSString stringWithFormat:@"%@%@",  self.enterTheAmountTextField.text,@"ELA"] withFee:[NSString stringWithFormat:@"%@%@",fee,@"ELA"]];
    
    

    
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
        _transferDetailsPopupV.type=sideChainTop_UpType;
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
        self.sendSuccessPopuV=nil;
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
    
    if (self.type==sideChainTop_upType) {
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.fromModel.iconName,self.selectmModel.iconName,self.addressArray.firstObject,self.addressTextField.text,[[FLTools share]elsToSela:self.enterTheAmountTextField.text],self.noteTextField.text,self.noteTextField.text,pwd,@"1"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"sideChainTop_Up"];
        
            PluginResult *result = [[ELWalletManager share]sideChainTop_Up:mommand];
            NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        
            if (![statue isEqualToString:@"1"]) {
            return;
            }
        [self.transferDetailsPopupV removeFromSuperview];
          
          self.transferDetailsPopupV=nil;
         [self showSendSuccessPopuV];
        
    }
    if (self.type==mainChainWithdrawalType) {
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.fromModel.iconName,@"",self.addressTextField.text,[[FLTools share]elsToSela:self.enterTheAmountTextField.text],self.noteTextField.text,self.noteTextField.text,pwd,@"0"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"mainChainWithdrawal"];
        
        PluginResult *result = [[ELWalletManager share]mainChainWithdrawal:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if (![statue isEqualToString:@"1"]) {
            return;
        }
        [self.transferDetailsPopupV removeFromSuperview];
          
          self.transferDetailsPopupV=nil;
        [self showSendSuccessPopuV];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)setSelectIndex:(NSIndexPath *)selectIndex{
    
}

-(void)choosedFriedsMode:(friendsModel*)model{
    
    self.addressTextField.text=model.address;
    
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
    
    
}
-(void)setAddressArray:(NSArray *)addressArray{
    _addressArray=addressArray;
    
}
-(void)setFromModel:(assetsListModel *)fromModel{
    _fromModel=fromModel;
    
}
-(void)setSelectmModel:(assetsListModel *)selectmModel{
    _selectmModel=selectmModel;
    
    
}
-(void)setType:(Top_upPageForDetailsType)type{
    _type=type;
    
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
 
    
    NSCharacterSet *cs;
    
    if ([textField isEqual:self.enterTheAmountTextField]) {
        
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
