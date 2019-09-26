//
//  HMWCRCommitteeMemberListViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/8/27.
//

#import "HMWCRCommitteeMemberListViewController.h"
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
#import "HWMCRRegisteredViewController.h"
#import "HWMCRCCommitteeElectionListViewController.h"
#import "HWMCRListModel.h"
#import "ELWalletManager.h"

@interface HMWCRCommitteeMemberListViewController ()<HMWvotingRulesViewDelegate,HMWVotingListViewDelegate,HMWsignUpForViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tagVoteRuleLab;

@property (weak, nonatomic) IBOutlet UIView *EditSelectionView;
@property (weak, nonatomic) IBOutlet UILabel *tagMyVotedLab;
@property (weak, nonatomic) IBOutlet UIButton *all_selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *all_selectedTextLabel;

/*
 *<# #>
 */
@property(strong,nonatomic)HMWVotingListView *votingListV;
@property (weak, nonatomic) IBOutlet UIButton *toVoteButton;

@property (weak, nonatomic) IBOutlet UIButton *votingRulesButton;
@property (weak, nonatomic) IBOutlet UIButton *myVoteButton;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger type;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL hasSing;
@property (weak, nonatomic) IBOutlet UIImageView *found_vote_rule;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWvotingRulesView *votingRulesV;
@property (weak, nonatomic) IBOutlet UIButton *JoinTheCandidateListButton;
@property (weak, nonatomic) IBOutlet UIImageView *all_selectedImageView;
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *wallet;

@end

@implementation HMWCRCommitteeMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=NSLocalizedString(@"CRC委员选举", nil);
    [self setBackgroundImg:@""];
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
    [self getWalletType];
    self.all_selectedTextLabel.text=NSLocalizedString(@"全选", nil);
}
-(void)getWalletType{
    
    NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    FMDBWalletModel *model =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
    
   self.wallet =[[FLWallet alloc]init];
    self.wallet.masterWalletID =model.walletID;
    self.wallet.walletName     =model.walletName;
    self.wallet.walletAddress  = model.walletAddress;
    self.wallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    self.wallet.TypeW  = model.TypeW;
     invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID] callbackId: self.wallet.masterWalletID className:@"Wallet" methodName:@"getAllSubWallets"];
    PluginResult * resultBase =[[ELWalletManager share]getMasterWalletBasicInfo:mommand];
    NSString *statusBase=[NSString stringWithFormat:@"%@",resultBase.status];
    NSDictionary *baseDic=[[NSDictionary alloc]init];
    if ([statusBase isEqualToString:@"1"] ) {
        baseDic=[[FLTools share]dictionaryWithJsonString:resultBase.message[@"success"]];
        NSString *Readonly=[NSString stringWithFormat:@"%@",baseDic[@"Readonly"]];
        if ([Readonly isEqualToString:@"0"]) {
            if ([baseDic[@"M"] integerValue]==1) {
               self.wallet.TypeW=0;
            }else{
            self.votingRulesButton.hidden=YES;
            self.tagVoteRuleLab.hidden=YES;
            self.found_vote_rule.hidden=YES;
             self.wallet.TypeW=2;
            }
        }else{
            self.votingRulesButton.hidden=YES;
            self.tagVoteRuleLab.hidden=YES;
            self.found_vote_rule.hidden=YES;
            if ([baseDic[@"M"] integerValue]==1) {
          self.wallet.TypeW=1;
            }else{
         self.wallet.TypeW=3;
            }
        }

      
    }
}
- (IBAction)NodeRegisteredState:(id)sender {
    HWMCRRegisteredViewController *CRRegisteredVC=[[HWMCRRegisteredViewController alloc]init];
    [self.navigationController pushViewController:CRRegisteredVC animated:YES];
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
             HWMCRRegisteredViewController *vc=[[ HWMCRRegisteredViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if ([self.typeString isEqualToString:@"Canceled"]){
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
         NSString *httpIP=[[FLTools share]http_IpFast];
         HWMCRListModel *model =allListInfoArray[i];
         
         if (model.url.length>0) {
             dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 model.url= [[FLTools share] getImageViewURLWithURL:model.url];
                 
                 if (model.url.length>0) {
                     [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/getimage" header:@{} body:@{@"imageurl":model.url} showHUD:NO WithSuccessBlock:^(id data) {
                                                         NSString *param = data[@"data"];
                                                         model.url=[NSString stringWithFormat:@"%@%@",httpIP,param];
                                                        allListInfoArray[i]=model;
                         
                                                     } WithFailBlock:^(id data) {
                                                         
                                                     }];
                 }
             });
            
         }
     }
     
     dispatch_group_notify(group, dispatch_get_main_queue(), ^{
          [self.votingListV setDataSource: allListInfoArray];
     });
    

    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.votingListV setDataSource: allListInfoArray];
    });
    
    
    
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [self UpdataLocalOwerlist];
    });
    
    
}
-(void)getNetCoinPointArray{
  
    NSString *httpIP=[[FLTools share]http_IpFast];
    [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/listcrcandidates" header:@{} body:@{@"state":@"all"} showHUD:NO WithSuccessBlock:^(id data) {
        NSDictionary *param = data[@"data"];
        NSArray *dataArray =[NSArray modelArrayWithClass:HWMCRListModel.class json:param[@"result"][@"crcandidatesinfo"]];
        self.dataSource= [NSMutableArray arrayWithArray:dataArray];
        self.votingListV.dataSource = self.dataSource;

        
        
        [self loadAllImageInfo:[NSMutableArray arrayWithArray:dataArray]];
        
    } WithFailBlock:^(id data) {
        
    }];
}


