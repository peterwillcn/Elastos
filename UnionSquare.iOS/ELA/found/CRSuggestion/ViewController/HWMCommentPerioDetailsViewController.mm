//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import "HWMCommentPerioDetailsViewController.h"
#import "HWMCommentPerioDetailsHeadView.h"
#import "HWMCommitteeMembersToVoteView.h"
#import "HWMCRProposalConfirmView.h"
#import "HMWSendSuccessPopuView.h"
#import "HWMCRSuggestionNetWorkManger.h"
#import "HWMDetailsProposalModel.h"
#import "HWMDetailsProposalViewModel.h"
#import "HWMAbstractTableViewCell.h"
#import "HWMOpposedProgressHeadView.h"
#import "WCQRCodeScanningVC.h"
#import "HMWinputVotesPopupWindowView.h"
#import "HWMSecretaryGeneralAndMembersInfo.h"
#import "ELWalletManager.h"
#import "HWMSecretaryGeneralAndMembersInfo.h"
#import "HWMDIDManager.h"
#import "JWT.h"
#import "YYKit.h"
#import "ELAVotingProcessUtil.h"

static NSString *BaseTableViewCell=@"HWMAbstractTableViewCell";
@interface HWMCommentPerioDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,HWMCRProposalConfirmViewDelgate,HWMCommentPerioDetailsHeadViewDelegate,HWMCommitteeMembersToVoteViewDelegate,HWMOpposedProgressHeadViewDelegate,VotesPopupViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *buttonBGView;
@property (weak, nonatomic) IBOutlet UIButton *sweepYardsToVoteButton;
@property (weak, nonatomic) IBOutlet UITableView *baseTable;
@property(strong,nonatomic)HMWSendSuccessPopuView*sendSuccessPopuV;
@property(strong,nonatomic)HWMCommentPerioDetailsHeadView*headView;
@property(strong,nonatomic)HWMCommitteeMembersToVoteView*foodView;
@property(strong,nonatomic)HWMCRProposalConfirmView*CRProposalConfirmV;
@property(strong,nonatomic)HWMDetailsProposalModel*DetailsModel;
@property(copy,nonatomic)NSArray*cellInfoArray;
@property(assign,nonatomic)BOOL isOpen;
@property(strong,nonatomic)HWMOpposedProgressHeadView*OpposedProgressHeadV;
@property(strong,nonatomic)HMWinputVotesPopupWindowView*inputVoteTicketView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BGButtonHeight;
@property(copy,nonatomic)NSDictionary *PayLoadDic;
@property(copy,nonatomic)NSString*jwtString;
@property(copy,nonatomic)NSString*votesString;

//xxl #943
@property (nonatomic, strong) ELAVotingProcessUtil *votingProcessUtil;
@property(strong,nonatomic)NSMutableArray*VoteingProposalArray;


@end

@implementation HWMCommentPerioDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    self.buttonBGView.alpha=0.f;
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"社区提案", nil);//委员评议
    [[HMWCommView share]makeBordersWithView:self.sweepYardsToVoteButton];

    self.baseTable.alpha=0.f;
    if (self.whereFrome.length==0) {
        [self makeView];
        [self loadPerioDetailsWithID:self.model.ID];
    }else{
        [self parsingQRCodeDataWithType:self.codeSignatureT withDicData:self.DicData withQRString:self.qrString];
    }
    
    
    //xxl #943
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onTxPublish:)
                                            name:OnTxPublishedResult
                                            object:nil];

    
    
}

//xxl #943
-(void)onTxPublish:(NSNotification*)notice{
    
    //xxl voteforproposal
    _votingProcessUtil = [ELAVotingProcessUtil shareVotingProcess];
    NSMutableDictionary *resultDic = _votingProcessUtil.resultDic;
    
    if([[resultDic allKeys] containsObject:@"txid"]){
        
        if(resultDic[@"txid"] == _votingProcessUtil.curTxid){
            return;
        }else{
            _votingProcessUtil.curTxid = resultDic[@"txid"];
        }
    }
    
    NSDictionary *param =notice.object;
    NSLog(@"xxl 943 2 HWMCommentPerioDetailsViewController onTxPublish %@ 1",param);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"xxl 943 resultDic = %@",resultDic);
        NSLog(@"xxl 943 txid = %@",resultDic[@"txid"]);
        NSLog(@"xxl 943 pwd = %@",resultDic[@"pwd"]);
        
        
        if(resultDic != nil
           && [[resultDic allKeys] containsObject:@"txid"]
           && resultDic[@"txid"] != nil ){
            //[self updaeJWTInfoWithDic:txidDic];
            NSDictionary *callDic = [self callBack:resultDic[@"txid"] pwd:resultDic[@"pwd"]];
            if(callDic)
            {
                [self updaeJWTInfoWithDic:callDic];
            }else {
                
                NSLog(@"xxl 943 2 HWMCommentPerioDetailsViewController onTxPublish 2.1");
                [self showSendSuccessOrFial:SignatureFailureType];
            }
            
        }else{
            NSLog(@"xxl 943 2 HWMCommentPerioDetailsViewController onTxPublish 2.2");
            [self showSendSuccessOrFial:SignatureFailureType];
        }
    
    });
    
}

