//
//  HMWCRCommitteeMemberListViewController.m
//  elastos wallet
//
//  Created by  on 2019/8/27.
//

#import "HMWCRCommitteeMemberListViewController.h"
#import "HMWVotingListView.h"
#import "HMWvotingRulesView.h"
#import "HMWnodeInformationViewController.h"
#import "HMWtheCandidateListViewController.h"
#import "HMWMyVoteViewController.h"
#import "FLNotePointDBManager.h"
#import "DC_DealTextViewController.h"
#import "FLManageSelectPointNodeInformationVC.h"
#import "HMWFMDBManager.h"
#import "DrawBackVoteMoneyVC.h"
#import "HWMCRRegisteredViewController.h"
#import "HWMCRCCommitteeElectionListViewController.h"
#import "HWMCRListModel.h"
#import "ELWalletManager.h"
#import "HWMCRCommitteeForAgreementView.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HMWAddTheCurrencyListViewController.h"
#import "HWMDIDManager.h"
#import "HWMCreateDIDViewController.h"
#import "HWMDIDManager.h"
#import "HWMDIDInfoModel.h"


@interface HMWCRCommitteeMemberListViewController ()<HMWvotingRulesViewDelegate,HMWVotingListViewDelegate,HMWnodeInformationViewControllerDelegate,HWMCRCommitteeForAgreementViewDelegate,HMWToDeleteTheWalletPopViewDelegate,HMWAddTheCurrencyListViewControllerDelegate,HWMCRCCommitteeElectionListViewControllerDelegate,HMWMyVoteViewControllerDeleagte>
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
@property(nonatomic,strong) NSMutableArray *memberListDataSource;
@property(nonatomic,assign) NSInteger type;
/*
 *<# #>
 */
@property(assign,nonatomic) BOOL hasSing;
@property (weak, nonatomic) IBOutlet UIImageView *found_vote_rule;
/*
 *<# #>
 */
@property(strong,nonatomic) HMWvotingRulesView *votingRulesV;
@property (weak, nonatomic) IBOutlet UIButton *JoinTheCandidateListButton;
@property (weak, nonatomic) IBOutlet UIImageView *all_selectedImageView;
/*
 *<# #>
 */
@property(strong,nonatomic) FLWallet *wallet;
@property(nonatomic,assign) BOOL needFind;
/*
 *<# #>
 */
@property(strong,nonatomic) HWMCRCommitteeForAgreementView *CRCommitteeForAgreementV;

/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *openIDChainView;
@property(nonatomic,assign) BOOL isOpen;

@property(nonatomic,copy) NSString* totalvotes;
@property(nonatomic,strong)NSMutableArray *ActiveArray;
@property(nonatomic,strong)HWMCRListModel *selfModel;

@end

