//
//  FirstViewController.m
//  FLWALLET
//
//  Created by  on 2018/4/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "FirstViewController.h"
#import "FLAssetTableCell.h"
#import "FLPrepareVC.h"
#import "FLQRVC.h"
#import "FLCreatAcountVC.h"
#import "FLAllKindBi.h"
#import "MJRefresh.h"
#import "WCQRCodeScanningVC.h"
#import "FLCapitalView.h"
#import "FLAllAssetListVC.h"
#import "HMWaddFooterView.h"
#import "HMWAssetDetailsViewController.h"
#import "HMWAddTheCurrencyListViewController.h"
#import "HMWTheWalletListViewController.h"
#import "HMWTheWalletManagementViewController.h"
#import "ELWalletManager.h"
#import "assetsListModel.h"
#import "HMWFMDBManager.h"
#import "FLPrepareVC.h"
#import "sideChainInfoModel.h"




@interface FirstViewController ()<FLCapitalViewDelegate,UITableViewDelegate,UITableViewDataSource,HMWaddFooterViewDelegate,HMWTheWalletListViewControllerDelegate>
{
    FLWallet *_currentWallet;
}
@property (nonatomic,strong) UITableView *table;

@property (nonatomic, strong)FLCapitalView *headerView;
//@property (nonatomic, strong)
@property (nonatomic, strong)NSMutableArray *dataSoureArray;
@property (nonatomic, strong)NSMutableDictionary*tokenAddresses;
@property (nonatomic, strong)FLPrepareVC *prepare;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIButton *addBtn;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger currentWalletIndex;
/*
 *
 */
@property(copy,nonatomic)NSArray *walletIDListArray;
@property(nonatomic,strong)FLWallet *currentWallet;
@property(nonatomic,assign)BOOL isScro;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"aaset_wallet_list"] style:UIBarButtonItemStyleDone target:self action:@selector(swichWallet)];
    [self addAllCallBack];
    [self setView];
    NSInteger selectIndex=
    [[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue];
    if (selectIndex<0) {
        selectIndex=0;
    }
    self.isScro=NO;
    [self loadTheWalletInformationWithIndex:selectIndex];
  
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataWalletListInfo:) name:updataWallet object:nil];
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iconInfoUpdate:) name:progressBarcallBackInfo object:nil];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(currentWalletAccountBalanceChanges:) name: AccountBalanceChanges object:nil];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataCreateWalletLoadWalletInfo) name:updataCreateWallet object:nil];
    self.table.estimatedRowHeight = 0;
    self.table.estimatedSectionHeaderHeight = 0;
    self.table.estimatedSectionFooterHeight = 0;
}

