//
//  HMWtheCandidateListViewController.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWtheCandidateListViewController.h"
#import "HMWtheCandidateListTableViewCell.h"
#import "FLNotePointDBManager.h"
#import "HMWinputVotesPopupWindowView.h"
#import "ELWalletManager.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HMWFMDBManager.h"
#import "HWMSignatureTradingSingleQrCodeViewController.h"
#import "HWMTransactionDetailsView.h"
#import "HMWtheSuperNodeElectionViewController.h"

static NSString *cellString=@"HMWtheCandidateListTableViewCell";
@interface HMWtheCandidateListViewController ()<UITableViewDelegate,UITableViewDataSource,VotesPopupViewDelegate,HMWToDeleteTheWalletPopViewDelegate,HWMTransactionDetailsViewDelegate>
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;//交易成功 提示;
@property (weak, nonatomic) IBOutlet UILabel *TagtatolVoteLab;

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property(nonatomic,strong)UIImageView *placeHolferImage;

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIButton *editBtn;//右 btn

//下三uibutton
@property (weak, nonatomic) IBOutlet UILabel *hasSelectNumber;
@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *immediatelyToVoteButton;

@property(nonatomic,strong)NSMutableArray *voteArray;
@property(nonatomic,strong)NSMutableArray *deleteArray;

@property(nonatomic,strong)HMWinputVotesPopupWindowView *inputVoteTicketView;//票数视图
//@property(strong,nonatomic)HMWpwdPopupView *pwdPopupV;//密码视图
@property(nonatomic,assign)double ticket;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *persentLab;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *moreThan36View;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isMax;
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *wallet;
@property(nonatomic,assign)double maxBlance;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMTransactionDetailsView *transactionDetailsView;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *jsonString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *alltickNumer;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *fee;
@end