@implementation HMWCRCommitteeMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.selfindex=-1;
    self.title=NSLocalizedString(@"CR委员选举", nil);
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
    //    if ([self.typeString isEqualToString:@"Registered"]){
    //        self.needFind=YES;
    //    self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
    //        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
    //    }else if([self.typeString isEqualToString:@"Canceled"]){
    //    self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
    //        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
    //    }else if([self.typeString isEqualToString:@"Unregistered"]){
    self.tagVoteRuleLab.text=NSLocalizedString(@"报名参选", nil);
    self.found_vote_rule.image=[UIImage imageNamed:@"vote_attend"];
    //    }else if ([self.typeString isEqualToString:@"ReturnDeposit"]){
    //        self.votingRulesButton.hidden=YES;
    //        self.tagVoteRuleLab.hidden=YES;
    //        self.found_vote_rule.hidden=YES;
    //    }
    [self.JoinTheCandidateListButton setTitle:NSLocalizedString(@"批量加入候选列表", nil) forState:UIControlStateNormal];
    [self getWalletType];
    self.isOpen=NO;
    self.all_selectedTextLabel.text=NSLocalizedString(@"全选", nil);
    [self needOpen];
}
-(void)needOpen{
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID] callbackId:self.wallet.masterWalletID className:@"Wallet" methodName:@"getAllSubWallets"];
    PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
        NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
        if (array.count>1) {
            self.isOpen=YES;
        }
    }
    
    
}
-(HWMCRCommitteeForAgreementView *)CRCommitteeForAgreementV{
    if (!_CRCommitteeForAgreementV) {
        _CRCommitteeForAgreementV=[[HWMCRCommitteeForAgreementView alloc]init];
        _CRCommitteeForAgreementV.delegate=self;
    }
    return _CRCommitteeForAgreementV;
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
    self.wallet.didString=model.didString;
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
    
    if ([self.typeString isEqualToString:@"Registered"]){
        
        if (self.isOpen) {
            FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
            vc.currentWallet=self.wallet;
            vc.CRTypeString=@"CR";
            
            vc.CRModel=self.selfModel;
            vc.lastArray=self.ActiveArray;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIView *mainView =[self mainWindow];
            self.openIDChainView.deleteType=openIDChainType;
            [mainView addSubview:self.openIDChainView];
            [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(mainView);
            }];
        }
    }else if ([self.typeString isEqualToString:@"Unregistered"]){
        
        if ([self UnregisteredAndTimeExpired]==NO) {
            return;
        }
        
        if (self.type ==1){
            FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
            vc.currentWallet=self.wallet;
            vc.CRModel=self.selfModel;
            vc.lastArray=self.ActiveArray;
            vc.CRTypeString=@"CR";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            if (self.hasSing) {
                
                [[FLTools share]showErrorInfo:NSLocalizedString(@"已参选", nil) ];
                return;
            }
            UIView *mainView =[self mainWindow];
            [mainView addSubview:self.CRCommitteeForAgreementV];
            [self.CRCommitteeForAgreementV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(mainView);
            }];
        }
        
    }else if ([self.typeString isEqualToString:@"Canceled"]){
        if (self.isOpen) {
            DrawBackVoteMoneyVC *vc=[[DrawBackVoteMoneyVC alloc]init];
            vc.CRTypeString=@"CRString";
            vc.CRModel=self.selfModel;
            vc.nodeName=self.nodeName;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIView *mainView =[self mainWindow];
            self.openIDChainView.deleteType=openIDChainType;
            [mainView addSubview:self.openIDChainView];
            [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(mainView);
            }];
        }
    }else if ([self.typeString isEqualToString:@"Pending"]){
        if (self.isOpen) {
            FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
            vc.currentWallet=self.wallet;
            vc.CRTypeString=@"CR";
            
            vc.CRModel=self.selfModel;
            vc.lastArray=self.ActiveArray;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIView *mainView =[self mainWindow];
            self.openIDChainView.deleteType=openIDChainType;
            [mainView addSubview:self.openIDChainView];
            [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(mainView);
            }];
        }
    }else{
        if (self.type ==1) {
            FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
            vc.currentWallet=self.wallet;
            vc.CRModel=self.selfModel;
            vc.lastArray=self.ActiveArray;
            vc.CRTypeString=@"CR";
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            if (self.hasSing) {
                
                [[FLTools share]showErrorInfo:NSLocalizedString(@"已参选", nil) ];
                return;
            }
            UIView *mainView =[self mainWindow];
            [mainView addSubview:self.CRCommitteeForAgreementV];
            [self.CRCommitteeForAgreementV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(mainView);
            }];
        }
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self defultWhite];
}
-(void)setTypeString:(NSString *)typeString{
    _typeString=typeString;
}
-(NSMutableArray *)memberListDataSource{
    if (!_memberListDataSource) {
        _memberListDataSource =[[NSMutableArray alloc]init];
    }
    return _memberListDataSource;
}
-(void)loadAllImageInfo:(NSMutableArray*)allListInfoArray{
    for (int i=0; i<self.ActiveArray.count; i++) {
        NSString *httpIP=[[FLTools share]http_IpFast];
        HWMCRListModel *model =self.ActiveArray[i];
        if (model.cid.length>0) {
            [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/jwtget" header:@{} body:@{@"did":[NSString stringWithFormat:@"did:elastos:%@",model.cid]} showHUD:NO WithSuccessBlock:^(id data) {
                NSString *jwtString=data[@"data"][@"jwt"];
                NSDictionary *playInfoDic=[[HWMDIDManager shareDIDManager]CRInfoDecodeWithJwtStringInfo:jwtString];
                
                HWMDIDInfoModel *didModel=  [HWMDIDInfoModel modelWithJSON:playInfoDic[@"credentialSubject"]];
                model.iconImageUrl=didModel.avatar;
                model.infoEN=didModel.introduction;
                model.infoZH=didModel.introduction;
                self.ActiveArray[i]=model;
                if (model.iconImageUrl.length>0) {
                    [self.votingListV reloadCollecWithIndex:i withModel:model];
                }
                
            } WithFailBlock:^(id data) {
                
            }];
            
        }
    }
}
-(void)getNetCoinPointArray{
    NSString *httpIP=[[FLTools share]http_IpFast];
    [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/listcrcandidates" header:@{} body:@{@"state":@"all"} showHUD:NO WithSuccessBlock:^(id data) {
        NSDictionary *param = data[@"data"];
        NSArray *dataArray =[NSArray modelArrayWithClass:HWMCRListModel.class json:param[@"result"][@"crcandidatesinfo"]];
        self.memberListDataSource= [NSMutableArray arrayWithArray:dataArray];
        self.totalvotes=[NSString stringWithFormat:@"%@",param[@"result"][@"totalvotes"]];
        [self UpdataLocalOwerlist];
    } WithFailBlock:^(id data) {
        
    }];
}
-(void)UpdataLocalOwerlist{
    [self.ActiveArray removeAllObjects];
    NSArray *localStore  = [[NSMutableArray alloc]initWithArray: [[HMWFMDBManager sharedManagerType:CRListType] allSelectCRWithWallID:self.wallet.masterWalletID]];
    
    for (int i= 0; i<self.memberListDataSource.count; i++) {
        HWMCRListModel* model=self.memberListDataSource[i];
        model.voterate=[[FLTools share]CRVotingPercentageWithAllCount:self.totalvotes withCRMermVoting:model.votes];
        HWMCRListModel *curentmodel = nil;
        model.isCellSelected=NO;
        model.isNewCellSelected=NO;
        BOOL ret = NO;
        for (int j=0; j<localStore.count; j++) {
            HWMCRListModel *dataModel = localStore[j];
            ret =  [dataModel.did isEqualToString:model.did];
            if (ret) {
                model.isCellSelected=YES;
                curentmodel=model;
            }
        }
        
        
        if ([model.did isEqualToString:self.CROwnerDID]) {
            if ([model.state isEqualToString:@"Active"]) {
                model.index=[NSString stringWithFormat:@"%lu",self.ActiveArray.count+1];
                if (curentmodel) {
                    curentmodel.index=model.index;
                }
                if (self.all_selectedButton.isSelected&&model.isCellSelected) {
                    self.all_selectedButton.selected=YES;
                }else{
                    self.all_selectedButton.selected=NO;
                }
                [self.ActiveArray insertObject:model atIndex:0];
            }
            self.selfModel=model;
            if ([[FLTools share]isBlankString:model.url]) {
                self.selfModel.url=@" ";
            }
            
        }else{
            if ([model.state isEqualToString:@"Active"]) {
                model.index=[NSString stringWithFormat:@"%lu",self.ActiveArray.count+1];
                if (curentmodel) {
                    curentmodel.index=model.index;
                }
                
                [self.ActiveArray addObject:model];
            }
            
            
        }
        if (curentmodel){
            [[HMWFMDBManager sharedManagerType:CRListType]updateSelectCR:model WithWalletID:self.wallet.walletID];
            continue;
        }else{
            [[HMWFMDBManager sharedManagerType:CRListType]delectSelectCR:model WithWalletID:self.wallet.walletID];
        }
    }
    self.votingListV.dataSource=self.ActiveArray;
    [self loadAllImageInfo:self.ActiveArray];
    
    //    if (self.selfModel) {
    [self updateInfoSelf];
    //    }
    
}
-(NSInteger)findMyDidWithIndexWithIndex:(NSInteger)index{
    //    ELWalletManager *manager   =  [ELWalletManager share];
    //    invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[manager.currentWallet.masterWalletID,@"IDChain"] callbackId:manager.currentWallet.masterWalletID className:@"wallet" methodName:@"createMasterWallet"];
    //             NSDictionary * resultBase =[[ELWalletManager share]GetCRFirstPublicKeysAndDID:cmommand];
    //    self.MemberThePublicKeyLabel.text=resultBase[@"crPublicKey"];
    
    NSString *CROwnerDID=self.CROwnerDID;
    HWMCRListModel *model=self.ActiveArray[index];
    if ([CROwnerDID isEqualToString:model.did]) {
        self.needFind=NO;
        return index;
    }
    return -1;
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
    vc.VoteType=MyVoteCRType;
    vc.listData = self.memberListDataSource;
    vc.ActivData=self.ActiveArray;
    vc.totalvotes=self.totalvotes;
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)votingRulesEvent:(id)sender {
    NSURL *url=[NSURL URLWithString:NSLocalizedString(@"CRrules", nil)];
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
    vc.persent = self.votingListV.lab1.text;
    vc.totalvotes=self.totalvotes;
    //    vc.currentWallet=self.wallet;
    vc.lastArray=self.memberListDataSource;
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)closeViewDele{
    self.votingRulesV.alpha=0.f;
}
#pragma mark ---------HMWVotingListViewDelegate----------
- (void)selectedVotingListWithIndex:(NSInteger)index {
    HWMCRListModel *CRmodel = self.ActiveArray[index];
    if (CRmodel) {
        HMWnodeInformationViewController *nodeInformationVC=[[HMWnodeInformationViewController alloc]init];
        nodeInformationVC.index=index;
        nodeInformationVC.type=CRInformationType;
        nodeInformationVC.CRmodel = self.ActiveArray[index];
        nodeInformationVC.Ranking=index+1;
        nodeInformationVC.delegate=self;
        nodeInformationVC.totalvotes=self.totalvotes;
        nodeInformationVC.lastTimeArray=self.memberListDataSource;
        [self.navigationController pushViewController:nodeInformationVC animated:YES];
    }
    
}
-(void)VotingListisEdite:(BOOL)edite{
    if (edite==YES) {
        self.EditSelectionView.alpha=1.f;
        self.JoinTheCandidateListButton.alpha=1.f;
        //        self.JoinTheCandidateListButton.imageEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
    }else{
        self.EditSelectionView.alpha=0.f;
        self.JoinTheCandidateListButton.alpha=0.f;
    }
    self.all_selectedButton.selected=NO;
}
-(void)updateDataInfo{
    //    ELWalletManager *manager   =  [ELWalletManager share];
    //
    //    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    //
    //    nlohmann::json info = mainchainSubWallet->GetRegisteredCRInfo();
    //    NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
    //    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    //    NSString *Status = param[@"Status"];
    //    self.typeString =Status;
    //    self.typeString=self.typeString;
    //    self.CROwnerDID=param[@"Info"][@"DID"];
    //    self.CROwnerPublicKey=param[@"Info"][@"CROwnerPublicKey"];
    //    self.nodeName= param[@"Info"][@"NickName"];
    [self getNetCoinPointArray];
    
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
    BOOL hasAdd;
    BOOL isAdd;
    for (int i=0; i<self.votingListV.dataSource.count; i++) {
        HWMCRListModel *model=self.votingListV.dataSource[i];
        if (model.isNewCellSelected) {
            hasAdd=YES;
            isAdd= [[HMWFMDBManager sharedManagerType:CRListType]
                    addCR:model withWallID:self.wallet.masterWalletID];
            model.isCellSelected=YES;
            self.votingListV.dataSource[i]=model;
        }
    }
    
    if (hasAdd==NO) {
        return;
    }
    if(isAdd){
        [[FLTools share]showErrorInfo:NSLocalizedString(@"添加成功",nil)];
        [self UpdataLocalOwerlist];
        [self.votingListV AddAllTheCRList];
        
    }else{
        [[FLTools share]showErrorInfo:NSLocalizedString(@"添加失败", nil)];
    }
    
}
#pragma mark ---------HMWnodeInformationViewControllerDelegate----------
-(void)needUpdateListWithIndex:(NSInteger)index{
    HWMCRListModel *model = self.ActiveArray[index];
    BOOL has =[[HMWFMDBManager sharedManagerType:CRListType]selectCRWithWalletID:self.wallet.masterWalletID andWithDID:model.did];
    if (has) {
        model.isCellSelected=YES;
        if (model.isNewCellSelected){
            model.isNewCellSelected=NO;}
    }else{
        model.isCellSelected=NO;
        if (model.isNewCellSelected){
            model.isNewCellSelected=NO;}
        
    }
    self.ActiveArray[index]=model;
    self.votingListV.dataSource=self.ActiveArray;
}
-(void)closeView{
    [self.CRCommitteeForAgreementV removeFromSuperview];
    self.CRCommitteeForAgreementV=nil;
    
}
-(void)Agreed{
    [self closeView];
    if (self.isOpen) {
        HWMCRRegisteredViewController *vc=[[ HWMCRRegisteredViewController alloc]init];
        vc.currentWallet=self.wallet;
        vc.lastArray=self.ActiveArray;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIView *mainView =[self mainWindow];
        self.openIDChainView.deleteType=openIDChainType;
        [mainView addSubview:self.openIDChainView];
        [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }
}
-(HMWToDeleteTheWalletPopView *)openIDChainView{
    if (!_openIDChainView) {
        _openIDChainView =[[HMWToDeleteTheWalletPopView alloc]init];
        _openIDChainView.delegate=self;
        
    }
    return _openIDChainView;
}
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    
    if (self.openIDChainView.deleteType==openIDChainType) {
        HMWAddTheCurrencyListViewController *AddTheCurrencyListVC=[[HMWAddTheCurrencyListViewController alloc]init];
        AddTheCurrencyListVC.wallet=self.wallet;
        AddTheCurrencyListVC.didType=@"didType";
        AddTheCurrencyListVC.delegate=self;
        [self toCancelOrCloseDelegate];
        [self.navigationController pushViewController:AddTheCurrencyListVC animated:YES];
    }else{
        
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,pwd] callbackId:self.wallet.masterWalletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
        NSString *  privatekeyString=[[ELWalletManager share]ExportxPrivateKey:mommand];
        if (privatekeyString.length==0) {
            return;
        }
        
        [[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:@"" WithPrivatekeyString:@"" WithmastWalletID:self.wallet.masterWalletID needCreatDIDString:NO];
        HWMCreateDIDViewController *CreateDIDVC=[[HWMCreateDIDViewController alloc]init];
        [self toCancelOrCloseDelegate];
        __weak __typeof__ (self) weakSelf = self;
        CreateDIDVC.walletIDBlock = ^(NSString * _Nonnull didString) {
            weakSelf.wallet.didString=didString;
        };
        [self.navigationController pushViewController:CreateDIDVC animated:YES];
    }
    
}
-(void)toCancelOrCloseDelegate{
    [self.openIDChainView removeFromSuperview];
    self.openIDChainView=nil;
}