-(void)UpdataLocalOwerlist{
    NSArray *localStore  = [[NSMutableArray alloc]initWithArray: [[FLNotePointDBManager defultWithWalletID:self.wallet.walletID] allRecord]];
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
        if (curentmodel){
            [[FLNotePointDBManager defultWithWalletID:self.wallet.walletID]updateRecord:model];
            continue;
        }else{
            [[FLNotePointDBManager defultWithWalletID:self.wallet.walletID]delectRecord:model];
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
        _votingListV.type=CRType;
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
   HWMCRCCommitteeElectionListViewController * vc = [[HWMCRCCommitteeElectionListViewController alloc]init];
    vc.persent = self.votingListV.lab1.text ;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)closeViewDele{
    self.votingRulesV.alpha=0.f;
}
#pragma mark ---------HMWVotingListViewDelegate----------
- (void)selectedVotingListWithIndex:(NSInteger)index {
    HMWnodeInformationViewController *nodeInformationVC=[[HMWnodeInformationViewController alloc]init];
        nodeInformationVC.type=CRInformationType;
    nodeInformationVC.model = self.dataSource[index];
    nodeInformationVC.Ranking=index+1;
    [self.navigationController pushViewController:nodeInformationVC animated:YES];
}
-(void)VotingListisEdite:(BOOL)edite{
    if (edite==YES) {
        self.EditSelectionView.alpha=1.f;
        self.JoinTheCandidateListButton.alpha=1.f;
    }else{
        self.EditSelectionView.alpha=0.f;
        self.JoinTheCandidateListButton.alpha=0.f;
    }
    
    
}
#pragma mark -------------------
- (void)hasSignUp{
    self.hasSing=YES;
}
//all_selected

- (IBAction)all_selectedEvent:(id)sender {
    self.all_selectedButton.selected=!self.all_selectedButton.selected;
    if (self.all_selectedButton.selected){
        self.all_selectedImageView.image=[UIImage imageNamed:@"all_selected"];
    }else{
        self.all_selectedImageView.image=[UIImage imageNamed:@"found_vote_border"];
    }
       [self.votingListV selectAllListWithIsSelect:self.all_selectedButton.selected];
}
- (IBAction)JoinTheCandidateListEvent:(id)sender {
}
@end
