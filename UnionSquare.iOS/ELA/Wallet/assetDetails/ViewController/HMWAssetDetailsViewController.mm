//
//  HMWAssetDetailsViewController.m
//  ELA
//
//  Created by 韩铭文 on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWAssetDetailsViewController.h"
#import "HMWAssetDetailsTableViewCell.h"
#import "HMWcollectionViewController.h"
#import "HMWtransferViewController.h"
#import "HMWChooseSideChainViewController.h"
#import "HMWtransferTransactionDetailsViewController.h"
#import "assetDetailsModel.h"
#import "HMWTop_upPageForDetailsViewController.h"


#import <Cordova/CDV.h>
#import "ELWalletManager.h"



static NSString *cellString=@"HMWAssetDetailsTableViewCell";



@interface HMWAssetDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UIButton *topUpButton;

@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightOff;

@property (weak, nonatomic) IBOutlet UILabel *noDataSourceTextLabel;

/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger currentIndex;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger allTotal;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *allListArray;

/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isUpdate;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger allTotalMAXCount;
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *allAddressAaary;
@property (weak, nonatomic) IBOutlet UILabel *transactionRecordsTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteBlanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *voteElaLabel;
@property (weak, nonatomic) IBOutlet UILabel *allBlanceTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteBlanceTextLabel;

@end

@implementation HMWAssetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self defultWhite];
   [self setBackgroundImg:@"asset_bg"];
    [self makeView];
//    if ([ self.model.iconName isEqualToString:@"ELA"]) {
//        self.allBlanceTextLabel.alpha=1.f;
//        self.allBlanceTextLabel.text=NSLocalizedString(@"总额:", nil);
//        self.voteBlanceTextLabel.alpha=1.f;
//        self.voteBlanceTextLabel.text=NSLocalizedString(@"投票占用:", nil);
//        self.voteBlanceLabel.alpha=1.f;
//        
//        self.voteElaLabel.alpha=1.f; self.viewHeightOff.constant=111;
//        [self lockVoiteLoadDataSource];
//    }
    self.isUpdate=NO;
    self.balanceLabel.text=[NSString stringWithFormat:@"%@",[[FLTools share]elaScaleConversionWith: self.model.iconBlance]];
//    self.currencyNameLabel.text=self.model.iconName;
    self.currencyNameLabel.text=@"ELA";
    self.updateTimeLabel.text=self.model.updateTime;
    self.currentIndex=0;
    [self loadAllTransactionWithIndex:self.currentIndex];
    
    [self.transferButton setTitle:NSLocalizedString(@"转账", nil) forState:UIControlStateNormal];
     [self.collectionButton setTitle:NSLocalizedString(@"收款", nil) forState:UIControlStateNormal];
    self.transactionRecordsTextLabel.text=NSLocalizedString(@"交易记录", nil);
    self.topUpButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
  self.noDataSourceTextLabel.text=NSLocalizedString(@"暂无交易记录", nil);
   
}

-(void)lockVoiteLoadDataSource{
    
    CDVInvokedUrlCommand *mommand=[[CDVInvokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@0] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getBalance"];
    CDVPluginResult * result =[[ELWalletManager share]getBalance:mommand];
    
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]){
        
        
        
          NSString *blanceString=[NSString stringWithFormat:@"%@",result.message[@"success"]];
        
        self.voteBlanceLabel.text=[NSString stringWithFormat:@"%@",[[FLTools share] elaScaleConversionWith:blanceString ]];
        
    }
    
}
-(NSMutableArray *)allListArray{
    if (!_allListArray) {
        _allListArray =[[NSMutableArray alloc]init];
    }
    return _allListArray;
}

