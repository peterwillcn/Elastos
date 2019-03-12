//
//  HMWtransferViewController.m
//  ELA
//
//  Created by 韩铭文 on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtransferViewController.h"
#import "HMWtransferDetailsPopupView.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWChooseSideChainViewController.h"

@interface HMWtransferViewController ()<HMWtransferDetailsPopupViewDelegate>
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


@end

@implementation HMWtransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self defultWhite];
    [self setBackgroundImg:@"asset_bg"];
    self.title=@"转账";
    
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.transferTheAddressTextField];
    
    [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.theAmountOfTextField];
   [[HMWCommView share] makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField];
    [[HMWCommView share]makeBordersWithView:self.theNextStepButton];
    [[HMWCommView share]makeBordersWithView:self.maxButton];
}

- (IBAction)pasteEvent:(id)sender {
    
    
    self.transferTheAddressTextField.text=[[FLTools share]pastingTextFromTheClipboard];
}
- (IBAction)theContactEvent:(id)sender {
    self.theContactButton.userInteractionEnabled=NO;
    HMWChooseSideChainViewController *chooseSideChainVC=[[HMWChooseSideChainViewController alloc]init];
    chooseSideChainVC.type=1;
    [self.navigationController pushViewController:chooseSideChainVC animated:YES]; self.theContactButton.userInteractionEnabled=YES;
}
- (IBAction)maxAmountEvent:(id)sender {
}
- (IBAction)theNextStepEvent:(id)sender {
    
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
-(void)pwdAndInfo{
    
    [self.transferDetailsPopupV removeFromSuperview];
    self.transferDetailsPopupV=nil;
    [self showSendSuccessPopuV];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
