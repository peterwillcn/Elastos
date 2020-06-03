//
//  FLChangeVotedTicketsVC.m
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/2/14.
//

#import "FLChangeVotedTicketsVC.h"
#import "HMWpwdPopupView.h"
#import "FLCoinPointInfoModel.h"
#import "ELWalletManager.h"
#import "HMWtheCandidateListTableViewCell.h"
#import "HMWinputVotesPopupWindowView.h"
#import "FLNotePointDBManager.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HMWFMDBManager.h"
#import "HWMSignatureTradingSingleQrCodeViewController.h"

static NSString *cellString=@"HMWtheCandidateListTableViewCell";

@interface FLChangeVotedTicketsVC ()<UITableViewDelegate,UITableViewDataSource,VotesPopupViewDelegate,HMWpwdPopupViewDelegate,HMWToDeleteTheWalletPopViewDelegate>
//@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;//交易成功 提示;

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property(nonatomic,strong)UIImageView *placeHolferImage;


//下三uibutton
@property (weak, nonatomic) IBOutlet UILabel *hasSelectNumber;
@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *immediatelyChangeBtn;

@property(nonatomic,strong)NSMutableArray *voteArray;

@property(nonatomic,strong)HMWinputVotesPopupWindowView *inputVoteTicketView;//票数视图
@property(strong,nonatomic)HMWpwdPopupView *pwdPopupV;//密码视图
@property(nonatomic,assign)double ticket;
@property(nonatomic,strong)NSMutableArray *dataSource;
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
@end

@implementation FLChangeVotedTicketsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"重新投票",nil);
    [self.immediatelyChangeBtn setTitle:NSLocalizedString(@"重新投票",nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.immediatelyChangeBtn];
    [self getDBRecored];
    [self makeView];
     [self.selectAllBtn setImage:[UIImage imageNamed:@"found_vote_selected"] forState:UIControlStateSelected];
     [self.selectAllBtn setImage:[UIImage imageNamed:@"found_vote_border"] forState:UIControlStateNormal];
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self defultWhite];
}
-(HMWToDeleteTheWalletPopView *)moreThan36View{
    if (!_moreThan36View) {
        _moreThan36View =[[HMWToDeleteTheWalletPopView alloc]init];
        _moreThan36View.delegate=self;
        _moreThan36View.deleteType=moreThan36SelectList;
    }
    return _moreThan36View;
}
-(void)selectMoreThan36{
    UIView *maView=[self mainWindow];
    [maView addSubview:self.moreThan36View];
    [self.moreThan36View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(maView);
    }];
  
    
}
#pragma mark ---------HMWToDeleteTheWalletPopViewDelegate----------
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    [self clearVoteArray];
    for (int i= 0; i<36; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        [self.baseTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.baseTableView didSelectRowAtIndexPath:index];
    }
    self.selectAllBtn.selected=YES;
    [self toCancelOrCloseDelegate];
}
-(void)toCancelOrCloseDelegate{
    [self.moreThan36View removeFromSuperview];
    self.moreThan36View=nil;
}
-(void)getDBRecored{
    self.dataSource  = [[NSMutableArray alloc]initWithArray: [[FLNotePointDBManager defultWithWalletID:self.wallet.masterWalletID]allRecord]];
    [self.baseTableView reloadData];
}
- (IBAction)actAction:(UIButton*)sender {
        if (self.voteArray.count == 0) {
            return;
        }
    if (self.voteArray.count>36) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"最多可选36个节点", nil)];
        return;
    }
    
    [self.view.window addSubview:self.inputVoteTicketView];
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    String balanceSt = mainchainSubWallet->GetBalance();
    NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
    NSInteger balance=[balanceString integerValue];
    self.inputVoteTicketView.votes = balance/unitNumber;
    self.inputVoteTicketView.accountBalanceLab.text = [NSString stringWithFormat:@"%@%@  ELA",NSLocalizedString(@"最大表决票权", nil),[[FLTools share]elaScaleConversionWith: balanceString]];
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
    
//    [self.baseTableView addSubview:self.placeHolferImage];
//    self.placeHolferImage.center = self.baseTableView.center;
//    self.placeHolferImage.hidden = self.dataSource.count!=0;
    [self updataBottomBtn];

}

