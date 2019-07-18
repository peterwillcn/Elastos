//
//  HMWtheSuperNodeElectionViewController.m
//  ELA
//
//  Created by  on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWtheSuperNodeElectionViewController.h"
#import "HMWVotingListView.h"
#import "HMWvotingRulesView.h"
#import "HMWnodeInformationViewController.h"
#import "FLCoinPointInfoModel.h"
#import "HMWtheCandidateListViewController.h"
#import "HMWMyVoteViewController.h"
#import "FLNotePointDBManager.h"
#import "DC_DealTextViewController.h"
#import "HMWsignUpForViewController.h"
#import "FLManageSelectPointNodeInformationVC.h"
#import "HMWFMDBManager.h"
#import "DrawBackVoteMoneyVC.h"
@interface HMWtheSuperNodeElectionViewController ()<HMWvotingRulesViewDelegate,HMWVotingListViewDelegate,HMWsignUpForViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tagMyVotedLab;
@property (weak, nonatomic) IBOutlet UILabel *tagVoteRuleLab;

/*
 *<# #>
 */
@property(strong,nonatomic)HMWVotingListView *votingListV;
@property (weak, nonatomic) IBOutlet UIButton *toVoteButton;

@property (weak, nonatomic) IBOutlet UIButton *votingRulesButton;
@property (weak, nonatomic) IBOutlet UIButton *myVoteButton;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWvotingRulesView *votingRulesV;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger type;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL hasSing;
@property (weak, nonatomic) IBOutlet UIImageView *found_vote_rule;

@end

@implementation HMWtheSuperNodeElectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"超级节点选举", nil);
    self.tagMyVotedLab.text=NSLocalizedString(@"我的投票", nil);
    
    [self.toVoteButton setTitle:NSLocalizedString(@"立即投票", nil) forState:UIControlStateNormal];
    UIButton *rightBarButton=[[UIButton alloc]init];
    [rightBarButton setTitle:NSLocalizedString(@"投票规则", nil) forState:UIControlStateNormal];
    [rightBarButton addTarget:self action:@selector(votingRulesEvent:) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.titleLabel.font=[UIFont systemFontOfSize:13];
    UIBarButtonItem*rightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem= rightItem;
   
    
    UIView *mainView =[self mainWindow];
    [mainView addSubview:self.votingRulesV];
    
    [self.votingRulesV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
    [self.view addSubview:self.votingListV];
    [self.votingListV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.myVoteButton.mas_top).offset(0);
        make.top.equalTo(self.view).offset(10);
    }];
    [self getNetCoinPointArray];
        if ([self.typeString isEqualToString:@"Registered"]){
            self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
            self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
        }else if([self.typeString isEqualToString:@"Canceled"]){
self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
            self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
        }else if([self.typeString isEqualToString:@"Unregistered"]){
            self.tagVoteRuleLab.text=NSLocalizedString(@"报名参选", nil);
            self.found_vote_rule.image=[UIImage imageNamed:@"vote_attend"];
    
        }else if ([self.typeString isEqualToString:@"ReturnDeposit"]){
            self.votingRulesButton.hidden=YES;
            self.tagVoteRuleLab.hidden=YES;
            self.found_vote_rule.hidden=YES;
        }