-(void)loadAllTransactionWithIndex:(NSInteger)index{
    CDVInvokedUrlCommand *mommand=[[CDVInvokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@(index),@"20",@""] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllTransaction"];
    CDVPluginResult * result =[[ELWalletManager share]getAllTransaction:mommand];
//    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if (self.isUpdate) {
        [self.allListArray removeAllObjects];
    }
//    self.allTotalMAXCount=[result.message[@"success"][@"MaxCount"] integerValue];
        NSInteger a=[result.message[@"success"][@"MaxCount"] integerValue];
    self.allTotal=a;
    NSArray *tranList=[NSArray modelArrayWithClass:assetDetailsModel.class json:result.message[@"success"][@"Transactions"]];
    self.currentIndex=self.currentIndex+tranList.count;
    [self.allListArray addObjectsFromArray:tranList];
    if (self.allListArray.count==0) {
        self.noDataSourceTextLabel.alpha=1.f;
    }else{
        self.noDataSourceTextLabel.alpha=0.f;
        
    }
    [self.baseTableView reloadData];
    [self  baseTableViewEndRF];
    
}
- (IBAction)transferEvent:(id)sender {
    self.transferButton.userInteractionEnabled=NO;
    HMWtransferViewController *transferVC=[[HMWtransferViewController alloc]init];
    transferVC.currentWallet=self.currentWallet;
    transferVC.model=self.model;
    
    if (self.allAddressAaary.count==0) {
        self.allAddressAaary=nil;
//        return;
    }
    transferVC.addressArray=self.allAddressAaary;
    transferVC.supportOfTheCurrencyArray=self.supportOfTheCurrencyArray;
    [self.navigationController pushViewController:transferVC animated:YES];
    self.transferButton.userInteractionEnabled=YES;
}
- (IBAction)top_upEvent:(id)sender {
    
    if (![self.title isEqualToString:@"ELA"]) {
        HMWTop_upPageForDetailsViewController *top_upPageForDetailsVC=[[HMWTop_upPageForDetailsViewController alloc]init];
        top_upPageForDetailsVC.title=NSLocalizedString(@"主链提现", nil);
        top_upPageForDetailsVC.selectmModel=self.elaModel;
        top_upPageForDetailsVC.currentWallet=self.currentWallet;
        top_upPageForDetailsVC.fromModel=self.model;
        top_upPageForDetailsVC.type=mainChainWithdrawalType;
        top_upPageForDetailsVC.substringAddress=self.allAddressAaary.firstObject;
        [self.navigationController pushViewController:top_upPageForDetailsVC animated:YES];
        
        
    }else{
    HMWChooseSideChainViewController *chooseSideChainVC=[[HMWChooseSideChainViewController alloc]init];
    chooseSideChainVC.title=self.topUpButton.titleLabel.text;
    
    chooseSideChainVC.currentWallet=self.currentWallet;
    chooseSideChainVC.model=self.model;
    chooseSideChainVC.type=chooseSideChainType;
    chooseSideChainVC.addressArray=self.allAddressAaary;
    chooseSideChainVC.supportOfTheCurrencyArray=self.supportOfTheCurrencyArray;
        [self.navigationController pushViewController:chooseSideChainVC animated:YES];
        
    }
}
- (IBAction)collectionEvent:(id)sender {
    self.collectionButton.userInteractionEnabled=NO;
        CDVInvokedUrlCommand *mommand=[[CDVInvokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.elaModel.iconName] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"createAddress"];
        CDVPluginResult * result =[[ELWalletManager share]createAddress:mommand];
        NSString *status=[NSString stringWithFormat:@"%@",result.status];
        if ([status isEqualToString:@"1"]) {
            HMWcollectionViewController*collectionVC=[[HMWcollectionViewController alloc]init];
            NSArray *addrestStringArray=[NSArray arrayWithArray:self.allAddressAaary];
            if (addrestStringArray.count==0) {
                self.allAddressAaary=nil;
            }
            collectionVC.addrestStringArray=self.allAddressAaary;
            collectionVC.iconAddress=[NSString stringWithFormat:@"%@",result.message[@"success"]];
            [self.navigationController pushViewController:collectionVC animated:YES];
        }

    
    
      self.collectionButton.userInteractionEnabled=YES;
}
-(NSArray *)allAddressAaary{
    if (!_allAddressAaary) {
        
        _allAddressAaary=[NSArray arrayWithArray:[self loadAddress]];
    }
    
    return _allAddressAaary;
}
-(NSArray*)loadAddress{

    CDVInvokedUrlCommand *mommand=[[CDVInvokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"0",@"100"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllSubWalletAddress"];
    CDVPluginResult * result =[[ELWalletManager share]getAllSubWalletAddress:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
   
    if ([status isEqualToString:@"1"]) {
       NSArray *addressArray=[NSArray arrayWithArray:result.message[@"success"][@"Addresses"]];
        return   addressArray;
    }
    return NULL;
 
    
    
}

-(void)makeView{
    
    if ([self.title isEqualToString:@"ELA"]) {
        [self.topUpButton setTitle:NSLocalizedString(@"侧链充值", nil) forState:UIControlStateNormal];
        [self.topUpButton setImage:[UIImage imageNamed:@"asset_trade_side_recharge"] forState:UIControlStateNormal];
    }else{
          [self.topUpButton setTitle:NSLocalizedString(@"主链提现", nil) forState:UIControlStateNormal];
       [self.topUpButton setImage:[UIImage imageNamed:@"asset_trade_main_withdraw"] forState:UIControlStateNormal];
    }
    
    
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    self.baseTableView.rowHeight=70;
 __weak __typeof(self) _self = self;
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isUpdate=YES;
          __strong __typeof(_self) self = _self;
        self.currentIndex=0;
        [self  loadAllTransactionWithIndex: self.currentIndex];
    }];
    self.baseTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        __strong __typeof(_self) self = _self;
         self.isUpdate=NO;
        
//        if (self.currentIndex==0) {
//            self.currentIndex=20;
//        }

        if (self.allTotal<=self.currentIndex) {
            
            [self  baseTableViewEndRF];
            
            return ;
        }
       
        [self  loadAllTransactionWithIndex: self.currentIndex];
    }];
    
    self.baseTableView.separatorInset=UIEdgeInsetsMake(-0, 15, 0, 15);
  
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    
}
-(void)baseTableViewEndRF{
    [self.baseTableView.mj_header endRefreshing];
    [self.baseTableView.mj_footer endRefreshing];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allListArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMWAssetDetailsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
//    cell.niceNameString=self.model.iconName;
    cell.niceNameString=@"ELA";
    cell.model=self.allListArray[indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self loadTheOrderDetailsWithIndex:indexPath.row];
    
 
    
}
-(void)loadTheOrderDetailsWithIndex:(NSInteger)index{
   assetDetailsModel *model= self.allListArray[index];
    CDVInvokedUrlCommand *mommand=[[CDVInvokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.model.iconName,@"0",@"20",model.TxHash] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllTransaction"];
    CDVPluginResult * result =[[ELWalletManager share]getAllTransaction:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    
    NSArray * OutputPayload=[NSArray arrayWithArray:result.message[@"success"][@"Transactions"][0][@"OutputPayload"]];
    
    if (![status isEqualToString:@"1"]) {
        return;
    }

      NSArray *tranList=[NSArray modelArrayWithClass:assetDetailsModel.class json:result.message[@"success"][@"Transactions"]];
   
    if (tranList.count==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"暂无数据,请耐心等待!", nil)];
         return;
    }
    assetDetailsModel *detailsM=tranList.firstObject;
    HMWtransferTransactionDetailsViewController *transferTransactionDetailsVC=[[HMWtransferTransactionDetailsViewController alloc]init];
    
    detailsM.Amount=[NSString stringWithFormat:@"%@ELA",[[FLTools share]elaScaleConversionWith:detailsM.Amount]];
    detailsM.Fee=[NSString stringWithFormat:@"%@ELA",[[FLTools share]elaScaleConversionWith:detailsM.Fee]];
//    transferTransactionDetailsVC.iconNameString=@"ELA";
    transferTransactionDetailsVC.iconNameString=self.model.iconName;
    int type=[detailsM.Type intValue];
    transferTransactionDetailsVC.TypeString=[NSString stringWithFormat:@"%@",detailsM.Type];
    switch (type) {
            
        case 0:
            detailsM.Type=NSLocalizedString(@"创币交易", nil);
            break;
        case 1:
             detailsM.Type=NSLocalizedString(@"注册资产交易", nil);
            break;
        case 2:
              detailsM.Type=NSLocalizedString(@"普通转账交易", nil);
            break;
        case 3:
            detailsM.Type=NSLocalizedString(@"记录交易", nil);
            break;
        case 4:
             detailsM.Type=NSLocalizedString(@"部署交易", nil);
            break;
        case 5:
             detailsM.Type=NSLocalizedString(@"侧链挖矿交易", nil);
            break;
        case 6:
             detailsM.Type=NSLocalizedString(@"侧链充值交易", nil);
            break;
        case 7:
             detailsM.Type=NSLocalizedString(@"侧链提现交易", nil);
            break;
        case 8:
     transferTransactionDetailsVC.PayloadInfoString=[NSString stringWithFormat:@"%@\n%@ %@",result.message[@"success"][@"Transactions"][0][@"Payload"][@"CrossChainAddress"][0],[[FLTools share] elaScaleConversionWith:result.message[@"success"][@"Transactions"][0][@"Payload"][@"CrossChainAmount"][0]],@"ELA"];
            detailsM.Type=NSLocalizedString(@"跨链交易", nil);
            break;
        case 9:
             detailsM.Type=NSLocalizedString(@"注册参选交易", nil);
            break;
        case 10:
             detailsM.Type=NSLocalizedString(@"取消参选交易", nil);
            break;
        case 11:
            detailsM.Type=NSLocalizedString(@"更新参选交易", nil);
            break;
        case 12:
             detailsM.Type=NSLocalizedString(@"取回参选优质抵押资产交易", nil);
            break;
            
        default:
            break;
    }
    
    detailsM.Timestamp=[[FLTools share]YMDCommunityTimeConversToAllFromTimesTamp:detailsM.Timestamp];

    if ([detailsM.Direction isEqualToString:@"Received"]) {
transferTransactionDetailsVC.type=transactionMultipleIntoType;
    }else if ([detailsM.Direction isEqualToString:@"Sent"]){
transferTransactionDetailsVC.type=transactionSingleRollOutType;
    }else if (OutputPayload.count>0){
        detailsM.Type=NSLocalizedString(@"投票交易", nil);
        transferTransactionDetailsVC.type=rotationToVoteType;
        transferTransactionDetailsVC.votesString=[[FLTools share]elaScaleConversionWith:OutputPayload[0][@"Amount"]];
    }
    else{
transferTransactionDetailsVC.type=transactionSingleIntoType;
    }
        transferTransactionDetailsVC.model=detailsM;
    
    [self.navigationController pushViewController:transferTransactionDetailsVC animated:YES];
    
}
-(void)setModel:(assetsListModel *)model{
    _model=model;
    
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
}
-(void)setElaModel:(assetsListModel *)elaModel{
    _elaModel=elaModel;
}

@end
