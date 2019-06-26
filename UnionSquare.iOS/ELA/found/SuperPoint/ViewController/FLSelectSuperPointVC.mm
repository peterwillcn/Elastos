//
//  FLSelectSuperPointVC.m
//  ELA
//
//  Created by 樊晓乐 on 2018/11/15.
//  Copyright © 2018年 樊晓乐. All rights reserved.
//

#import "FLSelectSuperPointVC.h"
#import "HMWsignUpForViewController.h"
#import "HMWtheSuperNodeElectionViewController.h"

#import "FLManageSelectPointNodeInformationVC.h"

#import "ELWalletManager.h"
#import "DrawBackVoteMoneyVC.h"
#import "assetDetailsModel.h"
@interface FLSelectSuperPointVC ()<HMWsignUpForViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *goingToVoteButton;

@property (weak, nonatomic) IBOutlet UIButton *signUpForButton;
@property (weak, nonatomic) IBOutlet UIButton *manageVoteBtn;
@property(nonatomic,assign)NSInteger  type; //1选举管理
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL hasSing;
@end

@implementation FLSelectSuperPointVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self defultWhite];
    
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    
    nlohmann::json info = mainchainSubWallet->GetRegisteredProducerInfo();
    NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
    
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    NSString *Status = param[@"Status"];
    if ([Status isEqualToString:@"Registered"]){
        [self.signUpForButton setTitle:NSLocalizedString(@"选举管理", nil) forState:UIControlStateNormal];
        self.manageVoteBtn.hidden = YES;
        
        self.type =1;
    }else if([Status isEqualToString:@"Canceled"]){
        self.manageVoteBtn.hidden = NO;
        self.signUpForButton.hidden = YES;
    }else if([Status isEqualToString:@"Unregistered"]){
        self.manageVoteBtn.hidden = YES;
    }else if ([Status isEqualToString:@"ReturnDeposit"]){
        self.manageVoteBtn.hidden = YES;
        self.signUpForButton.hidden = YES;
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"超级节点选举", nil) ;
    [self.goingToVoteButton setTitle:NSLocalizedString(@"我要投票", nil) forState:UIControlStateNormal];
     [self.signUpForButton setTitle:NSLocalizedString(@"报名参选", nil) forState:UIControlStateNormal];
     [self.manageVoteBtn setTitle:NSLocalizedString(@"选举管理", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.goingToVoteButton];
      [[HMWCommView share]makeBordersWithView:self.signUpForButton];
    [[HMWCommView share]makeBordersWithView:self.manageVoteBtn];

    
    
//    [self ishasVotedPoint];
}
//有没有退钱的订单

//-(BOOL)ishasVotedPoint{
//    ELWalletManager *manager   =  [ELWalletManager share];
//
//    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
//
//    Json result = mainchainSubWallet->GetAllTransaction(0, 500,"");
//    NSString *dataStr = [NSString stringWithUTF8String:result.dump().c_str()];
//
//    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//    NSArray *tranList=[NSArray modelArrayWithClass:assetDetailsModel.class json:param[@"Transactions"]];
//    BOOL ret = NO ;
//
//    for (int i=0; i < tranList.count; i++) {
//        assetDetailsModel *model = tranList[i];
//        if (model.Type.integerValue==10 && model.ConfirmStatus.integerValue>=1) {
//            ret = YES;
//            break;
//        }
//    }
//
//     self.manageVoteBtn.hidden = !ret;
//    return  ret;
//}
- (IBAction)signUpForButton:(id)sender {

    if (self.type ==1) {
        FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        if (self.hasSing) {
            
            [[FLTools share]showErrorInfo:NSLocalizedString(@"已参选", nil) ];
            return;
        }
        HMWsignUpForViewController *vc=[[HMWsignUpForViewController alloc]init];
        vc.delegate=self;
        self.hasSing=NO;
        vc.model=nil;
        [self.navigationController pushViewController:vc animated:YES];

    }
}
- (IBAction)DrawBackVote:(id)sender {
    
    DrawBackVoteMoneyVC *vc = [[DrawBackVoteMoneyVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)goingToVoteEvent:(id)sender {
    HMWtheSuperNodeElectionViewController*theSuperNodeElectionVC=[[HMWtheSuperNodeElectionViewController alloc]init];
    
    [self.navigationController pushViewController:theSuperNodeElectionVC animated:YES];
}
-(void)hasSignUp{
    self.hasSing=YES;
    
}
@end