@implementation HMWtheCandidateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"我的候选列表", nil);
    self.TagtatolVoteLab.text=NSLocalizedString(@"全网投票占比：", nil);

    [self.immediatelyToVoteButton setTitle:NSLocalizedString(@"立即投票", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.immediatelyToVoteButton];
    [self getWalletType];
    [self getDBRecored];
    [self makeView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
    CGFloat proFlo=[[self.persent substringToIndex:self.persent.length-1]floatValue]/100;
    self.progress.progress = proFlo;
    self.persentLab.text = self.persent;
//  self.persentLab.text = [self.persent stringByAppendingString:@"%"];
    [self.selectAllBtn setImage:[UIImage imageNamed:@"found_vote_selected"] forState:UIControlStateSelected];
    [self.selectAllBtn setImage:[UIImage imageNamed:@"found_vote_border"] forState:UIControlStateNormal];
    self.invalidCRArray=@[];
    [self LoadInvalidCR];
}
-(void)getWalletType{
    NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    FMDBWalletModel *model =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
    self.wallet =[[FLWallet alloc]init];
    self.wallet.masterWalletID =model.walletID;
    self.wallet.walletName     =model.walletName;
    self.wallet.walletAddress  = model.walletAddress;
    self.wallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    self.wallet.didString=model.didString;
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
           self.wallet.TypeW=2;
            }
        }else{
            if ([baseDic[@"M"] integerValue]==1) {
           self.wallet.TypeW=1;
            }else{
         self.wallet.TypeW=3;
            }
        }
    }
}
-(HMWToDeleteTheWalletPopView *)moreThan36View{
    if (!_moreThan36View) {
        _moreThan36View =[[HMWToDeleteTheWalletPopView alloc]init];
        _moreThan36View.delegate=self;
    }
    return _moreThan36View;
}
-(void)selectMoreThan36{
    UIView *maView=[self mainWindow];
    self.moreThan36View.deleteType=moreThan36SelectList;
    [maView addSubview:self.moreThan36View];
    [self.moreThan36View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(maView);
    }];
}
#pragma mark ---------HMWToDeleteTheWalletPopViewDelegate----------
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    if (self.moreThan36View.deleteType==moreThan36SelectList) {
     [self clearVoteArray];
    for (int i= 0; i<36; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        [self.baseTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.baseTableView didSelectRowAtIndexPath:index];
    }
    self.selectAllBtn.selected=YES;
        
    }else if (self.moreThan36View.deleteType==voteInvalidType){
        UIView *  mainView =[self mainWindow];
               [mainView addSubview:self.transactionDetailsView];
               [self.transactionDetailsView TransactionDetailsWithFee:self.fee withTransactionDetailsAumont:self.alltickNumer];
               [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.top.right.bottom.equalTo(mainView);
               }];
    }
    [self toCancelOrCloseDelegate];
}
-(void)toCancelOrCloseDelegate{
    [self.moreThan36View removeFromSuperview];
    self.moreThan36View=nil;
}
-(void)getDBRecored{
    NSArray *localStore = [[FLNotePointDBManager defultWithWalletID:self.wallet.masterWalletID]allRecord];
        for (int i= 0; i<self.lastTimeArray.count; i++) {
        FLCoinPointInfoModel *model = self.lastTimeArray[i];
        BOOL ret = NO;
        for (FLCoinPointInfoModel*dataModel in localStore) {
           ret =  [dataModel.ownerpublickey isEqualToString:model.ownerpublickey];
            if (ret) {
                if ([model.state isEqualToString:@"Active"]) {
                     [self.dataSource addObject:model];
                }
               
            }
        }
   
}
    [self.baseTableView reloadData];
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (IBAction)actAction:(UIButton*)sender {
    if (self.editBtn.isSelected) {
        for (int i= 0; i<self.voteArray.count; i++) {
            FLCoinPointInfoModel *model = self.voteArray[i];
            NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
           FMDBWalletModel *FMDBmodel =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
            [[FLNotePointDBManager defultWithWalletID:FMDBmodel.walletID]delectRecord:model];
            [self.dataSource removeObject:model];
        }
        [self.voteArray removeAllObjects];
        [self.baseTableView reloadData];
        [self updataBottomBtn];
    }else{
        if (self.voteArray.count == 0) {
            return;
        }
        if (self.voteArray.count>36) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"最多可选36个节点", nil)];
            return;
        }
        ELWalletManager *manager   =  [ELWalletManager share];
        IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
       [self.view.window addSubview:self.inputVoteTicketView];
       String balanceSt = mainchainSubWallet->GetBalance();
       NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
       NSInteger balance=[balanceString integerValue];
        self.inputVoteTicketView.votes =balance/unitNumber;
                 NSString *eleString=[[FLTools share]elaScaleConversionWith: balanceString];
                self.maxBlance=[eleString doubleValue];
        if (balance>0) {
             NSString *maxBla=[[FLTools share]CRVotingDecimalNumberBySubtracting:eleString withCRMermVoting:@"0.01"];
             self.inputVoteTicketView.accountBalanceLab.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"最大表决票权", nil),maxBla];
        }else{
            NSString *maxBla=@"0";
            self.inputVoteTicketView.accountBalanceLab.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"最大表决票权", nil),maxBla];
        }
       
        
    }
    
}
- (IBAction)selectAllAction:(UIButton*)sender {
    if (sender.isSelected) {
         [self clearVoteArray];
        sender.selected = NO;
        for (int i= 0; i<self.dataSource.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
            [self.baseTableView deselectRowAtIndexPath:index animated:YES];
            [self tableView:self.baseTableView didDeselectRowAtIndexPath:index];
        }
    }else{
        if (self.editBtn.isSelected==NO) {
            if (self.dataSource.count>36) {
                [self  selectMoreThan36];
                return;
            }
        }
        
         [self clearVoteArray];
       sender.selected = YES;
    for (int i= 0; i<self.dataSource.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        [self.baseTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.baseTableView didSelectRowAtIndexPath:index];
    }
    }
}
-(void)clearVoteArray{
    [self.voteArray removeAllObjects];
    [self.baseTableView reloadData];
    [self updataBottomBtn];
}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    self.baseTableView.rowHeight=70;
    self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.baseTableView.allowsMultipleSelection = YES;
    [self.baseTableView addSubview:self.placeHolferImage];
    CGPoint certer=self.baseTableView.center;
    certer.x=certer.x-10;
    self.placeHolferImage.center = certer;
    self.placeHolferImage.hidden = self.dataSource.count!=0;
    [self updataBottomBtn];
}

