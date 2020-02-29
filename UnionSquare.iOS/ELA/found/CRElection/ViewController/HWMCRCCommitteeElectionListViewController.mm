//
//  HWMCRCCommitteeElectionListViewController.m
//  elastos wallet
//
//  Created by  on 2019/9/5.
//

#import "HWMCRCCommitteeElectionListViewController.h"
#import "HWMVoteTheEditorialBoardTableViewCell.h"
#import "FLNotePointDBManager.h"
#import "HMWinputVotesPopupWindowView.h"
#import "ELWalletManager.h"
#import "HMWpwdPopupView.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HMWFMDBManager.h"
#import "HWMCRListModel.h"
#import "HWMTransactionDetailsView.h"
#import "HWMSignatureTradingSingleQrCodeViewController.h"
#import "HMWCRCommitteeMemberListViewController.h"



static NSString *cellString=@"HWMVoteTheEditorialBoardTableViewCell";
UINib *_cellCRNib;
@interface HWMCRCCommitteeElectionListViewController ()<UITableViewDelegate,UITableViewDataSource,HMWpwdPopupViewDelegate,VotesPopupViewDelegate,HMWToDeleteTheWalletPopViewDelegate,HWMVoteTheEditorialBoardTableViewCellDeleate,UITextFieldDelegate,HWMTransactionDetailsViewDelegate,HWMVoteTheEditorialBoardTableViewCellDeleate>
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;//交易成功 提示;
@property (weak, nonatomic) IBOutlet UILabel *TagtatolVoteLab;

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property(nonatomic,strong)UIImageView *placeHolferImage;

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIButton *editBtn;//右 btn

//下三uibutton
@property (weak, nonatomic) IBOutlet UIButton *immediatelyToVoteButton;

@property(nonatomic,strong)NSMutableArray *voteArray;
@property(nonatomic,strong)NSMutableArray *deleteArray;

@property(nonatomic,strong)HMWinputVotesPopupWindowView *inputVoteTicketView;//票数视图
@property(strong,nonatomic)HMWpwdPopupView *pwdPopupV;//密码视图
@property(nonatomic,assign)double ticket;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *persentLab;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *moreThan36View;
@property (weak, nonatomic) IBOutlet UILabel *TheAverageDistributionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *allTollTicketLabel;
@property (weak, nonatomic) IBOutlet UIButton *TheAverageDistributionButton;

@property (weak, nonatomic) IBOutlet UIImageView *TheAverageDistributionImageView;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isMax;
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *wallet;
/*
 *<# #>
 */
@property(strong,nonatomic)NSString *blaceString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * TheRemainingAvailable;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL WhetherTheAverage;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMTransactionDetailsView *transactionDetailsView;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelTopConSet;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *jsonString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *invalidDopsArray;/*
 *<# #>
 */
@property(copy,nonatomic)NSString *fee;


@end

@implementation HWMCRCCommitteeElectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"CR委员选举", nil);
    [self.immediatelyToVoteButton setTitle:NSLocalizedString(@"立即投票", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.immediatelyToVoteButton];
    self.TheAverageDistributionTextLabel.text=NSLocalizedString(@"全选均分", nil);
    [self getWalletType];
    [self getDBRecored];
    [self makeView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.editBtn];
    CGFloat proFlo=[[self.persent substringToIndex:self.persent.length-1]floatValue]/100;
    self.progress.progress = proFlo;
    self.TheRemainingAvailable=@"0";
    self.invalidDopsArray=[NSArray array];
    [self LoadInvalidDops];
  
 
}
-(void)getDBRecored{
   NSArray *DBRecoArray  = [[NSMutableArray alloc]initWithArray: [[HMWFMDBManager sharedManagerType:CRListType] allSelectCRWithWallID:self.wallet.masterWalletID ]];
    for (HWMCRListModel *model in self.lastArray) {
        
        for ( HWMCRListModel *lmodel in DBRecoArray) {
            if ([model.did isEqualToString:lmodel.did]) {
                model.SinceVotes=@"";
                model.TextVotes=@"";
                model.isCellSelected=NO;
                if ([model.state isEqualToString:@"Active"]) {
                [self.dataSource addObject:model];
                }
               
                
            }
        }
    }
    [self.baseTableView reloadData];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TableendEditing)];
    [self.baseTableView addGestureRecognizer:tap];
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(void)TableendEditing{
    [self.view endEditing:YES];
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
    ELWalletManager *manager   =  [ELWalletManager share];
          
          IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
        String balanceSt = mainchainSubWallet->GetBalance();
       NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
 
    self.inputVoteTicketView.votes =[[[FLTools share]elaScaleConversionWith: balanceString] doubleValue]-0.01;
    self.blaceString=[[FLTools share]CRVotingDecimalNumberBySubtracting:[[FLTools share]elaScaleConversionWith: balanceString] withCRMermVoting:@"0.01"];
   
    
    self.TagtatolVoteLab.text = [NSString stringWithFormat:@"%@%d ELA",NSLocalizedString(@"最大表决票权约：", nil),[self.blaceString intValue]];
    [self  UpdateTheRemainingAvailable];
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
    NSString * PnumberVotingString=[[FLTools share]CRVotingTheAverageDistribution:self.blaceString withCRMermVoting:[NSString stringWithFormat:@"%d",36]];
        self.WhetherTheAverage=YES;
       //    double PnumberVoting=[PnumberVotingString doubleValue];
       if (self.WhetherTheAverage) {
              self.TheRemainingAvailable=[[FLTools share]CRVotingDecimalNumberByMultiplying:PnumberVotingString withCRMermVoting:[NSString stringWithFormat:@"%d",36]];
           self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"all_selected"];
       }else{
           self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"found_vote_border"];
       self.TheRemainingAvailable=@"0";
           
                [self.voteArray removeAllObjects];
           }

    NSIndexPath *index;
        
   for (int i=0; i<36; i++) {
       index=[NSIndexPath indexPathForRow:i inSection:0];
         HWMCRListModel *model = self.dataSource[i];
        model.SinceVotes=PnumberVotingString;
       if (self.WhetherTheAverage) {
           model.isCellSelected=YES;
             [self.voteArray addObject:model];
          }else{
          model.isCellSelected=NO;

          }

       HWMVoteTheEditorialBoardTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:index];
       cell.model=model;
       cell.numberVotingTextField.text= model.SinceVotes;
       model.TextVotes=model.SinceVotes;
       self.dataSource[i]=model;
   }
        self.TheAverageDistributionButton.selected=YES;
   [self.baseTableView reloadData];
        [self UpdateTheRemainingAvailable];
        
    }else if (self.moreThan36View.deleteType==voteInvalidType){
        
            UIView *  mainView =[self mainWindow];
                   [mainView addSubview:self.transactionDetailsView];
                  [self.transactionDetailsView TransactionDetailsWithFee:self.fee withTransactionDetailsAumont:self.TheRemainingAvailable];
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
        //        Elastos::ElaWallet::BalanceType type = Elastos::ElaWallet::Total;
        String balanceSt = mainchainSubWallet->GetBalance();
        NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
        double balance=[balanceString doubleValue];
        self.inputVoteTicketView.votes =balance/unitNumber;
        if (self.inputVoteTicketView.votes<1) {
            self.inputVoteTicketView.accountBalanceLab.text =   [NSString stringWithFormat:@"%@ < 1 ELA",NSLocalizedString(@"最大表决票权", nil)];
        }else{
           self.inputVoteTicketView.accountBalanceLab.text =   [NSString stringWithFormat:@"%@%.0f ELA",NSLocalizedString(@"最大表决票权约：", nil),self.inputVoteTicketView.votes];
        }
     
        [self  UpdateTheRemainingAvailable];
        
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
        
        if (self.dataSource.count>36) {
            [self  selectMoreThan36];
            return;
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
    
    self.WhetherTheAverage=NO;
    [self.voteArray removeAllObjects];
    [self.baseTableView reloadData];
    [self updataBottomBtn];
}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    self.baseTableView.rowHeight=130;
    self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _cellCRNib=[UINib nibWithNibName:cellString bundle:nil];

  
    [self.baseTableView registerNib:_cellCRNib forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.baseTableView.allowsMultipleSelection = YES;
    
    [self.view addSubview:self.placeHolferImage];
//    CGPoint certer=self.baseTableView.center;
//    certer.x=certer.x;
    self.placeHolferImage.center =self.view.center;
    self.placeHolferImage.hidden = self.dataSource.count!=0;
    if (self.editBtn.isEnabled==NO&&self.dataSource.count==0) {
        
    }
    
    self.baseTableView.backgroundColor=[UIColor clearColor];
    [self updataBottomBtn];
}

-(void)updataBottomBtn{
//    self.hasSelectNumber.text = [NSString stringWithFormat:@"%lu %@",(unsigned long)self.voteArray.count,NSLocalizedString(@"已选择", nil)];
//    [self.selectAllBtn  setTitle:[NSString stringWithFormat:@"%@(%lu/%ld)",NSLocalizedString(@"全选", nil), self.voteArray.count,self.dataSource.count] forState:UIControlStateNormal]  ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      HWMVoteTheEditorialBoardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    HWMCRListModel *model = self.dataSource[indexPath.row];
    model.voterate=[[FLTools share]CRVotingPercentageWithAllCount:self.totalvotes withCRMermVoting:model.votes];
    cell.deleagte=self;
    cell.index=indexPath;
    cell.numberVotingTextField.tag=100+indexPath.row;
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}

-(void)editStateChange:(UIButton*)btn{
    self.editBtn.selected = !self.editBtn.isSelected;
    NSString *title = self.editBtn.isSelected ?NSLocalizedString(@"删除", nil):NSLocalizedString(@"立即投票", nil);
    [self.immediatelyToVoteButton setTitle:title forState:UIControlStateNormal];
    if (self.editBtn.selected) {
 
        self.allTollTicketLabel.alpha=0.f;
        [self.immediatelyToVoteButton setTitle:NSLocalizedString(@"删除", nil) forState:UIControlStateNormal];
        self.textLabelTopConSet.constant=20.f;
        self.TheAverageDistributionTextLabel.text=NSLocalizedString(@"全选", nil);
    }else{
        self.TheRemainingAvailable=@"0";
         [self UpdateTheRemainingAvailable];
        self.allTollTicketLabel.alpha=1.f;
        [self.immediatelyToVoteButton setTitle:NSLocalizedString(@"立即投票", nil) forState:UIControlStateNormal];
        self.textLabelTopConSet.constant=10.f;
         self.TheAverageDistributionTextLabel.text=NSLocalizedString(@"全选均分", nil);
    }
    
        for (int i=0; i<self.dataSource.count; i++) {
           NSIndexPath * index=[NSIndexPath indexPathForRow:i inSection:0];
          HWMCRListModel *model = self.dataSource[i];
           model.isCellSelected=NO;
            model.SinceVotes=@"";
            model.TextVotes=@"";
            self.dataSource[i]=model;
            HWMVoteTheEditorialBoardTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:index];
                   cell.model=model;
               cell.numberVotingTextField.text=nil;
        }
  
         self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"found_vote_border"];
    [self clearVoteArray];
    
    
    
}

