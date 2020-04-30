//
//  HWMTheValidationWordMnemonicPassword.m
//  elastos wallet
//
//  Created by  on 2019/8/21.
//

#import "HWMTheValidationWordMnemonicPassword.h"


@interface HWMTheValidationWordMnemonicPassword ()
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UITextField *PWDTextField;
@property (weak, nonatomic) IBOutlet UIButton *determineButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *DeleteDirectlyButton;

@end

@implementation HWMTheValidationWordMnemonicPassword
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMTheValidationWordMnemonicPassword" owner:nil options:nil].firstObject;
        [self.determineButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [self.cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
          [self.DeleteDirectlyButton setTitle:NSLocalizedString(@"直接删除", nil) forState:UIControlStateNormal];
        self.titileLabel.text=NSLocalizedString(@"验证助记词密码", nil);
//        if (@available(iOS 11.0, *)) {
//             self.PWDTextField.textContentType = UITextContentTypePassword;
//             self.PWDTextField.textContentType = UITextContentTypePassword;
//        }
//        if (@available(iOS 12.0, *)) {
//            self.PWDTextField.textContentType = UITextContentTypeNewPassword;
//           self.PWDTextField.textContentType = UITextContentTypeNewPassword;
//        } else {
//           self.PWDTextField.secureTextEntry = YES;
//        }
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField: self.PWDTextField withTxt:NSLocalizedString(@"请输入助记词密码", nil)];
      
    }
    
    return self;
    
    
}
- (IBAction)closeViewEvent:(id)sender {
    if (self.delegate) {
        [self.delegate closeView];
    }
}
- (IBAction)determineEvent:(id)sender {
    if (self.PWDTextField.text.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入助记词密码", nil)];
        return;
    }
    if (self.delegate) {
        [self.delegate MandatoryDeleteWithPWD:self.PWDTextField.text];
    }
}
- (IBAction)cancelEvent:(id)sender {
    if (self.delegate) {
        [self.delegate closeView];
    }
}
- (IBAction)DeleteDirectlyEvent:(id)sender {
    if (self.delegate) {
        [self.delegate MandatoryDeleteWithPWD:nil];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}
@end