-(void)updataCreateWalletLoadWalletInfo{
self.walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
        [self loadTheWalletInformationWithIndex:self.walletIDListArray.count-1];
}
-(void)addAllCallBack{
    for (FMDBWalletModel *wallet in self.walletIDListArray) {
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[wallet.walletID] callbackId:wallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
        
        PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
        NSString *status=[NSString stringWithFormat:@"%@",result.status];
        if ([status isEqualToString:@"1"]) {
            
            NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
            
            if (array.count>0) {
                [self RegisterToMonitor:array WithmasterWalletID:wallet.walletID];
            }
            
        }
    }
}
-(void)RegisterToMonitor:(NSArray*)arr WithmasterWalletID:(NSString*)walletID{
    for (int i =0; i<arr.count; i++) {
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[walletID,arr[i]] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:[NSString stringWithFormat:@"%d",i]];
        
        [[ELWalletManager share]registerWalletListener:mommand];
    }
}
-(void)currentWalletAccountBalanceChanges:(NSNotification *)notification{
    
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSInteger index = [infoArray[2] integerValue];
    
//    asset":assetString,@"balance"
    
//    NSString * currentBlockHeight=dic[@"currentBlockHeight"];
    if (self.dataSoureArray.count<index) {
        return;
    }
    NSString *  balance=dic[@"balance"];
  
    assetsListModel *model=self.dataSoureArray[index];
    if ([model.iconName isEqualToString:chainID]&&[self.currentWallet.masterWalletID isEqualToString:walletID]){
        model.iconBlance=balance;
        self.dataSoureArray[index]=model;
        if (self.isScro==NO) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSIndexPath *indexP=[NSIndexPath indexPathForRow:index inSection:0];
                [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexP,nil] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
   }
}
-(void)iconInfoUpdate:(NSNotification *)notification{
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSInteger index = [infoArray[2] integerValue];
    NSString *lastBlockTimeString=dic[@"lastBlockTimeString"];
    NSString * currentBlockHeight=dic[@"currentBlockHeight"];
    NSString *  progress=dic[@"progress"];
    assetsListModel *model;
    if ([self.currentWallet.masterWalletID isEqualToString:walletID]){
        if ([chainID isEqualToString:@"ELA"]) {
            [ELWalletManager share].estimatedHeight=currentBlockHeight;
            model=self.dataSoureArray[0];
        }else{
             model=self.dataSoureArray[1];
        }
        model.thePercentageMax=[progress floatValue];
    model.thePercentageCurr=[currentBlockHeight floatValue];
        if (lastBlockTimeString.length>0) {
            sideChainInfoModel *smodel=[[sideChainInfoModel alloc]init];
            smodel.thePercentageMax=[NSString stringWithFormat:@"%f",model.thePercentageMax];
           smodel.thePercentageCurr=[NSString stringWithFormat:@"%f",model.thePercentageCurr]; smodel.walletID=self.currentWallet.masterWalletID;
            smodel.sideChainName=model.iconName;
            smodel.sideChainNameTime=lastBlockTimeString;
             NSString *YYMMSS =[[FLTools share]YMDHMSgetTimeFromTimesTamp:smodel.sideChainNameTime];
            model.updateTime=[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"已同步区块时间", nil),YYMMSS];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[HMWFMDBManager sharedManagerType:sideChain] sideChainUpdate:smodel];
                NSLog(@"修改侧链时间====%@======%@======%@====%@====%@",smodel.sideChainNameTime,model.iconName,self.currentWallet.walletName,smodel.thePercentageCurr,smodel.thePercentageMax);
            });
        }
        if (self.isScro==NO) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
                [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    
    }else{
        sideChainInfoModel *smodel=[[sideChainInfoModel alloc]init];
        if (model.thePercentageMax==0) {
            model.thePercentageMax=1;
        }
        smodel.thePercentageMax=[NSString stringWithFormat:@"%@",progress];
        smodel.thePercentageCurr=[NSString stringWithFormat:@"%@",currentBlockHeight];
        smodel.walletID=walletID;
        smodel.sideChainName=chainID;
        smodel.sideChainNameTime=lastBlockTimeString;
        
        dispatch_async(dispatch_get_main_queue(), ^{
          [[HMWFMDBManager sharedManagerType:sideChain] sideChainUpdate:smodel];
        });
        
    }
    
}
-(void)updataWalletListInfo:(NSNotification *)notification{
       self.walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    if (notification.object!=nil) {
        [self loadTheWalletInformationWithIndex:self.currentWalletIndex];
    }else{
        [self loadTheWalletInformationWithIndex:0];
    }
    
    
}
- (NSMutableArray *)dataSoureArray{
    if (!_dataSoureArray) {
        _dataSoureArray =[[NSMutableArray alloc]init];
    }
    return _dataSoureArray;
}
-(void)setCurrentWallet:(FLWallet *)currentWallet
{
    _currentWallet = currentWallet;
    [ELWalletManager share].currentWallet = currentWallet;
}
-(void)loadTheWalletInformationWithIndex:(NSInteger)inde{
if(self.walletIDListArray.count==0){
    self.walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    if (self.walletIDListArray.count==0) {
        FLPrepareVC *vc=[[FLPrepareVC alloc]init];
        vc.type=creatWalletType;
        [self.navigationController pushViewController:vc animated:NO];
        return;
    }else{
        self.walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    }
    
    }
if(inde>self.walletIDListArray.count-1) {
        inde=0;
    }
    [STANDARD_USER_DEFAULT setValue:[NSString stringWithFormat:@"%ld",(long)inde] forKey:selectIndexWallet];
    [STANDARD_USER_DEFAULT synchronize];
    
    self.currentWalletIndex=inde;
    FMDBWalletModel *model=self.walletIDListArray[inde];
    
    FLWallet *wallet =[[FLWallet alloc]init];
    wallet.masterWalletID =model.walletID;
    wallet.walletName     =model.walletName;
    wallet.walletAddress  = model.walletAddress;
    
    wallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    
    self.currentWallet    = wallet;
  self.navigationItem.title = model.walletName;
    

    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
    
  PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
        
    NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
        
        if (array.count>0) {
            [self getBalanceList:array];
            
        }
    
    }

}
-(void)getBalanceList:(NSArray*)arr{
    if (self.dataSoureArray.count>0) {
        [self.dataSoureArray removeAllObjects];
    }

    int index=0;
    for (NSString *currencyName in arr) {
   
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,currencyName,@2] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getBalance"];
        PluginResult * result =[[ELWalletManager share]getBalance:mommand];
        
        NSString *status=[NSString stringWithFormat:@"%@",result.status];
        if ([status isEqualToString:@"1"]){
            sideChainInfoModel *smodel=
            
            [[HMWFMDBManager sharedManagerType:sideChain] selectAddsideChainWithWalletID:self.currentWallet.masterWalletID andWithIconName:currencyName];
            NSString *blanceString=[NSString stringWithFormat:@"%@",result.message[@"success"]];
            
            assetsListModel *model=[[assetsListModel alloc]init];
            model.iconName=currencyName;
            model.thePercentageCurr=0.f;
            model.thePercentageMax=1.f;
            model.iconBlance=blanceString;
            model.thePercentageCurr=[smodel.thePercentageCurr doubleValue];
            model.thePercentageMax=[smodel.thePercentageMax doubleValue];
            if ([smodel.sideChainNameTime isEqual: [NSNull null]]||smodel.sideChainNameTime==NULL||[smodel.sideChainNameTime isEqualToString:@"--:--"]) {
                model.updateTime=[NSString stringWithFormat:@"%@:  %@",NSLocalizedString(@"已同步区块时间", nil),@"--:--"];
                model.thePercentageMax=100;
            }else{
            NSString *YYMMSS =[[FLTools share]YMDHMSgetTimeFromTimesTamp:smodel.sideChainNameTime];
                 model.updateTime=[NSString stringWithFormat:@"%@:  %@",NSLocalizedString(@"已同步区块时间", nil),YYMMSS];
            }
            [self.dataSoureArray addObject:model];
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,currencyName] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:[NSString stringWithFormat:@"%d",index]];

            [[ELWalletManager share]registerWalletListener:mommand];
            index++;
        }
    }
    [self.table reloadData];
    [self.table.mj_header endRefreshing];
    
}
-(void)setView{
    self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    self.table.separatorInset=UIEdgeInsetsMake(0, 10, 0, 10);
    [self.view addSubview:self.table];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table registerNib:[UINib nibWithNibName:@"FLAssetTableCell" bundle:nil] forCellReuseIdentifier:@"FLAssetTableCell"];
    
    self.table.dataSource =self;
    self.table.delegate = self;
    self.table.rowHeight = 100;
    HMWaddFooterView *addFooterView=[[HMWaddFooterView alloc]init];
    addFooterView.delegate=self;
    
    self.table.tableFooterView =addFooterView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"asset_wallet_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(ClickMore:)];
   
 __weak __typeof(self) weakSelf = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        for ( assetsListModel *model in self.dataSoureArray) {
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[weakSelf.currentWallet.masterWalletID,model.iconName] callbackId:weakSelf.currentWallet.masterWalletID className:@"Wallet" methodName:@"SyncStart"];
            [[ELWalletManager share]SyncStart:mommand];
        }
       
        [weakSelf.table.mj_header endRefreshing];
    }];
    self.table.mj_header=header;
}
-(void)addCurrency:(UIButton*)btn{
    FLAllAssetListVC  *vc =[[FLAllAssetListVC alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)netWorkData{
    if (!self.currentWallet.walletAddress) {
        [self.table.mj_header endRefreshing];
        return;
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self firstNav];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isScro){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isScro =NO;
            [self.table reloadData];
        });
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.isScro=YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
-(void)swichWallet{
    HMWTheWalletListViewController *theWalletListVC=[[HMWTheWalletListViewController alloc]init];
    theWalletListVC.delegate=self;
theWalletListVC.walletIDListArray=self.walletIDListArray;
theWalletListVC.currentWalletIndex=self.currentWalletIndex;
    [self.navigationController pushViewController:theWalletListVC animated:NO];

}
- (void)ClickMore:(UIButton*)sender {
    HMWTheWalletManagementViewController *theWalletManagementVC=[[HMWTheWalletManagementViewController alloc]init];
    theWalletManagementVC.currentWallet=self.currentWallet;
    [self.navigationController pushViewController:theWalletManagementVC animated:NO];
}

-(void)capitalViewDidClick:(NSInteger)index
{
  
    switch (index) {
        case 11:
        case 1:
            {
                FLQRVC *vc = [[FLQRVC alloc]init];
//                vc.addr = self.currentWallet.walletAddress;
//                vc.Wallet = self.currentWallet;
                [self.navigationController pushViewController:vc animated:NO];
            }
            break;
        case 3:{
//            FLWalletDeleteVC *vc= [[FLWalletDeleteVC alloc]init];
//            vc.currentWallet = self.currentWallet;
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
            {
//                FLAllAssetListVC *vc = [[FLAllAssetListVC alloc]init];
//                vc.addr = self.currentWallet.walletAddress;
//                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            case 10:
        {
           // [self jumpToSelectTradeBiVC:nil];
        }
            break;
        case 12:
        {
//            FLBuyAndSellVC *vc = [[FLBuyAndSellVC alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
            [[FLTools share]showErrorInfo:@"敬请期待"];
        }
            break;
        default:
            break;
    }
}
//-(void)jumpToSelectTradeBiVC:(NSString*)addr{
//    FLSelectTradeBiVC *vc = [[FLSelectTradeBiVC alloc]init];
//    vc.dataSource = self.dataSource;
//    vc.toAddress = addr;
//    vc.currentWallet=self.currentWallet;
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//刷新通知
//-(void)walletRefresh:(NSNotification*)message
//{
//    switch ([message.object integerValue]) {
//        case 1://跟新
//            {
////                [self setWallet];
//                [self netWorkData];
//
//            }
//            break;
//        case 2://换
//            {
//                self.currentWallet = nil;
////                [self setWallet];
//            }
//            break;
//        default:
//            break;
//    }
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLAssetTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLAssetTableCell"];
    assetsListModel *model=self.dataSoureArray[indexPath.row];
 cell.biName.text=model.iconName;
   cell.updatetime.text=model.updateTime;
    cell.detailLab.text=[[FLTools share]elaScaleConversionWith: model.iconBlance];
    NSString *symbolString=@"%";
    double prog=model.thePercentageCurr/model.thePercentageMax;
     if ([model.updateTime rangeOfString:@"--:--"].location !=NSNotFound){
        cell.progress.progress=0;
    }else if (model.thePercentageMax==0){
         cell.progress.progress=0;
    }else if (prog==1.0||prog>1.0) {
        if (model.thePercentageCurr!=model.thePercentageMax) {
            cell.progress.progress=0.99;
        }else{
            cell.progress.progress=1.0;
        }
        
    }else{
        if (prog==0.f&&model.thePercentageCurr>0) {
            prog=0.1;
        }
        cell.progress.progress=prog;
    }
    NSLog(@"CELL==%f===%f===%f",model.thePercentageCurr,model.thePercentageMax,cell.progress.progress);
  
    cell.progressLab.text=[NSString stringWithFormat:@"%.f%@", floor(cell.progress.progress*100),symbolString];
    NSLog(@"cell.progressLab.text==%@",cell.progressLab.text);
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSoureArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   FLAssetTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    HMWAssetDetailsViewController *vc = [[HMWAssetDetailsViewController alloc]init];
      assetsListModel *model=self.dataSoureArray[indexPath.row];
    vc.title=model.iconName;
    vc.currentWallet  = self.currentWallet;
    vc.elaModel=self.dataSoureArray.firstObject;
    vc.model=model;
    vc.synchronousP=cell.progress.progress;
    vc.supportOfTheCurrencyArray=self.dataSoureArray;
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark param
-(FLPrepareVC *)prepare
{
    if (!_prepare) {
        _prepare = [[FLPrepareVC alloc]init];
    }
    return _prepare;
}
-(NSMutableDictionary *)tokenAddresses
{
    if (!_tokenAddresses) {
        _tokenAddresses = [NSMutableDictionary dictionary];
    }
    return _tokenAddresses;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark ---------HMWaddFooterViewDelegate----------
-(void)addTheAssetEvent{
    
    HMWAddTheCurrencyListViewController *AddTheCurrencyListVC=[[HMWAddTheCurrencyListViewController alloc]init];
    AddTheCurrencyListVC.wallet=self.currentWallet;
    AddTheCurrencyListVC.openedTheSubstringArrayList=self.dataSoureArray;
    [self.navigationController pushViewController:AddTheCurrencyListVC animated:NO];
    
}
-(void)needUpdateInfo:(FLWallet *)wallet withSelectIndex:(NSInteger)index{
    self.currentWallet=wallet;
    [self loadTheWalletInformationWithIndex:index];
}
- (void)sendPluginResult:(PluginResult*)result callbackId:(NSString*)callbackId{
    
    
    
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isScro=YES;
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.isScro=NO;
    [self.table reloadData];
}
@end