#pragma mark 代理
-(void)didHadInputVoteTicket:(NSString *)ticketNumer WithIsMax:(BOOL)isMax
{
    self.isMax=isMax;
    [self.inputVoteTicketView removeFromSuperview];
    self.inputVoteTicketView= nil;
    self.ticket = [ticketNumer doubleValue];
    [self.view.window addSubview:self.pwdPopupV];
    
}
-(void)cancelThePWDPageView
{
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV  = nil;
}
//-(void)makeSureWithPWD:(NSString*)pwd{
//    NSMutableArray *stringArray = [NSMutableArray array];
//    for (int i= 0; i<self.voteArray.count; i++) {
//        FLCoinPointInfoModel *model = self.voteArray[i];
//        [stringArray addObject:model.ownerpublickey];
//    }
//    NSString *walletId = [ELWalletManager share].currentWallet.masterWalletID;
//    double tic=self.ticket;
//    if (self.isMax) {
//        tic=-1;
//    }
//    BOOL ret = [[ELWalletManager share]useMainchainSubWallet:walletId ToVote:stringArray tickets:tic pwd:pwd isChangeVote:YES];
//    if (ret) {
//        [self showSendSuccessPopuV];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.sendSuccessPopuV removeFromSuperview];
//            self.sendSuccessPopuV=nil;
//        });
//    }
//    [self.pwdPopupV removeFromSuperview];
//    self.pwdPopupV =  nil;
//}
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
-(HMWpwdPopupView *)pwdPopupV{
    if (!_pwdPopupV) {
        _pwdPopupV=[[HMWpwdPopupView alloc]init];
        _pwdPopupV.frame = [UIScreen mainScreen].bounds;
        _pwdPopupV.delegate=self;
    }
    return _pwdPopupV;
    
}
-(UIImageView *)placeHolferImage
{
    if (!_placeHolferImage) {
        _placeHolferImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"found_vote_empty_list"]];
        UILabel *textLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 160, 160, 40)];
        textLable.textColor=RGB(149, 159, 171);
        textLable.textAlignment=NSTextAlignmentCenter;
        textLable.text=NSLocalizedString(@"暂无候选委员", nil);
        [_placeHolferImage addSubview:textLable];
    }
    return _placeHolferImage;
    
}
- (IBAction)TheAverageDistributionImageViewEvent:(id)sender {
    if (self.dataSource.count==0) {
          return;
      }
    
   
    self.WhetherTheAverage=!self.WhetherTheAverage;
    if (self.editBtn.isSelected) {
        for (int i=0; i<self.dataSource.count; i++) {
           NSIndexPath * index=[NSIndexPath indexPathForRow:i inSection:0];
          HWMCRListModel *model = self.dataSource[i];
        if (self.WhetherTheAverage) {
            model.isCellSelected=YES;
           }else{
           model.isCellSelected=NO;
           }
            model.SinceVotes=@"0";
            self.dataSource[i]=model;
            HWMVoteTheEditorialBoardTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:index];
                   cell.model=model;
               cell.numberVotingTextField.text=nil;
        }
        if (self.WhetherTheAverage) {
             [self.voteArray removeAllObjects];
         self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"all_selected"];
            [self.voteArray addObjectsFromArray:self.dataSource];
         }else{
             [self.voteArray removeAllObjects];
             self.TheRemainingAvailable=@"";
         self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"found_vote_border"];
             
         }
         
        return;
    }
    if ([self.blaceString doubleValue]<0) {
           [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
           return;
       }
    NSIndexPath *index;
    if (self.dataSource.count>36) {
        if (self.WhetherTheAverage) {
             [self selectMoreThan36];
             
         }else{
             self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"found_vote_border"];
             for (int i=0; i<self.dataSource.count; i++) {
                 index=[NSIndexPath indexPathForRow:i inSection:0];
                   HWMCRListModel *model = self.dataSource[i];
                  model.SinceVotes=@"";
                  model.TextVotes=@"";
                 if (self.WhetherTheAverage) {
                     model.isCellSelected=YES;
                       [self.voteArray addObject:model];
                    }else{
                    model.isCellSelected=NO;
             
                    }

                 HWMVoteTheEditorialBoardTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:index];
                 cell.model=model;
                 cell.numberVotingTextField.text= model.SinceVotes;
                 self.dataSource[i]=model;
             }
                   self.TheRemainingAvailable=@"";
                 [self.baseTableView reloadData];
                 [self UpdateTheRemainingAvailable];
             }
             
    }else{
        NSString * PnumberVotingString=[[FLTools share]CRVotingTheAverageDistribution:self.blaceString withCRMermVoting:[NSString stringWithFormat:@"%ld",self.dataSource.count]];
        //    double PnumberVoting=[PnumberVotingString doubleValue];
    self.TheRemainingAvailable=[[FLTools share]CRVotingDecimalNumberByMultiplying:PnumberVotingString withCRMermVoting:[NSString stringWithFormat:@"%ld",self.dataSource.count]];
    for (int i=0; i<self.dataSource.count; i++) {
        index=[NSIndexPath indexPathForRow:i inSection:0];
          HWMCRListModel *model = self.dataSource[i];
         model.SinceVotes=PnumberVotingString;
        if (self.WhetherTheAverage) {
            model.isCellSelected=YES;
             model.TextVotes=model.SinceVotes;
//              [self.voteArray addObject:model];
           }else{
           model.isCellSelected=NO;
            model.TextVotes=@"";
               model.SinceVotes=@"";
    
           }

        HWMVoteTheEditorialBoardTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:index];
        cell.model=model;
        cell.numberVotingTextField.text= model.SinceVotes;
        self.dataSource[i]=model;
    }
     
        if (self.WhetherTheAverage) {
            [self.voteArray removeAllObjects];
        self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"all_selected"];
           [self.voteArray addObjectsFromArray:self.dataSource];
        }else{
            [self.voteArray removeAllObjects];
            self.TheRemainingAvailable=@"";
        self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"found_vote_border"];
        }
        [self.baseTableView reloadData];
        [self UpdateTheRemainingAvailable];
    }
    [self.baseTableView reloadData];
    [self UpdateTheRemainingAvailable];
       
    
}
-(void)UpdateTheRemainingAvailable{
    NSString *TheRemainingAvailableString=@"0";
    for (HWMCRListModel *model in self.voteArray) {
        TheRemainingAvailableString =[[FLTools share]CRVotingDecimalNumberByAdding:model.SinceVotes withCRMermVoting:TheRemainingAvailableString];
    }
    if ([TheRemainingAvailableString isEqualToString:@"0"]||self.TheRemainingAvailable.length==0||[[FLTools share]isBlankString:self.TheRemainingAvailable]||[TheRemainingAvailableString isEqualToString:@"NaN"]) {
        self.TheRemainingAvailable=@"0";
         self.allTollTicketLabel.text=[NSString stringWithFormat:@"%@ 0 ELA",NSLocalizedString(@"合计：",nil )];
    }else{
        self.TheRemainingAvailable=TheRemainingAvailableString;
        self.allTollTicketLabel.text=[NSString stringWithFormat:@"%@ %@ ELA",NSLocalizedString(@"合计：",nil ), self.TheRemainingAvailable];}
        NSString * availableString=[[FLTools share]CRVotingDecimalNumberBySubtracting:self.blaceString withCRMermVoting: self.TheRemainingAvailable];
    if ([availableString intValue]<1) {
          self.persentLab.text=[NSString stringWithFormat:@"%@ <1 ELA",NSLocalizedString(@"可用：",nil )];
    }else{
        self.persentLab.text=[NSString stringWithFormat:@"%@ %d ELA",NSLocalizedString(@"可用：",nil ),[availableString intValue]];
        
    }
    if (self.editBtn.isSelected) {
        if (self.dataSource.count>0&&self.dataSource.count==self.voteArray.count) {
                   self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"all_selected"];
             }else{
                 self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"found_vote_border"];
             }
    }
     
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
#pragma mark ---------HWMVoteTheEditorialBoardTableViewCell----------

