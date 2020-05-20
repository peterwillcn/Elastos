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
#import "HWMQrCodeSignatureManager.h"
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


@end

@implementation HWMCommentPerioDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"社区提案", nil);//委员评议
    [[HMWCommView share]makeBordersWithView:self.sweepYardsToVoteButton];
    [self makeView];
    self.isOpen=YES;
    [self loadPerioDetailsWithID:self.model.ID];
}
-(void)loadPerioDetailsWithID:(NSString*)ID{
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadCRSuggestionDetailsWithID:ID withComplete:^(id  _Nonnull data) {
        [[HWMDetailsProposalViewModel alloc]detailsProposalModelDataJosn:data[@"data"] completion:^(HWMDetailsProposalModel * _Nonnull model) {
            self.DetailsModel=model;
            [self.baseTable reloadData];
            if(self.type==CommentPerioNOTIFICATIONType){
                self.OpposedProgressHeadV.DetailsProposalM=self.DetailsModel;
            }
        }];
    }];
}
-(void)makeView{
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.backgroundColor=[UIColor clearColor];
    [self.baseTable registerNib:[UINib nibWithNibName:BaseTableViewCell bundle:nil] forCellReuseIdentifier:BaseTableViewCell];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.type==CommentPerioVOTINGType) {
        HWMSecretaryGeneralAndMembersDetailsModel* model=[[HWMSecretaryGeneralAndMembersInfo shareTools]getDetailsModel];
        if (model) {
            if (model.GMtype!= COUNCILType&&model.GMtype!=SECRETARIATType) {
                self.buttonBGView.alpha=0.f;
                self.BGButtonHeight.constant=0.f;
            }
        } else {
            self.buttonBGView.alpha=0.f;
            self.BGButtonHeight.constant=0.f;
        }
        [self.sweepYardsToVoteButton setTitle:NSLocalizedString(@"扫码投票", nil) forState:UIControlStateNormal];
        UIView *tableHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 90+self.model.cellHeight)];
        self.headView.model=self.model;
        [tableHeadView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(tableHeadView);
        }];
        self.baseTable.tableHeaderView=tableHeadView;
    }else if(self.type==CommentPerioNOTIFICATIONType){
        HWMSecretaryGeneralAndMembersDetailsModel* model=[[HWMSecretaryGeneralAndMembersInfo shareTools]getDetailsModel];
        if (model) {
            if (model.GMtype!= COUNCILType&&model.GMtype!=SECRETARIATType) {
                self.buttonBGView.alpha=0.f;
                self.BGButtonHeight.constant=0.f;
            }
        } else {
            self.buttonBGView.alpha=0.f;
            self.BGButtonHeight.constant=0.f;
        }
        [self.sweepYardsToVoteButton setTitle:NSLocalizedString(@"投票反对", nil) forState:UIControlStateNormal];
        UIView *tableHeadView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 180+self.model.cellHeight)];
        [tableHeadView addSubview:self.OpposedProgressHeadV];
        [self.OpposedProgressHeadV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(tableHeadView);
        }];
        self.OpposedProgressHeadV.model=self.model;
        self.baseTable.tableHeaderView=tableHeadView;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3||self.isOpen==NO) {
        return self.DetailsModel.abstractCell+50;
    }
    return 60;
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
    return cell;
}
-(HWMCommentPerioDetailsHeadView *)headView{
    if (!_headView) {
        _headView =[[HWMCommentPerioDetailsHeadView alloc]init];
        _headView.delegate=self;
    }
    return _headView;
}
-(HWMCommitteeMembersToVoteView *)foodView{
    if (!_foodView) {
        _foodView=[[HWMCommitteeMembersToVoteView alloc]init];
        _foodView.delegate=self;
    }
    return _foodView;;
    
}
- (IBAction)SweepYardsToVoteEvent:(id)sender {
//    [self ShowTradingDetailsWithTypeWithData:@""];
    [self QrCode];
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
    if (self.type==CommentPerioVOTINGType) {//评议期
        [self showCRProposalConfirmView];
       
        [[HWMQrCodeSignatureManager shareTools] QrCodeDataWithData:qrString withDidString:[[HWMSecretaryGeneralAndMembersInfo shareTools] getDIDString] withmastWalletID: [[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID] withComplete:^(QrCodeSignatureType type, id  _Nonnull data) {
            
        }];
       
    }else if(self.type==CommentPerioNOTIFICATIONType){// 公示期
        UIView *mainView=[self mainWindow];
          [mainView addSubview:self.inputVoteTicketView];
          [self.inputVoteTicketView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.top.bottom.equalTo(mainView);
          }];
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
}
-(void)CRProposalConfirmWithPWD:(NSString*_Nonnull)PWD{
    [self closeCRProposalConfirmView];
    [self showSendSuccessViewWithType:3];
    
}
-(void)showCRProposalConfirmView{
    UIView *mainView=[self mainWindow];
    [mainView addSubview:self.CRProposalConfirmV];
    [self.CRProposalConfirmV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
}
-(void)showSendSuccessViewWithType:(NSInteger)type{
    self.sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    switch (type) {
        case 0:
        {
            self.sendSuccessPopuV.type=sendDealType;
            break;
            
        }
        case 1:{
            self.sendSuccessPopuV.type=saveSuccessType;
            break;
        }
        case 3:{
            self.sendSuccessPopuV.type=sendDealType;
            break;
        }
            
        default:
            break;
    }
    
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV=nil;
        //        for (UIViewController *controller in self.navigationController.viewControllers) {
        //
        //            }
        //        }
        //                [self.navigationController popViewControllerAnimated:YES];
    });
    
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
     self.CRProposalConfirmV.type=favorType;
    [self.CRProposalConfirmV postWithHash:@"hash" withVotes:ticketNumer withFee:@"0.2 ELA"];
}

@end
