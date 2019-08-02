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
#import "ScanQRCodeViewController.h"




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
@property(copy,nonatomic)NSArray *walletIDListArray;
@property(nonatomic,strong)FLWallet *currentWallet;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton *leftButton;
    /*
     *<# #>
     */
    @property(assign,nonatomic)double angle;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setBackgroundImg:@""];
    [self setView];
    NSInteger selectIndex=
    [[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue];
    
    
    if (selectIndex<0) {
        selectIndex=0;
    }
    [self loadTheWalletInformationWithIndex:selectIndex];
  
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataWalletListInfo:) name:updataWallet object:nil];
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iconInfoUpdate:) name:progressBarcallBackInfo object:nil];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(currentWalletAccountBalanceChanges:) name: AccountBalanceChanges object:nil];
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iconInfoUpdate:) name:progressBarcallBackInfo object:nil];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataCreateWalletLoadWalletInfo) name:updataCreateWallet object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AsnyConnectStatusChanged:) name:ConnectStatusChanged object:nil];
    

}
-(void)UpWalletType:(FMDBWalletModel*)model{
NSString *imageName=@"single_wallet";
    switch (model.TypeW) {
        case SingleSign:
            imageName=@"single_wallet";
           break;
        case SingleSignReadonly:
         imageName=@"single_walllet_readonly";
            break;
        case HowSign:
        imageName=@"multi_wallet";
            break;
        case HowSignReadonly:
            imageName=@"multi_wallet_readonly";
            break;
        default:
            break;}
    [self.leftButton setTitle:model.walletName forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
-(UIButton *)leftButton{
    if (!_leftButton) {
     _leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
       
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(swichWallet) forControlEvents:UIControlEventTouchUpInside];
    
        _leftButton.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
       
        
    }
    return _leftButton;
}
-(void)updataCreateWalletLoadWalletInfo{
    self.walletIDListArray=nil;
 
        [self loadTheWalletInformationWithIndex:self.walletIDListArray.count-1];
    
    
}
-(void)AsnyConnectStatusChanged:(NSNotification*)notification{
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSInteger index = [infoArray[2] integerValue];
    if ([self.currentWallet.masterWalletID isEqualToString:walletID]){
         assetsListModel *model=self.dataSoureArray[index];
        NSString *status =[NSString stringWithFormat:@"%@",dic[@"status"]];
        model.status=status;
        self.dataSoureArray[index]=model;
        NSIndexPath *indexP=[NSIndexPath indexPathForRow:index inSection:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexP,nil] withRowAnimation:UITableViewRowAnimationNone];
        });
    }
    
}
-(void)currentWalletAccountBalanceChanges:(NSNotification *)notification{
    
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSInteger index = [infoArray[2] integerValue];
    if (self.dataSoureArray.count<index) {
        return;
    }
    NSString *  balance=dic[@"balance"];
    assetsListModel *model=self.dataSoureArray[index];
    
    
    if ([model.iconName isEqualToString:chainID]&&[self.currentWallet.masterWalletID isEqualToString:walletID]){
        

        model.iconBlance=balance;
        
        self.dataSoureArray[index]=model;
        NSIndexPath *indexP=[NSIndexPath indexPathForRow:index inSection:0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexP,nil] withRowAnimation:UITableViewRowAnimationNone];
        });
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
            
            model.updateTime=[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"已同步区块时间", nil),smodel.sideChainNameTime];
              [[HMWFMDBManager sharedManagerType:sideChain] sideChainUpdate:smodel];
            NSLog(@"修改侧链时间====%@======%@======%@====%@====%@",smodel.sideChainNameTime,model.iconName,self.currentWallet.walletName,smodel.thePercentageCurr,smodel.thePercentageMax);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
        
        
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
        [[HMWFMDBManager sharedManagerType:sideChain] sideChainUpdate:smodel];
        
    }
    
}
-(void)updataWalletListInfo:(NSNotification *)notification{
    self.walletIDListArray=nil;
    if (notification.object!=nil) {
        [self loadTheWalletInformationWithIndex:self.currentWalletIndex];
    }else{
        [self loadTheWalletInformationWithIndex:0];
    }
    
    
}
-(NSArray *)walletIDListArray{
    if (!_walletIDListArray) {
  
        
        _walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    }
    return _walletIDListArray;
    
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
    if (self.walletIDListArray.count==0) {
        FLPrepareVC *vc=[[FLPrepareVC alloc]init];
        vc.type=creatWalletType;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (inde>self.walletIDListArray.count-1) {
        inde=0;
    }
    [STANDARD_USER_DEFAULT setValue:[NSString stringWithFormat:@"%ld",inde] forKey:selectIndexWallet];
    [STANDARD_USER_DEFAULT synchronize];
    
    self.currentWalletIndex=inde;
    FMDBWalletModel *model=self.walletIDListArray[inde];
    
    FLWallet *wallet =[[FLWallet alloc]init];
    wallet.masterWalletID =model.walletID;
    wallet.walletName     =model.walletName;
    wallet.walletAddress  = model.walletAddress;
    
    wallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
     wallet.TypeW  = model.TypeW;
    self.currentWallet = wallet;
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
    
  PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
    NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
        if (array.count>0) {
            [self getBalanceList:array];
        }
    }
    [self UpWalletType:model];
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
            model.thePercentageCurr=[smodel.thePercentageCurr floatValue];
            model.thePercentageMax=[smodel.thePercentageMax floatValue];
//            NSLog(@"本地存储时间====%@====%@====%@====%@=====%@",smodel.sideChainNameTime,smodel.sideChainName,self.currentWallet.walletName,smodel.thePercentageCurr,smodel.thePercentageMax);
            if ([smodel.sideChainNameTime isEqual: [NSNull null]]||smodel.sideChainNameTime==NULL) {
                model.updateTime=[NSString stringWithFormat:@"%@:  %@",NSLocalizedString(@"已同步区块时间", nil),@"--:--"];
                model.thePercentageMax=100;
            }else{
                 model.updateTime=[NSString stringWithFormat:@"%@:  %@",NSLocalizedString(@"已同步区块时间", nil),smodel.sideChainNameTime];
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
//    self.navigationItem.rightBarButtonItem =
    UIBarButtonItem *ClickMorenButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"asset_wallet_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(ClickMore:)];
    UIBarButtonItem *saveButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting_adding_scan"] style:UIBarButtonItemStyleDone target:self action:@selector(QrCode)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                action:nil];
    negativeSpacer.width =-20;
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:negativeSpacer,ClickMorenButton,saveButton,nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    __weak __typeof(self) weakSelf = self;
    self.table.mj_header = [MJRefreshHeader  headerWithRefreshingBlock:^{
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[weakSelf.currentWallet.masterWalletID,@"ELA"] callbackId:weakSelf.currentWallet.masterWalletID className:@"Wallet" methodName:@"SyncStart"];
        [[ELWalletManager share]SyncStart:mommand];
        [weakSelf.table.mj_header endRefreshing];
    }];
}
//二维码
-(void)QrCode{
    __weak __typeof__(self) weakSelf = self;
    ScanQRCodeViewController *scanQRCodeVC = [[ScanQRCodeViewController alloc]init];
    scanQRCodeVC.scanBack = ^(NSString *addr) {// {"type":1,"data":"{\"CoinInfoList\":[{\"ChainID\":\"ELA\",\"EarliestPeerTime\":1561088019,\"FeePerKB\":10000,\"VisibleAssets\":[\"a3d0eaa466df74983b5d7c543de6904f4c9418ead5ffd6d25814234a96db37b0\"]},{\"ChainID\":\"IDChain\",\"EarliestPeerTime\":1562231384,\"FeePerKB\":10000,\"VisibleAssets\":[\"a3d0eaa466df74983b5d7c543de6904f4c9418ead5ffd6d25814234a96db37b0\"]}],\"OwnerPubKey\":\"0315216859941c56b723a36c826d102e24c265978bb79b9a6933eb078f6fb28cf3\",\"SingleAddress\":false,\"m\":1,\"mnemonicHasPassphrase\":false,\"n\":1,\"network\":\"\",\"publicKeyRing\":[{\"requestPubKey\":\"02139b8aee3c6e98523edc57f67076a53aeb058655d8164998973a671d74a684c2\",\"xPubKey\":\"xpub6DJEpruDTPdXTzFSwtACL2snQMDiAUjpTev6as8Kw7L2cgA89ADFn2uCmzTWcWVXKYzdnRaavqLMFwFMqZ7kuLgabTWmYLCZBm28S2oK6m9\"}],\"requestPubKey\":\"02139b8aee3c6e98523edc57f67076a53aeb058655d8164998973a671d74a684c2\",\"xPubKey\":\"xpub6DJEpruDTPdXTzFSwtACL2snQMDiAUjpTev6as8Kw7L2cgA89ADFn2uCmzTWcWVXKYzdnRaavqLMFwFMqZ7kuLgabTWmYLCZBm28S2oK6m9\"}"}
    };
    [weakSelf QRCodeScanVC:scanQRCodeVC];
}

