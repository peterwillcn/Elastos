//
//  HMWfoundViewController.m
//  ELA
//
//  Created by  on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWfoundViewController.h"
#import "FLSelectSuperPointVC.h"
#import "HMWtheSuperNodeElectionViewController.h"
#import "ELWalletManager.h"
#import "IMainchainSubWallet.h"
#import "HMWtheSuperNodeElectionViewController.h"
#import "HMWCRCommitteeMemberListViewController.h"
#import "HWMCommunityProposalViewController.h"
//#import "ELACRCommitteeListViewController.h"
//#import "ELAUtils.h"
#import "ELACRCommitteeListViewController.h"
#import "ELAUtils.h"
#import "HWMSecretaryGeneralAndMembersInfo.h"

#import "ELANetwork.h"
#import "ELACommitteeInfoModel.h"
#import "YYKit.h"
#import "ELAInformationDetail.h"
#import "ELACommitteeManageViewController.h"
#import "ELAPledgeView.h"
#import "HWMDIDManager.h"
#import "ELAVotingProcessUtil.h"

@interface HMWfoundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic, strong) NSURLSessionDataTask *task;

/*
 *<# #>
 */
@property(copy,nonatomic)NSString *typeString;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL hasSing;

@end

@implementation HMWfoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self loadElectionInfo];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"社区", nil);
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YYScreenSize().width, YYScreenSize().height - TabBarBottomHeight) style:UITableViewStylePlain];
    self.table.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.table];
    self.table.dataSource =self;
    self.table.delegate = self;
    self.table.rowHeight = (AppWidth-60)/2;
    self.table.tableFooterView = [[UIView alloc] init];
    self.dataSource =[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    [self.table registerNib:[UINib nibWithNibName:@"HMWfoundTableCell" bundle:nil] forCellReuseIdentifier:@"HMWfoundTableCell"];
    [self.table reloadData];
    //xhj bug #937
//    self.table.hidden = YES;
    
    
}

#pragma mark - bug #937

// xhj bug #937
- (void)getNetworkData
{
    [[FLTools share]showLoadingView];
    ELAWeakSelf;
    _task = [ELANetwork getCommitteeInfo:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(error)
            {
                [[FLTools share]hideLoadingView];
                if(error.code == -999)
                {
                    //已取消
                }
                else
                {
                    [[FLTools share] showErrorInfo:error.localizedDescription];
                }
            }
            else
            {
                ELACommitteeInfoModel *model = data;
                [weakSelf isVoting:model.data];
            }
        });
        
    }];
}
// xhj bug #937
- (void)isVoting:(NSArray *)data
{
    if(data && data.count > 0)
    {

        for(int i = 0; i < data.count; i++)
        {
            ELACommitteeInfoModel *voteModel = [data objectAtIndex:i];
            
            if(voteModel.status && [voteModel.status isEqualToString:@"VOTING"])
            {
                self.dataSource = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", @"", nil];
                [self.table reloadData];
                [[FLTools share]hideLoadingView];
                self.table.hidden = NO;
                return;
            }
        }
    }
    self.dataSource = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    [self.table reloadData];
    
    [[FLTools share]hideLoadingView];
    self.table.hidden = NO;
    
}
#pragma mark -

