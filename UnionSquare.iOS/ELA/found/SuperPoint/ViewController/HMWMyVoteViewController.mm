//
//  HMWMyVoteViewController.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWMyVoteViewController.h"
#import "HMWmyVoteStatisticsTableViewCell.h"
#import "ELWalletManager.h"
#import "FLChangeVotedTicketsVC.h"
#import "FLCoinPointInfoModel.h"
#import "HWMCRListModel.h"
#import "HWMCRCCommitteeElectionListViewController.h"
#import "HMWtheCandidateListViewController.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "FLNotePointDBManager.h"
#import "HMWFMDBManager.h"
static NSString *cellString=@"HMWmyVoteStatisticsTableViewCell";
@interface HMWMyVoteViewController ()<UITableViewDelegate,UITableViewDataSource,HWMCRCCommitteeElectionListViewControllerDelegate,HMWToDeleteTheWalletPopViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfTheWalletLabel;
@property (weak, nonatomic) IBOutlet UILabel *theWalletAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *waitingForTheImageView;
@property (weak, nonatomic) IBOutlet UIImageView *largeStateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *stateIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *votesLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteInTotalLabel;
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property (weak, nonatomic) IBOutlet UIButton *changeVotesButton;
@property (weak, nonatomic) IBOutlet UIView *changeVotesBGView;
@property(nonatomic,strong)UILabel  *placeHolderLab;

@property (weak, nonatomic) IBOutlet UILabel *lastVoteLab;

@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)HMWToDeleteTheWalletPopView *votePopView;
@end

