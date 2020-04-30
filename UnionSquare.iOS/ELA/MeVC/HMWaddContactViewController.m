//
//  HMWaddContactViewController.m
//  ELA
//

#import "HMWaddContactViewController.h"
#import "HMWFMDBManager.h"
#import "friendsModel.h"
#import "WCQRCodeScanningVC.h"

@interface HMWaddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *theWalletAddressTextField;
@property (weak, nonatomic) IBOutlet UIButton *QrCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *pasteButton;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneNOTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBuddyButton;

@end

@implementation HMWaddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self defultWhite];
    [self setBackgroundImg:@""];
   [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField: self.nickNameTextField withTxt:NSLocalizedString(@"请输入姓名（必填）", nil)];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.theWalletAddressTextField withTxt:NSLocalizedString(@"请输入钱包地址（必填）", nil)];
 
 
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.mobilePhoneNOTextField withTxt:NSLocalizedString(@"请输入手机号码", nil)];
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.emailTextField withTxt:NSLocalizedString(@"请输入邮箱", nil)];
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField withTxt:NSLocalizedString(@"请输入备注", nil)];
    [[HMWCommView share]makeBordersWithView:self.addBuddyButton];
    [self.addBuddyButton setTitle:NSLocalizedString(@"添加", nil) forState:UIControlStateNormal];
    if (self.model.nameString.length>0) {
        
    
    
    self.nickNameTextField.text=self.model.nameString;
    
    self.theWalletAddressTextField.text=self.model.address;
    
    self.mobilePhoneNOTextField.text=self.model.mobilePhoneNo;
    self.emailTextField.text=self.model.email;
    
        self.noteTextField.text=self.model.note;
        
        [self.addBuddyButton setTitle:NSLocalizedString(@"确认修改", nil) forState:UIControlStateNormal];
    }
    if (self.addressString.length>0) {
        self.theWalletAddressTextField.text=self.addressString;
    }
    
    
    
}
- (IBAction)sweepTheQRCodeEvent:(id)sender {
    __weak __typeof__(self) weakSelf = self;
    WCQRCodeScanningVC *WCQRCode=[[WCQRCodeScanningVC alloc]init];
    WCQRCode.scanBack=^(NSString *addr){
        weakSelf.theWalletAddressTextField.text=addr;
        
    };
    [self QRCodeScanVC:WCQRCode];
}

- (IBAction)pasteTheEvent:(id)sender {
  self.theWalletAddressTextField.text = [[FLTools share]pastingTextFromTheClipboard];
    
}
- (IBAction)addBuddyEvent:(id)sender {
    if (self.nickNameTextField.text.length==0||self.theWalletAddressTextField.text==0) {
        return;
    }
    friendsModel *model=[[friendsModel alloc]init];
   
    model.nameString=self.nickNameTextField.text;
    model.address=self.theWalletAddressTextField.text;
    model.mobilePhoneNo=self.mobilePhoneNOTextField.text;
    model.email=self.emailTextField.text;
    model.note=self.noteTextField.text;
    
    if (self.model.nameString.length==0) {
        if ([[HMWFMDBManager sharedManagerType:friendsModelType]addRecord:model]){
            [[FLTools share]showErrorInfo:NSLocalizedString(@"添加成功！", nil)];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
        model.ID=self.model.ID;
        if ([[HMWFMDBManager sharedManagerType:friendsModelType]updateRecord:model]){
            [[FLTools share]showErrorInfo:NSLocalizedString(@"修改成功！", nil)];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
-(void)setModel:(friendsModel *)model{
    _model=model;
    
}
@end