-(void)updataBottomBtn{
    
    self.hasSelectNumber.text = [NSString stringWithFormat:@"%ld %@",self.voteArray.count,NSLocalizedString(@"已选择", nil)];
    [self.selectAllBtn  setTitle:[NSString stringWithFormat:@"%@(%ld/%ld)",NSLocalizedString(@"全选", nil),self.voteArray.count,self.dataSource.count] forState:UIControlStateNormal]  ;
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
    
    [self updataBottomBtn];
   
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLCoinPointInfoModel *model = self.dataSource[indexPath.row];
    if ([self.voteArray containsObject:model]) {
        [self.voteArray removeObject:model];
    }
    [self updataBottomBtn];
}



#pragma mark 代理
-(void)didHadInputVoteTicket:(NSString *)ticketNumer WithIsMax:(BOOL)isMax
{
    self.isMax=isMax;
    [self.inputVoteTicketView removeFromSuperview];
    self.inputVoteTicketView= nil;
    self.ticket = [ticketNumer doubleValue];
    if (self.wallet.TypeW==0) {
        [self.view.window addSubview:self.pwdPopupV];
    }else if (self.wallet.TypeW==1){
        [self makeSureWithPWD:@""];
    }else if (self.wallet.TypeW==2){
        [self.view.window addSubview:self.pwdPopupV];
    }else if (self.wallet.TypeW==3){
        [self makeSureWithPWD:@""];
    }

}
-(void)cancelThePWDPageView
{
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV  = nil;
}
-(void)makeSureWithPWD:(NSString*)pwd{
    
    NSMutableArray *stringArray = [NSMutableArray array];
    for (int i= 0; i<self.voteArray.count; i++) {
        FLCoinPointInfoModel *model = self.voteArray[i];
        [stringArray addObject:model.ownerpublickey];
    }
//    NSInteger tic=self.ticket;
    if (self.isMax) {
        self.ticket=-1;
    }
    if (self.wallet.TypeW==0) {
        NSString *walletId = [ELWalletManager share].currentWallet.masterWalletID;
        BOOL ret = [[ELWalletManager share]useMainchainSubWallet:walletId ToVote:stringArray tickets:self.ticket pwd:pwd isChangeVote:YES withInvalidIDArray:self.invalidCRArray];
        if (ret) {
          [[FLTools share]showErrorInfo:NSLocalizedString(@"变更成功",nil)];
        }
        [self.pwdPopupV removeFromSuperview];
        self.pwdPopupV =  nil;
     }else if (self.wallet.TypeW==1){
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",self.ticket],pwd,@(1)] callbackId:self.wallet.masterWalletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]SignReadOnlyToVote:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]){
            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
            SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
            SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
            NSDictionary *successDic=[[NSDictionary alloc]initWithDictionary:result.message[@"success"]]; SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:successDic];
            SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
            SignatureTradingSingleQrCodeVC.subW=@"ELA";
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
     }else if (self.wallet.TypeW==2){
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",self.ticket],pwd,@(1)] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]HowSignToVote:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
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
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,stringArray,[NSString stringWithFormat:@"%f",self.ticket],pwd,@(1)] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
        PluginResult *result = [[ELWalletManager share]SignReadOnlyToVote:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]) {
            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
            SignatureTradingSingleQrCodeVC.currentWallet=self.wallet;
            SignatureTradingSingleQrCodeVC.type=HowSignToBeSigned;
            SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:result.message[@"success"]];
            SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
            SignatureTradingSingleQrCodeVC.subW=@"ELA";
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        }
    }
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV =  nil;
    [self.voteArray removeAllObjects];
    [self updataBottomBtn];
    [self.baseTableView reloadData];
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
-(NSMutableArray *)voteArray
{
    if (!_voteArray) {
        _voteArray  =[NSMutableArray array];
    }
    return _voteArray;
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
    }
    return _placeHolferImage;
    
}
-(void)setInvalidCRArray:(NSArray *)invalidCRArray{
    _invalidCRArray=invalidCRArray;
}

@end