-(void)addVoteWithIndex:(NSIndexPath *)index withVotes:(NSString *)votes{

     HWMCRListModel*model = self.dataSource[index.row];
     if ([self.voteArray containsObject:model]) {
         model.SinceVotes=@"";
         if ([votes isEqualToString:@"0"]) {
             
         }
         model.isCellSelected=NO;
         [self.voteArray removeObject:model];
          self.TheAverageDistributionImageView.image=[UIImage imageNamed:@"found_vote_border"];
         self.WhetherTheAverage=NO;
        
     }else{
         model.SinceVotes=votes;
         model.isCellSelected=YES;
         [self.voteArray addObject:model];
     }
    NSString *RemainingAvailableString;
    if (model.isCellSelected){
       RemainingAvailableString=[[FLTools share] CRVotingDecimalNumberByAdding:self.TheRemainingAvailable withCRMermVoting:votes];
    }else{
       RemainingAvailableString= [[FLTools share] CRVotingDecimalNumberBySubtracting:self.TheRemainingAvailable withCRMermVoting:votes];
    }
   self.dataSource[index.row]=model;
    self.TheRemainingAvailable=RemainingAvailableString;
    [self UpdateTheRemainingAvailable];
 
    [self.baseTableView reloadData];
}

- (IBAction)ImmediatelyToVote:(id)sender {
    
    
    
    if (self.editBtn.isSelected){
        if (self.voteArray.count==0) {
            return;
        }
        
        BOOL ret;
        for (HWMCRListModel *model in self.voteArray) {
         ret=  [[HMWFMDBManager sharedManagerType:CRListType]delectSelectCR:model WithWalletID:self.wallet.masterWalletID];
            [self.dataSource removeObject:model];
        }
        if (ret) {
            [[FLTools share]showErrorInfo:@"删除成功"];
            if (self.dataSource.count==0) {
                [self updatePlaceHoldInfo];
            }
            [self clearVoteArray];
        }else{
             [[FLTools share]showErrorInfo:@"删除失败"];
        }
        return;
    }
    
    if (self.voteArray.count == 0||[self.TheRemainingAvailable isEqualToString:@"0"]) {
                return;
            }
    if ([self.TheRemainingAvailable doubleValue]>[self.blaceString doubleValue]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"余额不足", nil)];
        return;
    }
    if (self.voteArray.count>36) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"最多可选36个节点", nil)];
                return;
            }
    NSMutableDictionary *CRDic=[[NSMutableDictionary alloc]init];
    for (int i= 0; i<self.voteArray.count; i++) {
      
        HWMCRListModel *model=self.voteArray[i];
        if ([model.SinceVotes doubleValue]>0) {
            NSDictionary *dic=@{model.did:[[FLTools share]elsToSela:model.SinceVotes]};
         [CRDic addEntriesFromDictionary:dic];
        }
    }
    
        if (CRDic==NULL) {
     
             return;
         }

        NSDictionary *dic =[[ELWalletManager share]CRVoteFeeCRMainchainSubWallet:self.wallet.masterWalletID ToVote:CRDic tickets: 0 withInvalidIDArray:self.invalidDopsArray];


    self.fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",dic[@"fee"]]];
 
    