-(void)loadElectionInfo{
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    
    nlohmann::json info = mainchainSubWallet->GetRegisteredProducerInfo();
    NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSString *Status = param[@"Status"];
    self.typeString =Status;
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //xhj bug #937
    if(_task)
    {
        [_task cancel];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem=nil;
    [self.navigationController setNavigationBarHidden:NO];
  //  self.table.hidden = YES;
    //xhj bug #937
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getNetworkData];
    });
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //xxl UI
    HMWfoundTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMWfoundTableCell"];
    if (indexPath.row==1) {
        cell.img.image = [UIImage imageNamed:NSLocalizedString(@"found_card_proposal", nil)];
    }else if(indexPath.row==2) {
        cell.img.image = [UIImage imageNamed:NSLocalizedString(@"found_card_committee", nil)];
    }
    else if(indexPath.row==3){
        cell.img.image = [UIImage imageNamed:NSLocalizedString(@"found_card_crcvote", nil)];
    }else if(indexPath.row==0){
        

        cell.img.image = [UIImage imageNamed:NSLocalizedString(@"found_card_vote", nil)];
    }
    
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        ELWalletManager *manager   =  [ELWalletManager share];
        IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
        nlohmann::json info = mainchainSubWallet->GetRegisteredProducerInfo();
        NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
        NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSString *Status = param[@"Status"];
        self.typeString =Status;
        HMWtheSuperNodeElectionViewController*theSuperNodeElectionVC=[[HMWtheSuperNodeElectionViewController alloc]init];
        theSuperNodeElectionVC.typeString=Status;
        theSuperNodeElectionVC.NodePublicKey= param[@"Info"][@"NodePublicKey"];
        theSuperNodeElectionVC.nodeName= param[@"Info"][@"NickName"];
        [self.navigationController pushViewController:theSuperNodeElectionVC animated:YES];
    }
    if (indexPath.row==1) {
        HWMCommunityProposalViewController *CommunityProposalVC=[[HWMCommunityProposalViewController alloc]init];
        [self.navigationController pushViewController:CommunityProposalVC animated:YES];
    }else if (indexPath.row == 2)
    {
        HWMSecretaryGeneralAndMembersDetailsModel *model = [[HWMSecretaryGeneralAndMembersInfo shareTools] getDetailsModel];
        if(model == nil)
        {
            FLWallet *wallet = [ELWalletManager share].currentWallet;
            NSString *did = [[HWMDIDManager shareDIDManager]hasDIDWithPWD:@"" withDIDString:@"" WithPrivatekeyString:@"" WithmastWalletID:wallet.masterWalletID needCreatDIDString:NO];
            
            [[FLTools share]showLoadingView];
            [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadSecretaryGeneralAndMembersDetailsWithID:@"" withDIDString:did withComplete:^(id  _Nonnull data) {
                ELAInformationDetail *detailModel = [ELAInformationDetail mj_objectWithKeyValues:data];
                [ELAVotingProcessUtil shareVotingProcess].detailModel = detailModel;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[FLTools share]hideLoadingView];
//                    if(![self toELACommitteeManageViewController:detailModel])
//                    {
                        ELACRCommitteeListViewController *vc = [[ELACRCommitteeListViewController alloc] init];
                        vc.title = ELALocalizedString(@"CR委员会列表");
                        [self.navigationController pushViewController:vc animated:YES];
//                    }
                });
            }];
        }
        else
        {
            NSDictionary*dic = [model mj_keyValues];
            ELAInformationDetail *detailModel = [ELAInformationDetail mj_objectWithKeyValues:dic];
            [ELAVotingProcessUtil shareVotingProcess].detailModel = detailModel;
//            if(![self toELACommitteeManageViewController:detailModel])
//            {
                ELACRCommitteeListViewController *vc = [[ELACRCommitteeListViewController alloc] init];
                vc.title = ELALocalizedString(@"CR委员会列表");
                [self.navigationController pushViewController:vc animated:YES];
//            }
        }
        
    }
    else if (indexPath.row==3){
        ELWalletManager *manager   =  [ELWalletManager share];
        IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
        nlohmann::json info = mainchainSubWallet->GetRegisteredCRInfo();
        NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
        NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSString *Status = param[@"Status"];
        self.typeString =Status;
        HMWCRCommitteeMemberListViewController *CRSignUpForVC=[[HMWCRCommitteeMemberListViewController alloc]init];
        CRSignUpForVC.typeString=self.typeString;
        CRSignUpForVC.CROwnerDID=param[@"Info"][@"CID"];
        CRSignUpForVC.BondedDID=[param[@"Info"][@"BondedDID"] intValue];
        CRSignUpForVC.CROwnerPublicKey=param[@"Info"][@"CROwnerPublicKey"];
        CRSignUpForVC.nodeName= param[@"Info"][@"NickName"];
        CRSignUpForVC.CRnewDID=param[@"Info"][@"DID"];
        [self.navigationController pushViewController:CRSignUpForVC  animated:YES];
        }
//    else if (indexPath.row == 3)
//    {
//        ELACRCommitteeListViewController *vc = [[ELACRCommitteeListViewController alloc] init];
//        vc.title = ELALocalizedString(@"CR委员会");
//        [self.navigationController pushViewController:vc animated:YES];
//    }

    
}
- (BOOL)toELACommitteeManageViewController:(ELAInformationDetail *)model
{
    if (model)
    {
        NSDictionary *dic = [model mj_keyValues];
        ELAInformationDetail *detailModel = [ELAInformationDetail mj_objectWithKeyValues:dic];
        
        if ([model.type isEqualToString:@"SecretaryGeneral"])
        {
            
        }
        else if ([model.type isEqualToString:@"CouncilMember"])
        {
            if([model.status isEqualToString:@"Returned"])//去职
            {
                [self setELACommitteeManageViewController:3 :detailModel];
               
            }
            else if([model.status isEqualToString:@"Terminated"])//任满
            {
                [self setELACommitteeManageViewController:4 :detailModel];
                
            }
            else if([model.status isEqualToString:@"Impeached"])//弹劾
            {
                [self setELACommitteeManageViewController:5 :detailModel];
                
                
            }
            //                else if([model.status isEqualToString:@"Impeached"])//解散 还未判断
            //                {
            //                    [self setELACommitteeManageViewController:6 :detailModel];
            //                    return;
            //
            //                }
            return YES;;
        }
    }
    return NO;
}
- (void)setELACommitteeManageViewController:(int)type :(ELAInformationDetail *)detailModel
{
    ELAPledgeView *_pledgeView = [[ELAPledgeView alloc] init];
    [_pledgeView showAlertView];
    _pledgeView.block = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            ELACommitteeManageViewController *vc = [[ELACommitteeManageViewController alloc] init];
            vc.infoModel = detailModel;
            vc.type = type;
            vc.title = ELALocalizedString(@"委员管理");
            [self.navigationController pushViewController:vc animated:YES];
        });
        
    };
    [_pledgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(0));
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(ScreenHeight));
        make.top.bottom.equalTo(@(0));
    }];
    if(type == 3)
    {
        _pledgeView.title = @"上届CR委员任期已满，所有委员自动卸任离职。";
    }
    else if(type == 4)
    {
        _pledgeView.title = @"上届CR委员会任期已满，所有委员自动卸任离职。";
    }
    else if(type == 5)
    {
        _pledgeView.title = @"由于对您的弹劾已通过。您的委员职务已被免职。";
    }
    else if(type == 6)
    {
        _pledgeView.title = @"上届CR委员会因故解散，所有委员自动去职。";
    }
}
@end
