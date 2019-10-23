//
//  HMWtheContactInformationViewController.m
//  ELA
//

#import "HMWtheContactInformationViewController.h"
#import "HMWaddContactViewController.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HMWQrCodePopupWindowView.h"
#import "HMWFMDBManager.h"

@interface HMWtheContactInformationViewController ()<HMWToDeleteTheWalletPopViewDelegate,HMWQrCodePopupWindowViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *theWalletAddressTextField;
@property (weak, nonatomic) IBOutlet UIButton *QrCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *pasteButton;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneNOTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *deleteFrButton;
@property (weak, nonatomic) IBOutlet UIButton *theEditorFrButton;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *toDeleteTheWalletPopV;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWQrCodePopupWindowView *QrCodePopupWindowV;

@end

@implementation HMWtheContactInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
   self.nickNameTextField.enabled=NO;
self.theWalletAddressTextField.enabled=NO;
    self.mobilePhoneNOTextField.enabled=NO;
    self.emailTextField.enabled=NO;
    self.noteTextField.enabled=NO;
    self.title=NSLocalizedString(@"联系人信息", nil);
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.nickNameTextField withTxt:NSLocalizedString(@"请输入姓名（必填）", nil)];
   [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.theWalletAddressTextField withTxt:NSLocalizedString(@"请输入钱包地址（必填）", nil)];
   
[[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.mobilePhoneNOTextField withTxt:NSLocalizedString(@"请输入手机号码", nil)];
 [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.emailTextField withTxt:NSLocalizedString(@"请输入邮箱", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField withTxt:NSLocalizedString(@"请输入备注", nil)];
    [[HMWCommView share]makeBordersWithView:self.deleteFrButton];
     [[HMWCommView share]makeBordersWithView:self.theEditorFrButton];
    self.nickNameTextField.text=self.model.nameString;
   self.theWalletAddressTextField.text=self.model.address;
    self.mobilePhoneNOTextField.text=self.model.mobilePhoneNo;
    self.emailTextField.text=self.model.email;
    self.noteTextField.text=self.model.note;
    [self.theEditorFrButton setTitle:NSLocalizedString(@"编辑", nil) forState:UIControlStateNormal];
    [self.deleteFrButton setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
}

- (IBAction)editTheContactEvent:(id)sender {
    HMWaddContactViewController *addContactVC=[[HMWaddContactViewController alloc]init];
    addContactVC.title=NSLocalizedString(@"编辑联系人", nil);
    addContactVC.model=self.model;
    addContactVC.typeInfo=ChangeInfo;
    [self.navigationController pushViewController:addContactVC animated:YES];
}
- (IBAction)deleteTheContactEvent:(id)sender {
    
    UIView *maView=[self mainWindow];
    [maView addSubview:self.toDeleteTheWalletPopV];
    [self.toDeleteTheWalletPopV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(maView);
    }];
}
-(HMWQrCodePopupWindowView *)QrCodePopupWindowV{
    if (!_QrCodePopupWindowV) {
        _QrCodePopupWindowV =[[HMWQrCodePopupWindowView alloc]init];
        _QrCodePopupWindowV.walletAddressString=self.model.address;
        _QrCodePopupWindowV.delegate=self;
    }
    
    return _QrCodePopupWindowV;
}
-(HMWToDeleteTheWalletPopView *)toDeleteTheWalletPopV{
    if (!_toDeleteTheWalletPopV) {
        _toDeleteTheWalletPopV =[[HMWToDeleteTheWalletPopView alloc]init];
        _toDeleteTheWalletPopV.delegate=self;
        _toDeleteTheWalletPopV.deleteType=deleteFriends;
    }
    
    return _toDeleteTheWalletPopV;
}
#pragma mark --------HMWToDeleteTheWalletPopViewDelegate----------
-(void)sureToDeleteViewDelegate{
    
    if ([[HMWFMDBManager sharedManagerType:friendsModelType]delectRecord:self.model]){
        [[FLTools share]showErrorInfo:NSLocalizedString(@"添加成功！", nil)];
         [self toCancelOrCloseDelegate];
        
    }
    
   
    
}
-(void)toCancelOrCloseDelegate{
    
    [self.toDeleteTheWalletPopV removeFromSuperview];
    self.toDeleteTheWalletPopV=nil;
}
- (IBAction)accordingToQRCodeEvent:(id)sender {
    UIView *manView =[self mainWindow];
    [manView addSubview:self.QrCodePopupWindowV];
  
    [self.QrCodePopupWindowV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    
    
}

-(void)QrCodePopupWindowHidde{
    
    [self.QrCodePopupWindowV removeFromSuperview];
    
    self.QrCodePopupWindowV=nil;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (void)setModel:(friendsModel *)model{
    _model=model;
    
}
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    
    if ([[HMWFMDBManager sharedManagerType:friendsModelType] delectRecord:self.model]){
       [[FLTools share]showErrorInfo:NSLocalizedString(@"删除成功", nil)];
       [self toCancelOrCloseDelegate];
       [self.navigationController popToRootViewControllerAnimated:YES];
    
      
    }
    
    
}
@end