@implementation HMWMyVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [[HMWCommView share]makeBordersWithView:self.changeVotesButton];
    [[HMWCommView share]makeBordersWithView:self.BGView];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"我的投票", nil) ;
    
    self.lastVoteLab.text =NSLocalizedString(@"上次投票记录", nil);
    [self.changeVotesButton setTitle:NSLocalizedString(@"重新投票", nil) forState:UIControlStateNormal];
    [self makeView];
    FLWallet *waller = [ELWalletManager share].currentWallet;
    IMainchainSubWallet *subWallet = [[ELWalletManager share]getWalletELASubWallet:waller.masterWalletID];
    String balanceSt = subWallet->GetBalance();
    NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
    NSInteger balance=[balanceString integerValue];
    self.nameOfTheWalletLabel.text = waller.walletName;
    self.votesLabel.text = [NSLocalizedString(@"表决票权：", nil) stringByAppendingString:@(balance/unitNumber).stringValue];
}
-(void)getCRData{
    FLWallet *waller = [ELWalletManager share].currentWallet;
    IMainchainSubWallet *subWallet = [[ELWalletManager share]getWalletELASubWallet:waller.masterWalletID];
    Json cArray = subWallet->GetVotedCRList();
    NSString *dataStr = [NSString stringWithUTF8String:cArray.dump().c_str()];
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *showlistdata = [NSMutableArray array];
    NSMutableArray *NActive = [NSMutableArray array];
    NSInteger total =0;
    for (int i=0; i<self.listData.count; i++) {
        HWMCRListModel *model = self.listData[i];
        for (int j = 0;j<param.allKeys.count; j++) {
            
            NSString *itemKey = param.allKeys[j];
            if ([model.did isEqualToString:itemKey]) {
                double sinceVd=[param[itemKey] doubleValue];
                model.SinceVotes = @(sinceVd/unitNumber).stringValue;
                
                total+=[param[itemKey] integerValue];
                if ([model.state isEqualToString:@"Active"]) {
                    [showlistdata addObject:model];
                }else{
                    [NActive addObject:model];
                }
                
                
            }
        }
        
    }
    
    
    
    
    if (total==0) {
        self.voteInTotalLabel.alpha=0.f;
    }else{
        self.voteInTotalLabel.text =[NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"共",nil),[[FLTools share]CRVotingTheAverageDistribution:[NSString stringWithFormat:@"%ld",(long)total] withCRMermVoting:[NSString stringWithFormat:@"%d",unitNumber] ],NSLocalizedString(@"票",nil)] ;
    }
    
    self.stateIconImageView.image=[UIImage imageNamed:@"my_vote_unlocked"];
    [showlistdata addObjectsFromArray:NActive];
    self.dataSource = showlistdata;
    if (self.dataSource.count==0) {
        //           self.changeVotesButton.alpha=0.f;
        self.largeStateImageView.image=[UIImage imageNamed:@"found_my_go_on"];
    }else{
        self.changeVotesButton.alpha=1.f;
        self.largeStateImageView.image=[UIImage imageNamed:@"found_vote_lock"];
    }
    
    [self.baseTableView reloadData];
    self.placeHolderLab.hidden  = self.dataSource.count==0? NO: YES;
    
    
}
-(void)getDataFromData{
    FLWallet *waller = [ELWalletManager share].currentWallet;
    IMainchainSubWallet *subWallet = [[ELWalletManager share]getWalletELASubWallet:waller.masterWalletID];
    Json cArray = subWallet->GetVotedProducerList();
    NSString *dataStr = [NSString stringWithUTF8String:cArray.dump().c_str()];
    
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *showlistdata = [NSMutableArray array];
    NSMutableArray *NActive=[NSMutableArray array];
    NSInteger total =0;
    for (int i=0; i<self.listData.count; i++) {
        FLCoinPointInfoModel *model = self.listData[i];
        
        for (int j = 0;j<param.allKeys.count; j++) {
            NSString *itemKey = param.allKeys[j];
            if ([model.ownerpublickey isEqualToString:itemKey]) {
                model.hadVotedNumber = [param[itemKey] integerValue];
                if ([model.state isEqualToString:@"Active"]) {
                    [showlistdata addObject:model];
                }else{
                    [NActive addObject:model];
                }
                
                total=[param[itemKey] integerValue];
            }
        }
        
    }
    [showlistdata addObjectsFromArray:NActive];
    self.voteInTotalLabel.text = @(total/unitNumber).stringValue;
    self.dataSource = showlistdata;
    self.stateIconImageView.image=[UIImage imageNamed:@"my_vote_unlocked"];
    if (self.dataSource.count==0) {
        self.changeVotesButton.alpha=0.f;
        self.largeStateImageView.image=[UIImage imageNamed:@"found_my_go_on"];
    }else{
        self.changeVotesButton.alpha=1.f;
        self.largeStateImageView.image=[UIImage imageNamed:@"found_vote_lock"];
    }
    [self.baseTableView reloadData];
    self.placeHolderLab.hidden  = self.dataSource.count==0? NO: YES;
    
}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    self.baseTableView.rowHeight=60;
    self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.baseTableView.bounces = NO;
    [self.baseTableView addSubview:self.placeHolderLab];
    [self.placeHolderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.baseTableView);
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HMWmyVoteStatisticsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    if (self.VoteType==MyVoteNodeElectioType) {
        cell.leftwidthCon.constant=150;
        FLCoinPointInfoModel *model = self.dataSource[indexPath.row];
        if ([model.state isEqualToString:@"Active"]) {
            cell.leftLab.text = model.nickname;
            cell.rightLab.text =[NSString stringWithFormat:@"NO.%ld",model.index+1];
        }else{
            cell.rightLab.text=@"--";
            cell.leftLab.text=NSLocalizedString(@"候选节点已经失效", nil);
            cell.leftLab.textColor=RGBA(255,255,255,0.5);
            cell.rightLab.textColor=RGBA(255,255,255,0.5);
        }
        
        
    }else if (self.VoteType==MyVoteCRType){
        HWMCRListModel *model = self.dataSource[indexPath.row];
        if ([model.state isEqualToString:@"Active"]) {
            cell.leftLab.text =[NSString stringWithFormat:@"NO.%@",model.index];
            cell.middleLabel.text=model.nickname;
            NSInteger number=[model.SinceVotes intValue];
            if (number<1) {
                cell.rightLab.text =[NSString stringWithFormat:@"%@ ",@"<1",NSLocalizedString(@"票", nil)];
            }else{
                cell.rightLab.text =[NSString stringWithFormat:@"%d %@",[model.SinceVotes intValue],NSLocalizedString(@"票", nil)];
                
            }
            cell.leftLab.textColor=[UIColor whiteColor];
            cell.middleLabel.textColor=[UIColor whiteColor];
        }else{
            
            cell.leftLab.text=@"--";
            cell.middleLabel.text=NSLocalizedString(@"候选节点已经失效", nil);
            cell.leftLab.textColor=RGBA(255,255,255,0.5);
            cell.middleLabel.textColor=RGBA(255,255,255,0.5);
            cell.rightLab.text =[NSString stringWithFormat:@"%d %@",[model.SinceVotes intValue],NSLocalizedString(@"票", nil)];
        }
    }
    
    return cell;
    
}
-(UILabel *)placeHolderLab
{
    if (!_placeHolderLab) {
        _placeHolderLab = [UIView FLLab_TextColor:[UIColor grayColor] Fort:18];
        _placeHolderLab.text =NSLocalizedString(@"暂无投票记录", nil) ;
        _placeHolderLab.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolderLab;
}
- (IBAction)changeVote:(id)sender {
//    NSMutableArray *loacaAarray=[[NSMutableArray alloc]init];
//    FLWallet *waller = [ELWalletManager share].currentWallet;
//    if (self.VoteType==MyVoteNodeElectioType) {
//        [loacaAarray addObjectsFromArray: [[FLNotePointDBManager defultWithWalletID:waller.masterWalletID] allRecord]];
//    }else if (self.VoteType==MyVoteCRType){
//    [loacaAarray addObjectsFromArray: [[HMWFMDBManager sharedManagerType:CRListType] allSelectCRWithWallID:waller.masterWalletID ]];
//    }
//    if (loacaAarray.count>0) {
//        UIView *mainView =[self mainWindow];
//        [mainView addSubview:self.votePopView];
//        [self.votePopView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.equalTo(mainView);
//        }];
//    }else{
//        [self needUpdataLocaInfo];
//    }
    [self CancelEvent];
    
}
-(void)setVoteType:(MyVoteVotingListType)VoteType{
    _VoteType=VoteType;
    
}
-(void)setActivData:(NSArray *)ActivData{
    _ActivData=ActivData;
    
}
-(void)setTotalvotes:(NSString *)totalvotes{
    _totalvotes=totalvotes;
}
-(void)setPersent:(NSString *)persent{
    _persent=persent;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.VoteType==MyVoteNodeElectioType) {
        [self getDataFromData];
    }else if (self.VoteType==MyVoteCRType){
        [self getCRData];
    }
}
-(void)needUpdataSta{
    if (self.delegate){
        [self.delegate updateDataSource];
    }
}