-(void)updataBottomBtn{
    
    self.hasSelectNumber.text = [NSString stringWithFormat:@"%lu %@",(unsigned long)self.voteArray.count,NSLocalizedString(@"已选择", nil)];
    [self.selectAllBtn  setTitle:[NSString stringWithFormat:@"%@(%lu/%ld)",NSLocalizedString(@"全选", nil), self.voteArray.count,self.dataSource.count] forState:UIControlStateNormal]  ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   HMWtheCandidateListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    FLCoinPointInfoModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FLCoinPointInfoModel *model = self.dataSource[indexPath.row];
    if (![self.voteArray containsObject:model]) {
        [self.voteArray addObject:model];
    }
    if (self.voteArray.count==self.dataSource.count) {
          self.selectAllBtn.selected = YES;
       }
    [self updataBottomBtn];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLCoinPointInfoModel *model = self.dataSource[indexPath.row];
    if ([self.voteArray containsObject:model]) {
        [self.voteArray removeObject:model];
    }
    if (self.voteArray.count!=self.dataSource.count) {
        self.selectAllBtn.selected = NO;
       
    }
    [self updataBottomBtn];
}
-(void)editStateChange:(UIButton*)btn{
    self.editBtn.selected = !self.editBtn.isSelected;
    NSString *title = self.editBtn.isSelected ?NSLocalizedString(@"删除", nil):NSLocalizedString(@"立即投票", nil);
    [self.immediatelyToVoteButton setTitle:title forState:UIControlStateNormal];
    self.hasSelectNumber.hidden = self.editBtn.selected;
    [self clearVoteArray];
    self.selectAllBtn.selected = YES;
    [self selectAllAction:self.selectAllBtn];
}
#pragma mark 代理
-(void)didHadInputVoteTicket:(NSString *)ticketNumer WithIsMax:(BOOL)isMax
{

     double ticket=[ticketNumer doubleValue];
    if (isMax==NO) {
        if ([ticketNumer doubleValue]>(self.maxBlance-0.01)) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
                return;
            }
        if ([[FLTools share]isBlankString:ticketNumer]) {
            return;
        }
    }else{
        ticket=self.maxBlance-0.01;
        
//         ticket=-1;
    }
    [self.inputVoteTicketView removeFromSuperview];
     self.inputVoteTicketView= nil;
    self.isMax=isMax;
    NSMutableArray *stringArray = [NSMutableArray array];
     for (int i= 0; i<self.voteArray.count; i++) {
         FLCoinPointInfoModel *model = self.voteArray[i];
         [stringArray addObject:model.ownerpublickey];
     }
    
    

    
    NSDictionary *dic =[[ELWalletManager share]DopsVoteFeeCRMainchainSubWallet:self.wallet.masterWalletID ToVote:stringArray tickets:ticket withInvalidIDArray:self.invalidCRArray];
        self.fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",dic[@"fee"]]];
    NSArray *DorpVotes=dic[@"DorpVotes"];
  
    if ([self.fee doubleValue]<0) {
        [self closeTransactionDetailsView];
        return;
    }
     UIView *mainView =[self mainWindow];
    if (DorpVotes.count>0) {
        [mainView addSubview:self.moreThan36View];
        self.moreThan36View.deleteType=voteInvalidType;
        [self.moreThan36View mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.top.right.bottom.equalTo(mainView);
             }];
          
    }else{
    self.jsonString=dic[@"JSON"];
        
  
    if (isMax) {
        self.alltickNumer=@"MAX";
        
    }
    else{
        self.alltickNumer=  [[FLTools share]CRVotingDecimalNumberByMultiplying:ticketNumer withCRMermVoting:[NSString stringWithFormat:@"%d",1] ];
    }
             self.ticket=ticketNumer.doubleValue;
        [mainView addSubview:self.transactionDetailsView];
        [self.transactionDetailsView TransactionDetailsWithFee:self.fee withTransactionDetailsAumont:self.alltickNumer];
        [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(mainView);
        }];
   
        
    }