-(NSMutableArray *)VoteingProposalArray{
    if (!_VoteingProposalArray) {
        _VoteingProposalArray =[[NSMutableArray alloc]init];
    }
    return _VoteingProposalArray;
}
-(void)loadPerioDetailsWithID:(NSString*)ID{
    [self showLoading];
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadCRSuggestionDetailsWithID:ID withComplete:^(id  _Nonnull data) {
        [[HWMDetailsProposalViewModel alloc]detailsProposalModelDataJosn:data[@"data"] completion:^(HWMDetailsProposalModel * _Nonnull model) {
            
            self.DetailsModel=model;
       
            if(self.type==CommentPerioNOTIFICATIONType){
                self.OpposedProgressHeadV.DetailsProposalM=self.DetailsModel;
                [self hiddLoading];
            }
            self.foodView.DetailsProposalM=self.DetailsModel;
            if(self.type==CommentPerioNOTIFICATIONType||self.type==CommentPerioVOTINGType){
                [self updateMemberIdentity];
    
            }else{
                self.baseTable.alpha=1.f;
                [self hiddLoading];
            }
            if (self.type==CommentPerioNOTIFICATIONType) {//公示中
                [self.OpposedProgressHeadV needClose];
                [self.foodView showInfo];
            }else if (self.type==CommentPerioVOTINGType){//委员评议

                [self.headView showInfo];
                [self.foodView showInfo];

            }else if (self.type==CommentPerioREJECTEDType){// 未通过
                [self.OpposedProgressHeadV needClose];
                [self.foodView showInfo];
                
            }else if (self.type==CommentPerioREJECTEDType)//已否决
                [self.headView needClose];
                [self.foodView showInfo];
            
        }];
    }];
}
-(void)makeView{
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.backgroundColor=[UIColor clearColor];
    [self.baseTable registerNib:[UINib nibWithNibName:BaseTableViewCell bundle:nil] forCellReuseIdentifier:BaseTableViewCell];
    //    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.type==CommentPerioVOTINGType) {
        [self updateMemberIdentity];
        [self.sweepYardsToVoteButton setTitle:NSLocalizedString(@"扫码投票", nil) forState:UIControlStateNormal];
        UIView *tableHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 90+self.model.cellHeight)];
        self.headView.model=self.model;
        [tableHeadView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(tableHeadView);
        }];
        self.baseTable.tableHeaderView=tableHeadView;
    }else if(self.type==CommentPerioNOTIFICATIONType){
        [self updateMemberIdentity];
        [self.sweepYardsToVoteButton setTitle:NSLocalizedString(@"投票反对", nil) forState:UIControlStateNormal];
        UIView *tableHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 180+self.model.cellHeight)];
        [tableHeadView addSubview:self.OpposedProgressHeadV];
        [self.OpposedProgressHeadV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(tableHeadView);
        }];
        self.OpposedProgressHeadV.model=self.model;
        self.baseTable.tableHeaderView=tableHeadView;
        [self setVoteforProposalInfo];
    }else if (self.type== CommentPerioFINALType){
        self.buttonBGView.alpha=0.f;
        self.BGButtonHeight.constant=0.f;
        UIView *tableHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 90+self.model.cellHeight)];
        self.headView.model=self.model;
        [tableHeadView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(tableHeadView);
        }];
        self.baseTable.tableHeaderView=tableHeadView;
    }else if (self.type==CommentPerioREJECTEDType){
        self.buttonBGView.alpha=0.f;
        self.BGButtonHeight.constant=0.f;
        UIView *tableHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 90+self.model.cellHeight)];
        self.headView.model=self.model;
        self.headView.needMakeLine=YES;
        [tableHeadView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(tableHeadView);
        }];
        self.baseTable.tableHeaderView=tableHeadView;
        
    }else if (self.type==CommentPerioVETOEDType){
        self.buttonBGView.alpha=0.f;
        self.BGButtonHeight.constant=0.f;
        self.OpposedProgressHeadV.needMakeLine=YES;
        UIView *tableHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 180+self.model.cellHeight)];
        [tableHeadView addSubview:self.OpposedProgressHeadV];
        [self.OpposedProgressHeadV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(tableHeadView);
        }];
        self.OpposedProgressHeadV.model=self.model;
        self.baseTable.tableHeaderView=tableHeadView;
    }
    [self setTableViewFootViewWithHeight:300];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isOpen) {
        return self.cellInfoArray.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((self.isOpen==YES&&self.type==CommentPerioREJECTEDType)||(self.isOpen==YES&&self.type==CommentPerioVETOEDType)) {
        if (indexPath.section==0) {
            return 0.01;
        }
    }
    if (indexPath.section==3||self.isOpen==NO) {
        return self.DetailsModel.abstractCell+50;
    }
    if ([self.cellInfoArray[indexPath.section] isEqualToString:NSLocalizedString(@"提案哈希", nil)]) {
        return 90;
    }
    return 70;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMAbstractTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:BaseTableViewCell];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.titleLabel.text=self.cellInfoArray[indexPath.section];
    if (self.isOpen==NO){
        cell.titleLabel.text=self.cellInfoArray.lastObject;
        cell.constLabel.text=self.DetailsModel.abstract;
        return cell;
    }
    switch (indexPath.section) {
        case 0:
            cell.constLabel.text=self.DetailsModel.duration;
            if((self.isOpen==YES&&self.type==CommentPerioREJECTEDType)||(self.isOpen==YES&&self.type==CommentPerioVETOEDType)) {
                cell.alpha=0.f;
            }
            break;
        case 1:
            cell.constLabel.text=self.model.proposalHash;
            break;
        case 2:
            cell.constLabel.text=self.DetailsModel.address;
            cell.constLabel.textColor=RGBA(28, 164, 252, 1);
            cell.constLabel.userInteractionEnabled=YES;
            break;
        case 3:
            cell.constLabel.text=self.DetailsModel.abstract;
            break;
        default:
            break;
    }
    if ([self.cellInfoArray[indexPath.section] isEqualToString:NSLocalizedString(@"提案哈希", nil)]) {
        cell.constLabel.text=self.model.proposalHash;
    }
    return cell;
}
-(HWMCommentPerioDetailsHeadView *)headView{
    if (!_headView) {
        _headView =[[HWMCommentPerioDetailsHeadView alloc]init];
        _headView.delegate=self;
        if (self.type==CommentPerioVETOEDType||self.type==CommentPerioREJECTEDType) {
            _headView.needMakeLine=YES;
//            [_headView needClose];
        }
    }
    return _headView;
}
-(HWMCommitteeMembersToVoteView *)foodView{
    if (!_foodView) {
        _foodView=[[HWMCommitteeMembersToVoteView alloc]init];
        _foodView.delegate=self;
    }
    return _foodView;
}
- (IBAction)SweepYardsToVoteEvent:(id)sender {
    if (self.type==CommentPerioVOTINGType) {
        [self QrCode];
    }else if (self.type==CommentPerioNOTIFICATIONType){// 投票反对
        UIView *mainView=[self mainWindow];
        [mainView addSubview:self.inputVoteTicketView];
        [self.inputVoteTicketView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
        
    }
    
}
-(void)QrCode{
    __weak __typeof__(self) weakSelf = self;
    WCQRCodeScanningVC *WCQRCode=[[WCQRCodeScanningVC alloc]init];
    WCQRCode.frVC=self;
    WCQRCode.scanBack=^(NSString *addr){
        [weakSelf ShowTradingDetailsWithTypeWithData:addr];
        
    };
    [self QRCodeScanVC:WCQRCode];
}
-(void)ShowTradingDetailsWithTypeWithData:(NSString*)qrString{
    [[HWMQrCodeSignatureManager shareTools] QrCodeDataWithData:qrString withDidString:[[HWMSecretaryGeneralAndMembersInfo shareTools] getDIDString] withmastWalletID: [[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID] withComplete:^(QrCodeSignatureType type, id  _Nonnull data) {
        [self parsingQRCodeDataWithType:type withDicData:data withQRString:qrString];
    }];
}
-(void)parsingQRCodeDataWithType:(QrCodeSignatureType)type withDicData:(id)data withQRString:(NSString*)qrString{
    self.PayLoadDic=data;
    self.jwtString=qrString;
    
    if (type==reviewPropalQrCodeType) {//扫码投票
        if (self.model.proposalHash.length>0) {
            if (![self.model.proposalHash isEqualToString:data[@"data"][@"proposalHash"] ]) {
              [[FLTools share]showErrorInfo:@"信息格式错误"];
                return;
            }
        }
        //        if (![self.model.proposalHash isEqualToString:data[@"data"][@"proposalHash"] ]) {
        //            [[FLTools share]showErrorInfo:@"不是当前提案"];
        //
        //            return;
        //        }
        [self showCRProposalConfirmView];
        
        if ([data[@"data"][@"voteResult"] isEqualToString:@"approve"]) {
            self.CRProposalConfirmV.type=favorType;
            
            
        }else if ([data[@"data"][@"voteResult"] isEqualToString:@"reject"]){
            self.CRProposalConfirmV.type=againstType;
        }else if ([data[@"data"][@"voteResult"] isEqualToString:@"abstain"]){
            self.CRProposalConfirmV.type=WaiverType;
        }else{
            self.CRProposalConfirmV.type=NOPperatingType;
        }
        
        [self.CRProposalConfirmV postWithHash: data[@"data"][@"proposalHash"] withVotes:@"" withFee:@"0.0001 ELA"];
        
    }else if (type==voteforProposalQrCodeType){// 投票反对
        UIView *mainView=[self mainWindow];
        [mainView addSubview:self.inputVoteTicketView];
        [self.inputVoteTicketView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }else{
        [[FLTools share]showErrorInfo:@"信息格式错误"];
//        [self QrCodeScanningResultsWithString:qrString withVC:self];
    }
}
-(HWMCRProposalConfirmView *)CRProposalConfirmV{
    if (!_CRProposalConfirmV) {
        _CRProposalConfirmV=[[HWMCRProposalConfirmView  alloc]init];
        _CRProposalConfirmV.delegate=self;
    }
    return _CRProposalConfirmV;
    
}
-(void)closeCRProposalConfirmView{
    [self.CRProposalConfirmV removeFromSuperview];
    self.CRProposalConfirmV=nil;
    if (self.whereFrome.length>0) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
-(void)CRProposalConfirmWithPWD:(NSString*_Nonnull)PWD{
//    [self.CRProposalConfirmV removeFromSuperview];
//    self.CRProposalConfirmV=nil;
    [self showLoading];
    if (self.type==CommentPerioVOTINGType) {
//            [self.CRProposalConfirmV removeFromSuperview];
//            self.CRProposalConfirmV=nil;
        [self reviewProposal:PWD];
    }else if (self.type==CommentPerioNOTIFICATIONType){// 投票反对
        //            [self.CRProposalConfirmV removeFromSuperview];
        //            self.CRProposalConfirmV=nil;
        [self voteForProposal:PWD];
        
    }
    
    
    
    
}
-(void)voteForProposal:(NSString*)pwd{
    
    //
    NSLog(@"voteForProposal is %@",self.PayLoadDic);
    
    [self showLoading];
    invokedUrlCommand *mommand = [[invokedUrlCommand alloc]initWithArguments:@[[[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID], pwd] callbackId:[[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID] className:@"Wallet" methodName:@"exportWalletWithMnemonic"];
    PluginResult *result = [[ELWalletManager share]VerifyPayPassword:mommand];
    NSNumber *number = result.status;
    
    if( [number intValue] != 1){
        NSString *errCode=[NSString stringWithFormat:@"%@", result.message[@"error"][@"message"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return;
    }
    NSString *hash;
    if (self.PayLoadDic) {
        hash=self.PayLoadDic[@"data"][@"proposalHash"];
    }else{
        hash=self.model.proposalHash;
    }
    
    NSDictionary *playLoadDic = @{
        @"ProposalHash":hash,
        @"Amount":[[FLTools share]elsToSela:self.votesString],
        @"VotingProposal":self.VoteingProposalArray
    };
    
    mommand = [[invokedUrlCommand alloc]initWithArguments:
               @[[[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID],playLoadDic, pwd]
                                               callbackId:[[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID]
                                                className:@"Wallet"
                                               methodName:@"createProposalForVoteTransaction"];
    
    PluginResult *pluginResult = [[ELWalletManager share] proposalVoteForTransaction:mommand];
    number =pluginResult.status;
    if( [number intValue] != 1){
        NSString *errCode=[NSString stringWithFormat:@"%@", result.message[@"error"][@"message"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        
        return;
    }else{
        [self showSendSuccessOrFial:sendDealType];
    }
    
    
}
-(void)setVoteforProposalInfo{
    
    [self showLoading];
    [self.VoteingProposalArray removeAllObjects];
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]searchReloadCRSuggestionDataSourceWithType:NOTIFICATIONType withStartIndex:0 withNumbers:100 withSearchContent:@"" withComplete:^(id  _Nonnull data) {
        NSLog(@"data is %@",data[@"data"][@"list"]);
        self.VoteingProposalArray = data[@"data"][@"list"];
        [self hiddLoading];
        
    }];
    
}

-(void)showCRProposalConfirmView{
    UIView *mainView=[self mainWindow];
    [mainView addSubview:self.CRProposalConfirmV];
    [self.CRProposalConfirmV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
}

-(void)setModel:(HWMBillListModel *)model{
    _model=model;
}
-(NSArray *)cellInfoArray{
    if (!_cellInfoArray) {
        _cellInfoArray =@[NSLocalizedString(@"剩余时间", nil),NSLocalizedString(@"提案哈希", nil),NSLocalizedString(@"原文网址", nil),NSLocalizedString(@"摘要", nil)];
    }
    return _cellInfoArray;
}
-(void)closeCommentPerioDetailsOrOpen:(BOOL)isOpen{
    self.isOpen=!isOpen;
    [self.baseTable reloadData];
}
-(HWMDetailsProposalModel *)DetailsModel{
    if (!_DetailsModel) {
        _DetailsModel=[[HWMDetailsProposalModel alloc]init];
    }
    return _DetailsModel;
}
-(void)setTableViewFootViewWithHeight:(CGFloat)height{
    UIView *foodView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, height)];
    [foodView addSubview:self.foodView];
    [self.foodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(foodView);
    }];
    
    self.baseTable.tableFooterView=foodView;
    
}
-(void)CommitteeMembersToVoteISopenOrClose:(BOOL)isClose{
    
    if (isClose) {
        [self setTableViewFootViewWithHeight:300];
    }else{
        [self setTableViewFootViewWithHeight:45];
    }
}
-(HWMOpposedProgressHeadView *)OpposedProgressHeadV{
    if (!_OpposedProgressHeadV) {
        _OpposedProgressHeadV =[[HWMOpposedProgressHeadView alloc]init];
        _OpposedProgressHeadV.delegate=self;
        if (self.type==CommentPerioVETOEDType||self.type==CommentPerioREJECTEDType) {
            _OpposedProgressHeadV.needMakeLine=YES;
        }
        
        
    }
    return _OpposedProgressHeadV;
}
-(void)closeOpposedProgressDetailsOrOpen:(BOOL)isOpen{
    self.isOpen=!isOpen;
    
    [self.baseTable reloadData];
}
-(void)setType:(CommentPerioType)type{
    
    _type=type;
}
-(HMWinputVotesPopupWindowView *)inputVoteTicketView
{
    if (!_inputVoteTicketView ) {
        _inputVoteTicketView = [[HMWinputVotesPopupWindowView alloc]init];
        _inputVoteTicketView.frame = [UIScreen mainScreen].bounds;
        _inputVoteTicketView.delegate = self;
        _inputVoteTicketView.type=VoteAgainsType;
    }
    return _inputVoteTicketView;
}
-(void)didHadInputVoteTicket:(NSString*)ticketNumer WithIsMax:(BOOL)isMax{
    [self.inputVoteTicketView removeFromSuperview];
    self.inputVoteTicketView =nil;
    [self showCRProposalConfirmView];
    self.CRProposalConfirmV.type=OpposingVotesType;
    self.votesString=ticketNumer;
    NSString *hash;
    if (self.PayLoadDic) {
        hash=self.PayLoadDic[@"data"][@"proposalHash"];
    }else{
        hash=self.model.proposalHash;
    }
    [self.CRProposalConfirmV postWithHash:hash withVotes:self.votesString withFee:@"0.0001 ELA"];
    
}
-(void)closeInView{
    if (self.whereFrome.length>0) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}
-(void)reviewProposal:(NSString*)pwd{
    [self showLoading];
    NSString * masterWalletID= [[HWMSecretaryGeneralAndMembersInfo shareTools]getmasterWalletID];
    invokedUrlCommand *mommand = [[invokedUrlCommand alloc]initWithArguments:@[masterWalletID, pwd] callbackId:[[HWMSecretaryGeneralAndMembersInfo shareTools]getmasterWalletID] className:@"Wallet" methodName:@"exportWalletWithMnemonic"];
    PluginResult *result = [[ELWalletManager share]VerifyPayPassword:mommand];
    NSNumber *number = result.status;
    
    if( [number intValue] != 1){
        
        NSString *errCode=[NSString stringWithFormat:@"%@", result.message[@"error"][@"message"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return;
    }
    NSNumber *NVoteResult;
    
    if ([self.PayLoadDic[@"data"][@"voteResult"] isEqualToString:@"approve"]) {
        NVoteResult=@(0);
    }else if([self.PayLoadDic[@"data"][@"voteResult"] isEqualToString:@"reject"]){
        NVoteResult=@(1);
    }else{
        NVoteResult=@(2);
    }
    
    NSString *hash;
    if (self.PayLoadDic) {
        hash=self.PayLoadDic[@"data"][@"proposalHash"];
    }else{
        hash=self.model.proposalHash;
    }
    NSDictionary *playLoadDic = @{
        
        @"ProposalHash":hash,
        @"VoteResult":NVoteResult,
        @"OpinionHash":self.PayLoadDic[@"data"][@"opinionHash"],
        @"DID":[self.PayLoadDic[@"data"][@"did"] stringByReplacingOccurrencesOfString:@"did:elastos:" withString:@""]
    };
    
    mommand = [[invokedUrlCommand alloc]initWithArguments:
               @[masterWalletID,playLoadDic, pwd]
                                               callbackId:masterWalletID
                                                className:@"Wallet"
                                               methodName:@"createProposalReviewTransaction"];
    
    
    //xxl reviewProposal
    PluginResult *pluginResult = [[ELWalletManager share] proposalReviewTransaction:mommand];
    _votingProcessUtil = [ELAVotingProcessUtil shareVotingProcess];
    _votingProcessUtil.resultDic = pluginResult.message[@"success"];
    NSLog(@"xxl 943 resultDic %@",_votingProcessUtil.resultDic);
    
    //    if(pluginResult){
    //        NSDictionary *resultDic = pluginResult.message[@"success"];
    //
    //        NSDictionary *callDic = [self callBack:resultDic[@"txid"] pwd:pwd];
    //        if(callDic)
    //        {
    //            [self updaeJWTInfoWithDic:callDic];
    //        }else {
    //            [self showSendSuccessOrFial:SignatureFailureType];
    //        }
    //    }
}

//xxl 943
-(void)updaeJWTInfoWithDic:(NSDictionary*)pare{
    
    
    NSLog(@"calback url %@",self.PayLoadDic[@"callbackurl"]);
    NSLog(@"pare %@",pare);
    
    [HttpUrl NetPOSTHost:self.PayLoadDic[@"callbackurl"] url:@"" header:nil body:pare showHUD:NO WithSuccessBlock:^(id data) {
        [self showSendSuccessOrFial:SignatureSuccessType];
    } WithFailBlock:^(id data) {
        
        NSLog(@"error --- @%",data);
        [self showSendSuccessOrFial:SignatureFailureType];
    }];
}
- (NSDictionary *)callBack:(NSString *)payString pwd:(NSString *)PWDString
{
    NSLog(@"xxl for callBack ExportxPrivateKey");
    
    if(payString && ![payString isEqualToString:@""])
    {
        NSString * didString= [[HWMSecretaryGeneralAndMembersInfo shareTools] getDIDString];
        NSString * masterWalletID= [[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID];
        if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:PWDString withDIDString:didString WithPrivatekeyString:@"" WithmastWalletID:masterWalletID needCreatDIDString:NO]){
            
            NSString *playString = @"";
            
            //            if(self.VCType == TheProposalType){
            //                playString=[[FLTools share]DicToString:[self proposalhashRequestFileWithString:payString]];
            //            }else if(self.VCType == ReviewProposalType){
            playString=[[FLTools share]DicToString:[self proposalReivewhashRequestFileWithString:payString]];
            //            }
            
            NSString *jwtString=[self throuJWTStringWithplayString:playString];
            [[HWMDIDManager shareDIDManager] setPassWord:PWDString];
            NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
            if (![REString isEqualToString:@"-1"]) {
                NSDictionary *dic=@{@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]};
                return dic;
            }
        }
        return nil;
    }
}

-(NSString*)throuJWTStringWithplayString:(NSString*)playString{
    NSString *jwtString;
    NSDictionary * headers = @{@"alg": @"ES256",@"typ": @"JWT"};
    NSString *headerString=[[FLTools share]DicToString:headers];
    headerString=[JWTBase64Coder base64UrlEncodedStringWithData:[headerString dataUsingEncoding:NSUTF8StringEncoding]];
    playString=[JWTBase64Coder base64UrlEncodedStringWithData:[playString dataUsingEncoding:NSUTF8StringEncoding]];
    return jwtString=[NSString stringWithFormat:@"%@.%@",headerString,playString];
}
-(NSDictionary*)proposalReivewhashRequestFileWithString:(NSString*)String{
    
    
    NSLog(@"proposalReivewhashRequestFileWithString rep %@",self.jwtString);
    
    NSString * didString= [[HWMSecretaryGeneralAndMembersInfo shareTools] getDIDString];
    String = [String stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSDictionary *FLDic=@{
        @"command":@"reviewproposal",
        @"type":@"txidproposalreview",
        @"iss":didString,
        @"iat": self.PayLoadDic[@"iat"],
        @"exp": self.PayLoadDic[@"exp"],
        @"aud": self.PayLoadDic[@"iss"],
        @"req": self.jwtString,
        @"data":String};
    return FLDic;
}

-(void)showSendSuccessOrFial:(SendSuccessType)type{
    [[FLTools share]hideLoadingView];
    [self.CRProposalConfirmV removeFromSuperview];
    self.CRProposalConfirmV=nil;
    self.sendSuccessPopuV.type=type;
    [self.view addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeAllSubviews];
        self.sendSuccessPopuV=nil;
        
        [self.navigationController popViewControllerAnimated:NO];
    });
}
-(void)updateMemberIdentity{
    self.SecretaryGeneralAndModel=[[HWMSecretaryGeneralAndMembersInfo shareTools]getDetailsModel];
    HWMSecretaryGeneralAndMembersDetailsModel* model=[[HWMSecretaryGeneralAndMembersInfo shareTools]getDetailsModel];
    if (model) {
        if (model.GMtype== COUNCILType||model.GMtype==SECRETARIATType) {
            if (self.DetailsModel.ID.length>0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.baseTable.alpha=1.f;
                    self.buttonBGView.alpha=1.f;
                    [self hiddLoading];
                });
            }
            
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.DetailsModel.ID.length>0) {
                    self.baseTable.alpha=1.f;
                     self.BGButtonHeight.constant=0.f;
                    [self hiddLoading];}
            });
        }
        
    } else {
        [[HWMSecretaryGeneralAndMembersInfo shareTools] loadDataSourceWithLoading:NO complete:^(HWMSecretaryGeneralAndMembersDetailsModel *model) {
            
            if (model.GMtype== COUNCILType||model.GMtype==SECRETARIATType) {
                if (self.DetailsModel.ID.length>0) {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.baseTable.alpha=1.f;
                        self.buttonBGView.alpha=1.f;
                        [self hiddLoading];
                    });
                }
                
                
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.DetailsModel.ID.length>0) {
                        self.baseTable.alpha=1.f;
                         self.BGButtonHeight.constant=0.f;
                        [self hiddLoading];}
                });
            }
        }];
    }
    
}
- (void)setWhereFrome:(NSString *)whereFrome{
    self.baseTable.alpha=0.f;
    _whereFrome=whereFrome;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    //xxl #943
    [[NSNotificationCenter defaultCenter] removeObserver:OnTxPublishedResult];
    
    [super viewWillDisappear:animated];
    if (self.whereFrome.length>0) {
        [self.navigationController setNavigationBarHidden:NO];
    }
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
//    [self hiddLoading];
    if (self.whereFrome.length>0) {
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    
    
    
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV=[[HMWSendSuccessPopuView alloc]init];
    }
    return _sendSuccessPopuV;
}

@end
