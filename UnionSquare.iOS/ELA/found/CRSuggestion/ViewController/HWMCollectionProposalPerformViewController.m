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


#import "HWMCollectionProposalPerformViewController.h"
#import "HWMCommentPerioDetailsHeadView.h"
#import "HWMCommitteeMembersToVoteView.h"
#import "HWMCRProposalConfirmView.h"
#import "HMWSendSuccessPopuView.h"
#import "HWMCRSuggestionNetWorkManger.h"
#import "HWMDetailsProposalModel.h"
#import "HWMDetailsProposalViewModel.h"
#import "HWMAbstractTableViewCell.h"
#import "HWMCommitteeMembersToVoteTableViewCell.h"
#import "HWMSecretaryGeneralTableViewCell.h"

static NSString *cellCommitteeMembersString=@"HWMCommitteeMembersToVoteTableViewCell";
static NSString *cellSecretaryGeneral=@"HWMSecretaryGeneralTableViewCell";
UINib *ProposalPerform;
static NSString *BaseTableViewCell=@"HWMAbstractTableViewCell";
@interface HWMCollectionProposalPerformViewController ()<UITableViewDelegate,UITableViewDataSource,HWMCRProposalConfirmViewDelgate,HWMCommentPerioDetailsHeadViewDelegate,HWMCommitteeMembersToVoteViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *baseTable;
@property(strong,nonatomic)HMWSendSuccessPopuView*sendSuccessPopuV;
@property(strong,nonatomic)HWMCommentPerioDetailsHeadView*headView;
@property(strong,nonatomic)HWMCommitteeMembersToVoteView*foodView;
@property(strong,nonatomic)HWMCRProposalConfirmView*CRProposalConfirmV;
@property(strong,nonatomic)HWMDetailsProposalModel*DetailsModel;
@property(copy,nonatomic)NSArray*cellInfoArray;
@property(assign,nonatomic)BOOL isOpen;
@property(assign,nonatomic)BOOL isSecOpen;
@property(assign,nonatomic)CGFloat secHeight;
@end

@implementation HWMCollectionProposalPerformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"社区提案", nil);//执行中
    self.headView.model=self.model;
    [self makeView];
    self.isOpen=YES;
    self.isSecOpen=YES;
    self.secHeight=330;
    [self loadPerioDetailsWithID:self.model.ID];
    if (self.type==CommentPerioACTIVEType) {
    }else if(self.type==CommentPerioFINALType){
    }
}
-(void)loadPerioDetailsWithID:(NSString*)ID{
    self.baseTable.alpha=0.f;
    [self showLoading];
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadCRSuggestionDetailsWithID:ID withComplete:^(id  _Nonnull data) {
        [self hiddLoading];
        [[HWMDetailsProposalViewModel alloc]detailsProposalModelDataJosn:data[@"data"] completion:^(HWMDetailsProposalModel * _Nonnull model){
            self.DetailsModel=model;
            self.foodView.DetailsProposalM=self.DetailsModel;
            [self.baseTable reloadData];
            self.baseTable.alpha=1.f;
        }];
    }];
}
-(void)makeView{
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.backgroundColor=[UIColor clearColor];
    ProposalPerform =[UINib nibWithNibName:cellCommitteeMembersString bundle:nil];
    [self.baseTable registerNib:[UINib nibWithNibName:BaseTableViewCell bundle:nil] forCellReuseIdentifier:BaseTableViewCell];
    [self.baseTable registerNib:[UINib nibWithNibName:cellSecretaryGeneral bundle:nil] forCellReuseIdentifier: cellSecretaryGeneral];
    [self.baseTable registerNib:ProposalPerform forCellReuseIdentifier:cellCommitteeMembersString];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 90+self.model.cellHeight)];
    [headView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(headView);
    }];
    self.baseTable.tableHeaderView=headView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isOpen) {
        return self.cellInfoArray.count+1;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.isOpen==NO) {
        if (section==0) {
            return [self setTableViewFootViewWithHeight:self.secHeight];
        }
    }else{
        if (section==3) {
            return [self setTableViewFootViewWithHeight:self.secHeight];
        }
    }
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.isOpen==NO) {
        if (section==0) {
            return self.secHeight;
        }
    }else{
        if (section==3) {
            return self.secHeight;
        }
    }
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ((self.isOpen==NO&&section==1)||(self.isOpen==YES&&section==4)){
        return self.DetailsModel.trackingResult.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((self.isOpen==NO&&indexPath.section==1)||(self.isOpen==YES&&indexPath.section==4)){
        HWMVoteResultModel *model=self.DetailsModel.trackingResult[indexPath.row];
        if (model.commentModel) {
         UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
        return model.reasonCell+50;
    }
    if (indexPath.section==3||self.isOpen==NO) {
        return self.DetailsModel.abstractCell+50;
    }
    return 70;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((self.isOpen==NO&&indexPath.section==1)||(self.isOpen==YES&&indexPath.section==4)){
        CGFloat isHid=0.f;
        if (indexPath.row!=self.DetailsModel.trackingResult.count-1) {
            isHid=1.f;
        }
        HWMVoteResultModel *model=self.DetailsModel.trackingResult[indexPath.row];
        if (model.commentModel) {
            HWMSecretaryGeneralTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellSecretaryGeneral];
            cell.backgroundColor=[UIColor clearColor];
            cell.performModel=model;
            cell.makeLine.alpha=isHid;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            HWMCommitteeMembersToVoteTableViewCell *cell=[ProposalPerform instantiateWithOwner:nil options:nil].firstObject;
            cell.backgroundColor=[UIColor clearColor];
            cell.performModel=model;
            cell.makeLine.alpha=isHid;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
    }
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
-(UIView*)setTableViewFootViewWithHeight:(CGFloat)height{
    UIView *foodView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, height)];
    [foodView addSubview:self.foodView];
    [self.foodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(foodView);
        make.bottom.equalTo(foodView.mas_bottom).mas_offset(-30);
    }];
    UILabel *ImplementationScheduleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, height-20, AppWidth-30, 20)];
    ImplementationScheduleLabel.text=NSLocalizedString(@"执行进度", nil);
    ImplementationScheduleLabel.font=[UIFont systemFontOfSize:14];
    ImplementationScheduleLabel.textColor=[UIColor whiteColor];
    [foodView addSubview:ImplementationScheduleLabel];
    
    return foodView;
}
-(void)CommitteeMembersToVoteISopenOrClose:(BOOL)isClose{
    self.isSecOpen=isClose;
    if (self.isSecOpen) {
        self.secHeight=330;
    }else{
        self.secHeight=80;
    }
    [self.baseTable reloadData];
}
-(void)setType:(CommentPerioType)type{
    _type=type;
}
@end