//    if (self.wallet.TypeW==0) {
//        [self.view.window addSubview:self.pwdPopupV];
//    }else if (self.wallet.TypeW==1){
//        [self makeSureWithPWD:@""];
//    }else if (self.wallet.TypeW==2){
//        [self.view.window addSubview:self.pwdPopupV];
//    }else if (self.wallet.TypeW==3){
//        [self makeSureWithPWD:@""];
//    }
}
//-(void)cancelThePWDPageView{
//    [self.pwdPopupV removeFromSuperview];
//     self.pwdPopupV  = nil;
//}
-(void)makeSureWithPWD:(NSString*)pwd{
//    NSMutableArray *stringArray = [NSMutableArray array];
//    for (int i= 0; i<self.voteArray.count; i++) {
//        FLCoinPointInfoModel *model = self.voteArray[i];
//        [stringArray addObject:model.ownerpublickey];
//    }
//        double tic=self.ticket;
//        if (self.isMax) {
//        tic=-1;
//        }
//        if (self.wallet.TypeW==0) {
//        NSString *walletId = [ELWalletManager share].currentWallet.masterWalletID;
//        BOOL ret = [[ELWalletManager share]useMainchainSubWallet:walletId ToVote:stringArray tickets:tic pwd:pwd isChangeVote:YES];
//        if (ret) {
//            [self showSendSuccessPopuV];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.sendSuccessPopuV removeFromSuperview];
//                self.sendSuccessPopuV=nil;
//            });
//        }
//        [self.pwdPopupV removeFromSuperview];
//        self.pwdPopupV =  nil;
//        }else if (self.wallet.TypeW==1){
//        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",self.ticket],pwd,@(1)] callbackId:self.wallet.masterWalletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
//        PluginResult *result = [[ELWalletManager share]SignReadOnlyToVote:mommand];
//        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
//        if ([statue isEqualToString:@"1"]){
//            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
//              SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
//            SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
//            NSDictionary *successDic=[[NSDictionary alloc]initWithDictionary:result.message[@"success"]]; SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:successDic];
//           SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
//            SignatureTradingSingleQrCodeVC.subW=@"ELA";
//            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
//        }
//        }else if (self.wallet.TypeW==2){
//        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",self.ticket],pwd,@(1)] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
//        PluginResult *result = [[ELWalletManager share]HowSignToVote:mommand];
//        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
//        if ([statue isEqualToString:@"1"]) {
//            [self.pwdPopupV removeFromSuperview];
//            self.pwdPopupV =  nil;
//            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
//           SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
//           SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
//           SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:result.message[@"success"]];
//           SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"]; SignatureTradingSingleQrCodeVC.subW=@"ELA";
//            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
//        }
//        }else if (self.wallet.TypeW==3){
//        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",self.ticket],pwd,@(1)] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
//        PluginResult *result = [[ELWalletManager share]SignReadOnlyToVote:mommand];
//        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
//        if ([statue isEqualToString:@"1"]) {
//            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
//               SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
//            SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
//            SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:result.message[@"success"]];
//            SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
//            SignatureTradingSingleQrCodeVC.subW=@"ELA";
//            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
//        }
//    }
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
        UIView *manView=[self mainWindow];
        [manView addSubview:self.sendSuccessPopuV];
        [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(manView);
        }];
    }
    return _sendSuccessPopuV;
}
-(void)showSendSuccessPopuV{
    self.sendSuccessPopuV.hidden = NO;
}
#pragma mark lazy
-(HMWinputVotesPopupWindowView *)inputVoteTicketView
{
    if (!_inputVoteTicketView ) {
        _inputVoteTicketView = [[HMWinputVotesPopupWindowView alloc]init];
        _inputVoteTicketView.frame = [UIScreen mainScreen].bounds;
        _inputVoteTicketView.delegate = self;
    }
    return _inputVoteTicketView;
}
-(UIButton *)editBtn
{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc]init];
        [_editBtn setImage:[UIImage imageNamed: @"found_vote_edit"] forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"found_vote_finish"] forState:UIControlStateSelected];
        [_editBtn addTarget:self action:@selector(editStateChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
-(NSMutableArray *)voteArray
{
    if (!_voteArray) {
        _voteArray  =[NSMutableArray array];
    }
    return _voteArray;
}
-(NSMutableArray *)deleteArray
{
    if (!_deleteArray) {
        _deleteArray  =[NSMutableArray array];
    }
    return _deleteArray;
}
//-(HMWpwdPopupView *)pwdPopupV{
//    if (!_pwdPopupV) {
//        _pwdPopupV=[[HMWpwdPopupView alloc]init];
//        _pwdPopupV.frame = [UIScreen mainScreen].bounds;
//        _pwdPopupV.delegate=self;
//    }
//    return _pwdPopupV;
//}
-(UIImageView *)placeHolferImage{
    if (!_placeHolferImage) {
    _placeHolferImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"found_vote_empty_list"]];
    UILabel *textLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 160, 160, 40)];
    textLable.textColor=RGB(149, 159, 171);
    textLable.textAlignment=NSTextAlignmentCenter;
    textLable.text=NSLocalizedString(@"暂无候选节点", nil);
    [_placeHolferImage addSubview:textLable];
    }
    return _placeHolferImage;
}
-(void)setLastTimeArray:(NSMutableArray *)lastTimeArray{
    _lastTimeArray=lastTimeArray;
    
}
-(HWMTransactionDetailsView *)transactionDetailsView{
    
    if (!_transactionDetailsView) {
        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];
        _transactionDetailsView.delegate=self;
    }
    return _transactionDetailsView;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{
     NSString *walletId = [ELWalletManager share].currentWallet.masterWalletID;
    BOOL ret = [[ELWalletManager share]useMainchainSubWallet:walletId WithJsonString:self.jsonString pwd:pwd];
            
            if (ret) {
                [self closeTransactionDetailsView];
                [self showSendSuccessPopuV];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.sendSuccessPopuV removeFromSuperview];
                    self.sendSuccessPopuV=nil;
        
                  HMWtheSuperNodeElectionViewController*homeVC = [[HMWtheSuperNodeElectionViewController alloc] init];
                            UIViewController *target = nil;
                            for (UIViewController * controller in self.navigationController.viewControllers) {
                                if ([controller isKindOfClass:[homeVC class]]) {
                                    target = controller;
                                }
                            }
                            if (target) {
                                [self.navigationController popToViewController:target animated:YES];
                            }
                });
            }

    
}
-(void)closeTransactionDetailsView{
    
    [self.transactionDetailsView removeFromSuperview];
    self.transactionDetailsView=nil;
    
}
-(void)setPersent:(NSString *)persent{
    _persent=persent;
    
}
-(void)LoadInvalidCR{
        NSString *httpIP=[[FLTools share]http_IpFast];
        [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/listcrcandidates" header:@{} body:@{@"state":@"all"} showHUD:NO WithSuccessBlock:^(id data) {
            NSDictionary *param = data[@"data"];
            NSArray *dataArray =[NSArray modelArrayWithClass:HWMCRListModel.class json:param[@"result"][@"crcandidatesinfo"]];
           
            [self UpdataLocalOwerlistWirhArray:dataArray];
        } WithFailBlock:^(id data) {
            
        }];
}
-(void)UpdataLocalOwerlistWirhArray:(NSArray*)array{
       
        FLWallet *waller = [ELWalletManager share].currentWallet;
              IMainchainSubWallet *subWallet = [[ELWalletManager share]getWalletELASubWallet:waller.masterWalletID];
              Json cArray = subWallet->GetVotedCRList();
              NSString *dataStr = [NSString stringWithUTF8String:cArray.dump().c_str()];
              NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
              NSMutableArray *showlistdata = [NSMutableArray array];
      for (int i=0; i<array.count; i++) {
         HWMCRListModel *model = array[i];
        for (int j = 0;j<param.allKeys.count; j++) {
             NSString *itemKey = param.allKeys[j];
            if ([model.did isEqualToString:itemKey]&& (![model.state isEqualToString:@"Active"])) {
                [showlistdata addObject:model.did];
            }
        }
        
    }
    self.invalidCRArray=@[@{@"Type":@"CRC",
                           @"Candidates":showlistdata}];
}
@end
