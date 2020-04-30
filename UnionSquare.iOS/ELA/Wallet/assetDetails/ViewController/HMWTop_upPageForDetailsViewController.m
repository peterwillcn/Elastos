//
//  HMWTop_upPageForDetailsViewController.m
//  ELA
//
//  Created by 韩铭文 on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWTop_upPageForDetailsViewController.h"
#import "HMWChooseSideChainViewController.h"


@interface HMWTop_upPageForDetailsViewController ()
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
@end

@implementation HMWTop_upPageForDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@"asset_bg"];
     [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.addressTextField];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.enterTheAmountTextField];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.noteTextField];
    [[HMWCommView share] makeBordersWithView:self.theNextStepButton];
}

- (IBAction)ChooseSideChainEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pasteEvent:(id)sender {
}
- (IBAction)selectFriendsEvent:(id)sender {
    self.friendsButton.userInteractionEnabled=NO;
    HMWChooseSideChainViewController *chooseSideChainVC=[[HMWChooseSideChainViewController alloc]init];
    chooseSideChainVC.type=1;
    [self.navigationController pushViewController:chooseSideChainVC animated:YES]; self.friendsButton.userInteractionEnabled=YES;
}
- (IBAction)maxEvent:(id)sender {
}
- (IBAction)theNextStepEvent:(id)sender {
}
-(void)setSelectIndex:(NSIndexPath *)selectIndex{
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
