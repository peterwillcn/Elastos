//
//  HMWsignUpForViewController.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWsignUpForViewController.h"
#import "HMWtransferDetailsPopupView.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWtransferViewController.h"
#import "FLVoteTicketTransferVC.h"

#import "HMWSelectCountriesOrRegionsViewController.h"
@interface HMWsignUpForViewController ()<HMWSelectCountriesOrRegionsViewControllerDelegate,HMWtransferDetailsPopupViewDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@property (weak, nonatomic) IBOutlet UITextField *theNameOfTheNodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *thePublicKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *countriesTextField;
@property (weak, nonatomic) IBOutlet UITextField *URLTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmToRunButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseTheCountryBuuton;

@property(nonatomic,assign)NSString *mobCodeString;


/*
 *<# #>
 */
@property(strong,nonatomic)HMWtransferDetailsPopupView *transferDetailsPopupV;


@end

@implementation HMWsignUpForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@"tab_bg"];
    self.title=@"报名参选";
    // Do any additional setup after loading the view from its nib.
    
 [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.theNameOfTheNodeTextField];
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.thePublicKeyTextField];
 [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.countriesTextField];
  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.URLTextField];
 [[HMWCommView share]makeBordersWithView:self.confirmToRunButton];

}
-(HMWtransferDetailsPopupView *)transferDetailsPopupV{
    if (!_transferDetailsPopupV) {
        _transferDetailsPopupV =[[HMWtransferDetailsPopupView alloc]init];
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
    
    
    FLJoinVoteInfoModel* model = [[FLJoinVoteInfoModel alloc]init];
    model.pubKey = @"";
    model.nodePubKey =self.thePublicKeyTextField.text;
    model.nickName = self.theNameOfTheNodeTextField.text;
    model.url = self.URLTextField.text;
    model.contryCode = self.mobCodeString;
    
    FLVoteTicketTransferVC *transferVC=[[FLVoteTicketTransferVC alloc]init];
    transferVC.infoModel = model;
    [self.navigationController pushViewController:transferVC animated:YES];
    
//    UIView *manView=[self mainWindow];
//    [manView addSubview:self.transferDetailsPopupV];
//    [self.transferDetailsPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(manView);
//    }];
    
    
    
}
#pragma mark ---------HMWtransferDetailsPopupViewDelegate----------

-(void)closeThePage{
    
    
    [self.transferDetailsPopupV removeFromSuperview];
    self.transferDetailsPopupV=nil;
}

- (void)pwdAndInfoWithPWD:(NSString *)pwd {
    
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
    //    if (self.mobCodeString.length>4) {
    //        self.mobCodeString = [self.mobCodeString substringWithRange:NSMakeRange(self.mobCodeString.length-4, 4)];
    //    }
    //    if (self.mobCodeString.length<4) {
    //        if (self.mobCodeString.length==2) {
    //            self.mobCodeString=[NSString stringWithFormat:@"00%@",self.mobCodeString];
    //        }else if(self.mobCodeString.length==3){
    //            self.mobCodeString=[NSString stringWithFormat:@"0%@",mobCodeString];
    //        }
    //    }
    
    self.countriesTextField.text = modelDic[@"countries"];
    //    [self.countryPhoneCodeButton setTitle:[NSString stringWithFormat:@"+%@",mobCodeString] forState:UIControlStateNormal];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.view endEditing:YES];
}

@end