-(void)addCurrency:(UIButton*)btn{
    FLAllAssetListVC  *vc =[[FLAllAssetListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
    [self defultWhite];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.leftButton];;

   
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

-(void)swichWallet{
    HMWTheWalletListViewController *theWalletListVC=[[HMWTheWalletListViewController alloc]init];
    theWalletListVC.delegate=self;
    theWalletListVC.walletIDListArray=self.walletIDListArray;
    theWalletListVC.currentWalletIndex=self.currentWalletIndex;
    [self.navigationController pushViewController:theWalletListVC animated:YES];

}
- (void)ClickMore:(UIButton*)sender {
    HMWTheWalletManagementViewController *theWalletManagementVC=[[HMWTheWalletManagementViewController alloc]init];
    theWalletManagementVC.currentWallet=self.currentWallet;
    [self.navigationController pushViewController:theWalletManagementVC animated:YES];
    

    
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
                [self.navigationController pushViewController:vc animated:YES];
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
   
   cell.detailLab.text=[[FLTools share]elaScaleConversionWith: model.iconBlance];
    
    if ([model.status isEqualToString:@"Connected"]) {
        cell.statusLabel.text=model.updateTime;
        cell.linkImageView.alpha=0.f;
        
    }else if ([model.status isEqualToString:@"Connecting"]){
        cell.statusLabel.text=NSLocalizedString(@"连接中...", nil);
    
        cell.linkImageView.alpha=1.f;
        
    }else if ([model.status isEqualToString:@"DIsconnected"]){
        cell.statusLabel.text=NSLocalizedString(@"丢失...", nil);
        cell.linkImageView.alpha=1.f;
    }
    NSString * symbolString=@"%";
    cell.progress.progress=model.thePercentageCurr/model.thePercentageMax;
    
    if (cell.progress.progress==1&&model.thePercentageCurr!=model.thePercentageMax) {
        cell.progress.progress=0.99;
    }else if ([model.updateTime rangeOfString:@"--:--"].location !=NSNotFound){
        cell.progress.progress=0;
    }else if (model.thePercentageMax==0){
         cell.progress.progress=0;
    }
    cell.progressLab.text=[NSString stringWithFormat:@"%.f%@",cell.progress.progress*100,symbolString];

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSoureArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMWAssetDetailsViewController *vc = [[ HMWAssetDetailsViewController alloc]init];
      assetsListModel *model=self.dataSoureArray[indexPath.row];
    vc.title=model.iconName;
    vc.currentWallet  = self.currentWallet;
    vc.elaModel=self.dataSoureArray.firstObject;
    vc.model=model;
    vc.supportOfTheCurrencyArray=self.dataSoureArray;
    [self.navigationController pushViewController:vc animated:YES];
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
    [self.navigationController pushViewController:AddTheCurrencyListVC animated:YES];
    
}
-(void)needUpdateInfo:(FLWallet *)wallet withSelectIndex:(NSInteger)index{
    self.currentWallet=wallet;
    [self loadTheWalletInformationWithIndex:index];
}
- (void)sendPluginResult:(PluginResult*)result callbackId:(NSString*)callbackId{
    
    
    
    
}
-(void)startAnimationWithView:(UIView*)view{
   CGAffineTransform endAngle = CGAffineTransformMakeRotation(10* (M_PI / 180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform=endAngle;
        }completion:^(BOOL finished){
            self.angle += 10;
        [self startAnimationWithView:view];
        
    }];
    
    
        
}
    -(void)endAnimationWithView:(UIView*)view{
        
        self.angle += 10;
        
        [self startAnimationWithView:view];
        
    }
@end