self.jsonString=dic[@"JSON"];

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
    UIView *mainView =[self mainWindow];
    [mainView addSubview:self.transactionDetailsView];
    [self.transactionDetailsView TransactionDetailsWithFee:self.fee withTransactionDetailsAumont:self.TheRemainingAvailable];
    [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(mainView);
    }];
      
  }
}
-(HWMTransactionDetailsView *)transactionDetailsView{
    
    if (!_transactionDetailsView) {
        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];
        _transactionDetailsView.delegate=self;
    }
    return _transactionDetailsView;
}
#pragma mark ---------HWMTransactionDetailsView----------
-(void)closeTransactionDetailsView{
    [self.transactionDetailsView removeFromSuperview];
    self.transactionDetailsView=nil;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{
    
    
  
    
    NSString *pwdString=pwd;
    NSMutableArray *stringArray = [NSMutableArray array];
    NSMutableDictionary *CRDic=[[NSMutableDictionary alloc]init];
    for (int i= 0; i<self.voteArray.count; i++) {
        HWMCRListModel *model=self.voteArray[i];
        
        NSDictionary *dic=@{model.did: [NSString stringWithFormat:@"%.0f",[model.SinceVotes doubleValue]*unitNumber]};

    [CRDic addEntriesFromDictionary:dic];
    }
    double  tic=[self.TheRemainingAvailable doubleValue];
//    if (self.isMax) {
//        tic=-1;
//    }
    if (self.wallet.TypeW==0) {
        NSString *walletId = [ELWalletManager share].currentWallet.masterWalletID;
        BOOL ret = [[ELWalletManager share]useCRMainchainSubWallet:walletId WithJosnString:self.jsonString withPWD:pwd];
        if (ret) {
            [self closeTransactionDetailsView];
            [self showSendSuccessPopuV];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.sendSuccessPopuV removeFromSuperview];
                self.sendSuccessPopuV=nil;
                
            });
           HMWCRCommitteeMemberListViewController *homeVC = [[HMWCRCommitteeMemberListViewController alloc] init];
                    UIViewController *target = nil;
                    for (UIViewController * controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[homeVC class]]) {
                            target = controller;
                        }
                    }
                    if (target) {
                        [self.navigationController popToViewController:target animated:YES];
                    }
            
        }
        [self.pwdPopupV removeFromSuperview];
        self.pwdPopupV =  nil;
    }else if (self.wallet.TypeW==1){
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",tic],pwdString,@(1)] callbackId:self.wallet.masterWalletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]SignReadOnlyToCR:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]){
            [self closeTransactionDetailsView];
            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
              SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
            SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
            NSDictionary *successDic=[[NSDictionary alloc]initWithDictionary:result.message[@"success"]]; SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:successDic];
           SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
            SignatureTradingSingleQrCodeVC.subW=@"ELA";
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
    }else if (self.wallet.TypeW==2){
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",tic],pwdString,@(1)] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]HowSignToCR:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
            [self closeTransactionDetailsView];
            [self.pwdPopupV removeFromSuperview];
            self.pwdPopupV =  nil;
            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
               SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
            SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
            SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:result.message[@"success"]];
           SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"]; SignatureTradingSingleQrCodeVC.subW=@"ELA";
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
    }else if (self.wallet.TypeW==3){
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",tic],pwdString,@(1)] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]SignReadOnlyToCR:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
            [self closeTransactionDetailsView];
            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
               SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
            SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
            SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:result.message[@"success"]];
            SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
            SignatureTradingSingleQrCodeVC.subW=@"ELA";
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
    }
}
-(void)updatePlaceHoldInfo{
     self.placeHolferImage.hidden = self.dataSource.count!=0;
    if (self.dataSource.count==0) {
        self.editBtn.alpha=0;
        self.TagtatolVoteLab.alpha=0.f;
        self.persentLab.alpha=0.f;
        if (self.editBtn.isSelected) {
            [self editStateChange:self.editBtn];
        }
    self.allTollTicketLabel.text=[NSString stringWithFormat:@"%@ %@ ELA",NSLocalizedString(@"合计：",nil ),@"--"];
        
      }
    
}
-(void)textFieldDidEnd:(UITextField*)text{
    NSInteger tag=[text tag];
       NSIndexPath *index=[NSIndexPath indexPathForRow:tag-100 inSection:0];
       HWMCRListModel *model=self.dataSource[index.row];
        model.TextVotes=text.text;
       if (model.isCellSelected) {
          if ([self.voteArray containsObject:model]) {
              self.TheRemainingAvailable=[[FLTools share]CRVotingDecimalNumberBySubtracting:self.TheRemainingAvailable withCRMermVoting:model.SinceVotes];
          }
        
            model.SinceVotes=text.text;
           self.TheRemainingAvailable=[[FLTools share]CRVotingDecimalNumberByAdding:self.TheRemainingAvailable withCRMermVoting:model.SinceVotes];
       }
    [self UpdateTheRemainingAvailable];
     self.dataSource[index.row]=model;
    
    
}
-(void)setLastArray:(NSArray *)lastArray{
    _lastArray=lastArray;
}
-(void)setTotalvotes:(NSString *)totalvotes{
    _totalvotes=totalvotes;
}
-(void)LoadInvalidDops{
        NSString *httpIP=[[FLTools share]http_IpFast];
        [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/listproducer" header:@{} body:@{@"moreInfo":@"1",@"state":@"all"} showHUD:NO WithSuccessBlock:^(id data) {
            NSDictionary *param = data[@"data"];
            NSArray *dataArray =[NSArray modelArrayWithClass:FLCoinPointInfoModel.class json:param[@"result"][@"producers"]];
           
            [self UpdataLocalOwerlistWirhArray:dataArray];
        } WithFailBlock:^(id data) {
            
        }];
}
-(void)UpdataLocalOwerlistWirhArray:(NSArray*)array{
        FLWallet *waller = [ELWalletManager share].currentWallet;
              IMainchainSubWallet *subWallet = [[ELWalletManager share]getWalletELASubWallet:waller.masterWalletID];
              Json cArray = subWallet->GetVotedProducerList();
              NSString *dataStr = [NSString stringWithUTF8String:cArray.dump().c_str()];
              NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
              NSMutableArray *showlistdata = [NSMutableArray array];
      for (int i=0; i<array.count; i++) {
         FLCoinPointInfoModel *model = array[i];
        for (int j = 0;j<param.allKeys.count; j++) {
             NSString *itemKey = param.allKeys[j];
            if ([model.nodepublickey isEqualToString:itemKey]) {
                
                if (![model.state isEqualToString:@"Active"]) {
                    [showlistdata addObject:model.nodepublickey];
                }

            }
        }
    }
    self.invalidDopsArray=@[@{@"Type":@"Delegate",
                           @"Candidates":showlistdata}];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.delegate) {
         [self.delegate needUpdataSta];
   }
}
@end