-(HMWToDeleteTheWalletPopView *)votePopView{
    if (!_votePopView) {
        _votePopView=[[HMWToDeleteTheWalletPopView alloc]init];
        _votePopView.delegate=self;
        _votePopView.deleteType=CoverCommitteeMembersListType;
    }
    return _votePopView;
}
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    [self needUpdataLocaInfo];
}
-(void)CancelEvent{
    [self toCancelOrCloseDelegate];
    if (self.VoteType==MyVoteNodeElectioType) {
        HMWtheCandidateListViewController * vc = [[HMWtheCandidateListViewController alloc]init];
        vc.persent = self.persent ;
        vc.lastTimeArray=self.listData;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.VoteType==MyVoteCRType){
        HWMCRCCommitteeElectionListViewController *vc=[[HWMCRCCommitteeElectionListViewController alloc]init];
        vc.lastArray=self.listData;
        vc.delegate=self;
        vc.totalvotes=self.totalvotes;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void)toCancelOrCloseDelegate{
    [self.votePopView removeFromSuperview];
    self.votePopView=nil;
}
-(void)needUpdataLocaInfo{// 需要更新本地数据
    
    [self showLoading];
    FLWallet *waller = [ELWalletManager share].currentWallet;
    if (self.VoteType==MyVoteNodeElectioType) {
        [[FLNotePointDBManager defultWithWalletID:waller.masterWalletID]delectAllWithWalletID];
        for (FLCoinPointInfoModel *model in self.dataSource) {
            if ([model.state isEqualToString:@"Active"]) {
                [[FLNotePointDBManager defultWithWalletID:waller.masterWalletID]addRecord:model];
            }
            
        }
        
    }else if (self.VoteType==MyVoteCRType){
        for (HWMCRListModel *model in self.dataSource) {
            [[HMWFMDBManager sharedManagerType:CRListType] delectAllCRWithWallID:waller.masterWalletID];
            if ([model.state isEqualToString:@"Active"]) {
                [[HMWFMDBManager sharedManagerType:CRListType] addCR:model withWallID:waller.masterWalletID];
            }
            
        }
        
    }
    [self hiddLoading];
    [self CancelEvent];
}
@end