-(void)openIDChainOfDIDAddWithWallet:(NSString*)walletID{
    if (walletID.length>0) {
        self.isOpen=YES;
        if ([self.typeString isEqualToString:@"Registered"]){
            
            FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
            vc.currentWallet=self.wallet;
            vc.CRTypeString=@"CR";
            
            vc.CRModel=self.selfModel;
            vc.lastArray=self.ActiveArray;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([self.typeString isEqualToString:@"Unregistered"]){
            HWMCRRegisteredViewController *vc=[[ HWMCRRegisteredViewController alloc]init];
            vc.currentWallet=self.wallet;
            vc.lastArray=self.ActiveArray;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([self.typeString isEqualToString:@"Canceled"]){
            
            DrawBackVoteMoneyVC *vc=[[DrawBackVoteMoneyVC alloc]init];
            vc.CRTypeString=@"CRString";
            vc.CRModel=self.selfModel;
            vc.nodeName=self.nodeName;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([self.typeString isEqualToString:@"Pending"]){
            FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
            vc.currentWallet=self.wallet;
            vc.CRTypeString=@"CR";
            vc.CRModel=self.selfModel;
            vc.lastArray=self.ActiveArray;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            FLManageSelectPointNodeInformationVC *vc= [[FLManageSelectPointNodeInformationVC alloc]init];
            vc.currentWallet=self.wallet;
            vc.CRModel=self.selfModel;
            vc.lastArray=self.ActiveArray;
            vc.CRTypeString=@"CR";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(void)setCROwnerDID:(NSString *)CROwnerDID{
    _CROwnerDID=CROwnerDID;
    
}
-(void)setCROwnerPublicKey:(NSString *)CROwnerPublicKey{
    _CROwnerPublicKey=CROwnerPublicKey;
    
}
-(NSMutableArray *)ActiveArray{
    if(!_ActiveArray){
        _ActiveArray =[[NSMutableArray alloc]init];
        
    }
    return _ActiveArray;
}
-(void)needUpdataSta{
    self.all_selectedButton.selected=NO;
    self.all_selectedImageView.image=[UIImage imageNamed:@"found_vote_border"];
    [self UpdataLocalOwerlist];
}
-(void)setNodeName:(NSString *)nodeName{
    _nodeName=nodeName;
}
-(void)updateInfoSelf{
    
    if ([self.selfModel.state isEqualToString:@"Active"]) {
        self.typeString=@"Registered";
        self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
        self.votingListV.typeString=self.typeString;
    }else if ([self.selfModel.state isEqualToString:@"Inactive"]){
        self.typeString=@"Registered";
        self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
        self.votingListV.typeString=self.typeString;
    }else if ([self.selfModel.state isEqualToString:@"Canceled"]){
        self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
        self.typeString=@"Canceled";
        self.votingListV.typeString=self.typeString;
    }else if ([self.selfModel.state isEqualToString:@"Illegal"]){
        self.typeString=@"Registered";
        self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
        self.votingListV.typeString=self.typeString;
        
    }else if ([self.selfModel.state isEqualToString:@"Returned"]){
        self.votingRulesButton.hidden=YES;
        self.tagVoteRuleLab.hidden=YES;
        self.found_vote_rule.hidden=YES;
        self.typeString=@"ReturnDeposit";
        self.votingListV.typeString=self.typeString;
    }else if ([self.selfModel.state isEqualToString:@"Pending"]){
        self.typeString=@"Pending";
        self.tagVoteRuleLab.text=NSLocalizedString(@"选举管理", nil);
        self.found_vote_rule.image=[UIImage imageNamed:@"vote_management"];
        self.votingListV.typeString=self.typeString;
    }
    else{
        self.tagVoteRuleLab.text=NSLocalizedString(@"报名参选", nil);
        self.found_vote_rule.image=[UIImage imageNamed:@"vote_attend"];
        self.typeString=@"Unregistered";
        self.votingListV.typeString=self.typeString;
    }
}
-(void)updateDataSource{
    [self updateDataInfo];
    
}
-(bool)UnregisteredAndTimeExpired{
    
    [[HWMDIDManager shareDIDManager]hasDIDWithPWD:@"" withDIDString:self.wallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.wallet.masterWalletID needCreatDIDString:NO];
    
    BOOL hasChain=[[HWMDIDManager shareDIDManager]HasBeenOnTheChain];
    if (hasChain==NO) {
        UIView *mainView =[self mainWindow];
        [mainView addSubview:self.openIDChainView];
        self.openIDChainView.deleteType=needCreadDIDType;
        [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
        return NO;
    }
    
    if ([[HWMDIDManager shareDIDManager]CheckDIDwhetherExpiredWithDIDString:self.wallet.didString WithmastWalletID:self.wallet.masterWalletID]) {
        return YES;
    }
    
    return NO;
    
    
}

@end