//    if ([self.typeString isEqualToString:@"0"]) {
////        @"Unregistered"
//
//    }else if ([self.typeString isEqualToString:@"1"]){
////        @"Registered"
//          @"ReturnDeposit"
//        self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
//        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
//
//    }else if ([self.typeString isEqualToString:@"2"]){
////        @"Canceled"
//      self.votingRulesButton.hidden=YES;
//        self.tagVoteRuleLab.hidden=YES;
//        self.found_vote_rule.hidden=YES;
//
//    }else if ([self.typeString isEqualToString:@"4"]){
////        @"ReturnDeposit"
//        self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
//        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
//
//    }

}
- (IBAction)NodeRegisteredState:(id)sender {
    if ([self.typeString isEqualToString:@"Registered"]){
        FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.typeString isEqualToString:@"Unregistered"]){
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
        
    }else if ([self.typeString isEqualToString:@"ReturnDeposit"]){
        DrawBackVoteMoneyVC *vc=[[DrawBackVoteMoneyVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self defultWhite];
    
}
-(void)setTypeString:(NSString *)typeString{
    _typeString=typeString;
    
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(void)loadAllImageInfo:(NSMutableArray*)allListInfoArray{
  
    
    dispatch_group_t group =  dispatch_group_create();
   
    for (int i=0; i<allListInfoArray.count; i++) {
        FLCoinPointInfoModel *model =allListInfoArray[i];
        
        if (model.url.length>0) {
            dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                model.iconImageUrl= [[FLTools share] getImageViewURLWithURL:model.url];
                allListInfoArray[i]=model;
            });
           
        }
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
         [self.votingListV setDataSource: allListInfoArray];
    });

    
    
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{

     [self UpdataLocalOwerlist];
    });

    
}
-(void)getNetCoinPointArray{
    
    [HttpUrl NetPOSTHost:Http_IP url:@"/api/dposnoderpc/check/listproducer" header:@{} body:@{@"moreInfo":@"1"} showHUD:NO WithSuccessBlock:^(id data) {
        NSDictionary *param = data[@"data"];
        NSArray *dataArray =[NSArray modelArrayWithClass:FLCoinPointInfoModel.class json:param[@"result"][@"producers"]];
        
        self.dataSource= [NSMutableArray arrayWithArray:dataArray];
        
        self.votingListV.dataSource = self.dataSource;
        self.votingListV.lab1.text = [NSString stringWithFormat:@"%.5f %@" ,[param[@"result"][@"totalvoterate"] floatValue]*100,@"%"];
        self.votingListV.lab3.text =[NSString stringWithFormat:@"%ld", (long)[param[@"result"][@"totalvotes"] integerValue]];
        
        
        [self loadAllImageInfo:[NSMutableArray arrayWithArray:dataArray]];
        
    } WithFailBlock:^(id data) {
        
    }];
}


-(void)UpdataLocalOwerlist{
    NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    FMDBWalletModel *FMDBmodel =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
    NSArray *localStore  = [[NSMutableArray alloc]initWithArray: [[FLNotePointDBManager defultWithWalletID:FMDBmodel.walletID]allRecord]];
    
    for (int i= 0; i<localStore.count; i++) {
        FLCoinPointInfoModel *model = localStore[i];
        
        FLCoinPointInfoModel *curentmodel = nil ;
        BOOL ret = NO;
        for (FLCoinPointInfoModel*dataModel in self.dataSource) {
           ret =  [dataModel.ownerpublickey isEqualToString:model.ownerpublickey];
            if (ret) {
                curentmodel = model;
            }
        }
        NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
      FMDBWalletModel *FMDBmodel =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
        if (curentmodel){
            [[FLNotePointDBManager defultWithWalletID:FMDBmodel.walletID]updateRecord:model];
            continue;
        }else{
            [[FLNotePointDBManager defultWithWalletID:FMDBmodel.walletID]delectRecord:model];
        }
    }
}
-(HMWvotingRulesView *)votingRulesV{
    if (!_votingRulesV) {
        _votingRulesV =[[HMWvotingRulesView alloc]init];
        _votingRulesV.delegate=self;
        _votingRulesV.alpha=0.f;
    }
    return _votingRulesV;
}
-(HMWVotingListView *)votingListV{
    if (!_votingListV) {
        _votingListV =[[HMWVotingListView alloc]init];
        _votingListV.delegate=self;
        
        
    }
    return _votingListV;
}
- (IBAction)myVoteEvent:(id)sender {
    
    HMWMyVoteViewController * vc = [[HMWMyVoteViewController alloc]init];
    vc.listData = self.dataSource;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)votingRulesEvent:(id)sender {
    NSURL *url=[NSURL URLWithString:NSLocalizedString(@"rules", nil)];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=10.0) {
        
        [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL success) {
        }];
    }else{
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}
- (IBAction)myVoteButton:(id)sender {
    HMWtheCandidateListViewController * vc = [[HMWtheCandidateListViewController alloc]init];
    vc.persent = self.votingListV.lab1.text ;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)closeViewDele{
    
    self.votingRulesV.alpha=0.f;
}
#pragma mark ---------HMWVotingListViewDelegate----------

- (void)selectedVotingListWithIndex:(NSInteger)index {
    HMWnodeInformationViewController *nodeInformationVC=[[HMWnodeInformationViewController alloc]init];
    nodeInformationVC.model = self.dataSource[index];
    nodeInformationVC.Ranking=index+1;
      [self.navigationController pushViewController:nodeInformationVC animated:YES];
    
}
#pragma mark -------------------
- (void)hasSignUp{
    self.hasSing=YES;
    
}





@end
