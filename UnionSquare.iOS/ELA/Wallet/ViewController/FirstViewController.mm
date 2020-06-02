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
#import "NENPingManager.h"
#import "HWMQrCodeScanningResultsViewController.h"
#import "HWMSignStatusModel.h"
#import "HMWpwdPopupView.h"
#import "HWMSignatureTradingSingleQrCodeViewController.h"
#import "HMWSendSuccessPopuView.h"
#import "HWMDIDManager.h"
#import "HWMDIDAuthorizationViewController.h"
#import "HWMMessageCenterModel.h"
#import "HMWtransferViewController.h"
#import "HWMQrCodeSignatureManager.h"
#import "HWMSuggestionViewController.h"
#import "HWMQrCodeInfoPasswordViewController.h"
#import "HWMSecretaryGeneralAndMembersInfo.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HWMCommentPerioDetailsViewController.h"

@interface FirstViewController ()<FLCapitalViewDelegate,UITableViewDelegate,UITableViewDataSource,HMWaddFooterViewDelegate,HMWTheWalletListViewControllerDelegate,HMWpwdPopupViewDelegate,HMWToDeleteTheWalletPopViewDelegate, HMWAddTheCurrencyListViewControllerDelegate,HMWAddTheCurrencyListViewControllerDelegate,HWMCommentPerioDetailsViewControllerDelegate>
{
    FLWallet *_currentWallet;
}
@property (nonatomic,strong) UITableView *table;
/*
 *HMWpwdPopupView *)pwdPopupV
 */
@property(strong,nonatomic)HMWpwdPopupView  *pwdPopupV;

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
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton *leftButton;
/*
 *<# #>
 */
@property(assign,nonatomic)double angle;
@property(nonatomic,assign)BOOL isScro;
/*
 *
 */
@property(strong,nonatomic)UIView *leftView;
/*
 *<# #>
 */
@property(strong,nonatomic)NENPingManager *pingManager;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableDictionary *QRCoreDic;
/*
 *<# #>
 */
@property(strong,nonatomic) HWMSignStatusModel *SignStatusModel;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *openIDChainView;
@property(assign,nonatomic)QrCodeSignatureType QRType;
@property(copy,nonatomic)NSString* QRCodeString;
@property(strong,nonatomic)id QRCodeData;
@property(assign,nonatomic) BOOL needOpen;


@end


@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataWalletListInfo:) name:updataWallet object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iconInfoUpdate:) name:progressBarcallBackInfo object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(currentWalletAccountBalanceChanges:) name: AccountBalanceChanges object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updataCreateWalletLoadWalletInfo) name:updataCreateWallet object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AsnyConnectStatusChanged:) name:ConnectStatusChanged object:nil];
    [self setView];
    NSInteger selectIndex=
    [[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue];
    if (selectIndex<0) {
        selectIndex=0;
    }
    self.isScro=NO;
    [self loadTheWalletInformationWithIndex:selectIndex];
    if ([SDKNET isEqualToString:@"MainNet"]) {
        [self loadNetWorkingPong];
    }
    
}
-(void)loadNetWorkingPong{
    [HttpUrl NetGETHost:PongUrl url:@"/api/dposNodeRPC/getProducerNodesList" header:nil body:nil showHUD:NO WithSuccessBlock:^(id data) {
        NSArray *urlArray =[NSArray arrayWithArray:data[@"data"]];
        [self loadPingWithURLArray:[[FLTools share]theInterceptionHttpWithArray:urlArray] withHTTPArray:urlArray];
    } WithFailBlock:^(id data) {
        NSArray *urlArray =@[linkURL1,linkURL2];
        [self loadPingWithURLArray:[[FLTools share]theInterceptionHttpWithArray:urlArray] withHTTPArray:urlArray];
    } ];
    
}
-(void)loadPingWithURLArray:(NSArray*)urlArray withHTTPArray:(NSArray*)arry{
    self.pingManager = [[NENPingManager alloc] init];
    [self.pingManager getFatestAddress:urlArray completionHandler:^(NSString *hostName, NSArray *sortedAddress) {
        if (hostName.length>0){
            NSInteger index=[urlArray indexOfObject:hostName];
            [STANDARD_USER_DEFAULT setValue:arry[index] forKey: @"Http_IP"];
            [STANDARD_USER_DEFAULT synchronize];
        }
    }];
}
-(UIView *)leftView{
    if (!_leftView) {
        _leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth/2, 50)];
        UIImageView *imageVie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"single_wallet"]];
        imageVie.tag=1001;
        [_leftView addSubview:imageVie];
        [imageVie mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftView.mas_left);
            make.centerY.equalTo(_leftView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        UILabel *labe =[[UILabel alloc]init];
        labe.textAlignment=NSTextAlignmentLeft;
        labe.tag=1002;
        labe.font=[UIFont systemFontOfSize:16];
        labe.textColor=[UIColor whiteColor];
        [_leftView addSubview:labe];
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageVie.mas_right).offset(6);
            make.top.equalTo(_leftView.mas_top);
            make.bottom.equalTo(_leftView.mas_bottom);
            make.right.equalTo(_leftView.mas_right).offset(-6);
        }];
        UIButton *leftButton=[[UIButton alloc]init];
        [leftButton addTarget:self action:@selector(swichWallet) forControlEvents:UIControlEventTouchUpInside];
        [_leftView addSubview:leftButton];
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(_leftView);
        }];
    }
    return _leftView;
}
-(void)UpWalletType{
    NSString *imageName=@"single_wallet";
    switch (self.currentWallet.TypeW) {
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
    UIImageView *imagV =(UIImageView*)[self.leftView viewWithTag:1001];
    imagV.image=[UIImage imageNamed:imageName];
    UILabel *nameLabel =(UILabel*)[self.leftView viewWithTag:1002];
    nameLabel.text=self.currentWallet.walletName;
}
-(void)updataCreateWalletLoadWalletInfo{
    self.walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    [self loadTheWalletInformationWithIndex:self.walletIDListArray.count-1];
}

-(void)addAllCallBack{
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID] callbackId:self.currentWallet.masterWalletID className:@"Wallet" methodName:@"getAllSubWallets"];
    PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
        NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
        if (array.count>0) {
            [self RegisterToMonitor:array WithmasterWalletID:self.currentWallet.masterWalletID];
        }
    }
}
-(void)RegisterToMonitor:(NSArray*)arr WithmasterWalletID:(NSString*)walletID{
    for (int i =0; i<arr.count; i++) {
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[walletID,arr[i]] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:[NSString stringWithFormat:@"%d",i]];
        
        [[ELWalletManager share]registerWalletListener:mommand];
    }
}
-(void)AsnyConnectStatusChanged:(NSNotification *)notification{
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSInteger index = [infoArray[2] integerValue];
    if (self.dataSoureArray.count-1<index) {
        return;
    }
    NSString * statusString=dic[@"status"];
    
    assetsListModel *model=self.dataSoureArray[index];
    if ([model.iconName isEqualToString:chainID]&&[self.currentWallet.masterWalletID isEqualToString:walletID]){
        model.status=statusString;
        self.dataSoureArray[index]=model;
        if (self.isScro==NO) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSIndexPath *indexP=[NSIndexPath indexPathForRow:index inSection:0];
                [self updateCellInfoWithModel:model withInde:indexP];
            });
        }
    }
    
}
-(void)currentWalletAccountBalanceChanges:(NSNotification *)notification{
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSInteger index = [infoArray[2] integerValue];
    if (self.dataSoureArray.count-1<index) {
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
                [self updateCellInfoWithModel:model withInde:indexP];
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
    NSString * currentBlockHeight=@"0";
    NSString *  progress=dic[@"progress"];
    NSString *IP=dic[@"DownloadPeer"];
    NSString *BytesPerSecond=dic[@"BytesPerSecond"];
    
    assetsListModel *model;
    if ([self.currentWallet.masterWalletID isEqualToString:walletID]){
        if ([chainID isEqualToString:@"ELA"]) {
            if(self.dataSoureArray.count > 0)
                model=self.dataSoureArray[0];
        }else{
            if(self.dataSoureArray.count > 1)
                model=self.dataSoureArray[1];
        }
        model.thePercentageMax=[progress doubleValue];
        //    model.thePercentageCurr=[currentBlockHeight floatValue];
        if (lastBlockTimeString.length>0) {
            sideChainInfoModel *smodel=[[sideChainInfoModel alloc]init];
            smodel.thePercentageMax=[NSString stringWithFormat:@"%f",model.thePercentageMax];
            //           smodel.thePercentageCurr=[NSString stringWithFormat:@"%f",model.thePercentageCurr];
            smodel.walletID=self.currentWallet.masterWalletID;
            smodel.sideChainName=model.iconName;
            smodel.sideChainNameTime=lastBlockTimeString;
            NSString *YYMMSS =[[FLTools share]YMDHMSgetTimeFromTimesTamp:smodel.sideChainNameTime];
            model.updateTime=[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"已同步区块时间", nil),YYMMSS];
            model.IP=IP;
            model.ConnectionSpeed=BytesPerSecond;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[HMWFMDBManager sharedManagerType:sideChain] sideChainUpdate:smodel];
            });
        }
        if (self.isScro==NO) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
                [self updateCellInfoWithModel:model withInde:indexPath];
            });
        }
        
    }else{
        sideChainInfoModel *smodel=[[sideChainInfoModel alloc]init];
        if (model.thePercentageMax==0) {
            model.thePercentageMax=1;
        }
        smodel.thePercentageMax=[NSString stringWithFormat:@"%@",progress];
        //        smodel.thePercentageCurr=[NSString stringWithFormat:@"%@",currentBlockHeight];
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
    //    [self showLoading];
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
    [[HWMSecretaryGeneralAndMembersInfo shareTools] loadDataSourceWithLoading:NO complete:^(HWMSecretaryGeneralAndMembersDetailsModel *model) {
        
    }];
    self.currentWalletIndex=inde;
    FMDBWalletModel *model=self.walletIDListArray[inde];
    FLWallet *wallet =[[FLWallet alloc]init];
    wallet.masterWalletID =model.walletID;
    wallet.walletName     =model.walletName;
    wallet.walletAddress  = model.walletAddress;
    wallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    wallet.TypeW  = model.TypeW;
    wallet.didString=model.didString;
    self.currentWallet = wallet;
    
    [self addAllCallBack];
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
    PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
        NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
        if (array.count>0) {
            [self getBalanceList:array];
        }
    }
    PluginResult * resultBase =[[ELWalletManager share]getMasterWalletBasicInfo:mommand];
    NSString *statusBase=[NSString stringWithFormat:@"%@",resultBase.status];
    NSDictionary *baseDic=[[NSDictionary alloc]init];
    if ([statusBase isEqualToString:@"1"] ) {
        baseDic=[[FLTools share]dictionaryWithJsonString:resultBase.message[@"success"]];
        NSString *Readonly=[NSString stringWithFormat:@"%@",baseDic[@"Readonly"]];
        if ([Readonly isEqualToString:@"0"]) {
            if ([baseDic[@"M"] integerValue]==1) {
                self.currentWallet.TypeW=0;
            }else{
                self.currentWallet.TypeW=2;
            }
        }else{
            if ([baseDic[@"M"] integerValue]==1) {
                self.currentWallet.TypeW=1;
            }else{
                self.currentWallet.TypeW=3;
            }
        }
        self.currentWallet.HasPassPhrase=[baseDic[@"HasPassPhrase"] boolValue];
        self.currentWallet.M=[baseDic[@"M"] integerValue];
        self.currentWallet.N=[baseDic[@"N"] integerValue];
        [self UpWalletType];
        [self hiddLoading];
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
            model.thePercentageMax=[smodel.thePercentageMax doubleValue];
            if ([smodel.sideChainNameTime isEqual: [NSNull null]]||smodel.sideChainNameTime==NULL||[smodel.sideChainNameTime isEqualToString:@"--:--"]) {
                model.updateTime=[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"已同步区块时间", nil),@"--:--"];
                model.thePercentageMax=100;
            }else{
                NSString *YYMMSS =[[FLTools share]YMDHMSgetTimeFromTimesTamp:smodel.sideChainNameTime];
                model.updateTime=[NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"已同步区块时间", nil),YYMMSS];
            }
            [self.dataSoureArray addObject:model];
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,currencyName] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:[NSString stringWithFormat:@"%d",index]];
            [[ELWalletManager share]registerWalletListener:mommand];
            [[ELWalletManager share]SyncStart:mommand];
            index++;
        }
    }
    [self.table reloadData];
    [self.table.mj_header endRefreshing];
    if (self.needOpen&&arr.count>1) {
        self.needOpen=NO;
        [self ParseTheQrCodeJumpEventWithType:self.QRType withData:self.QRCodeData tsWithQRCodeString:self.QRCodeString];
    }
    
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
    UIBarButtonItem *ClickMorenButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"asset_wallet_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(ClickMore:)];
    UIBarButtonItem *saveButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting_adding_scan"] style:UIBarButtonItemStyleDone target:self action:@selector(QrCode)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    negativeSpacer.width =-20;
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:negativeSpacer,ClickMorenButton,saveButton,nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    //        self.navigationItem.rightBarButtonItem=ClickMorenButton;
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader  *header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        NSMutableArray *dataArray= [NSMutableArray arrayWithArray:weakSelf.dataSoureArray];
        for (assetsListModel *model in dataArray) {
            invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[weakSelf.currentWallet.masterWalletID,model.iconName] callbackId:weakSelf.currentWallet.masterWalletID className:@"Wallet" methodName:@"SyncStart"];
            [[ELWalletManager share]SyncStart:mommand];
        }
        [weakSelf.table.mj_header endRefreshing];
    }];
    self.table.mj_header=header;
}
//二维码
-(void)QrCode{
    __weak __typeof__(self) weakSelf = self;
    WCQRCodeScanningVC *WCQRCode=[[WCQRCodeScanningVC alloc]init];
    WCQRCode.frVC=self;
    WCQRCode.scanBack=^(NSString *addr){
        NSLog(@"扫二维码 获取到的数据---%@",addr);
        [weakSelf SweepCodeProcessingResultsWithQRCodeString:addr];
        
    };
    [self QRCodeScanVC:WCQRCode];
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
    [self hiddLoading];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isScro){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isScro =NO;
            for (int i=0; i<self.dataSoureArray.count; i++) {
                assetsListModel *model=self.dataSoureArray[i];
                
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
                [self updateCellInfoWithModel:model withInde:indexPath];
            }
        });
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self hiddLoading];
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.isScro=YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
}
-(void)swichWallet{
    HMWTheWalletListViewController *theWalletListVC=[[HMWTheWalletListViewController alloc]init];
    theWalletListVC.delegate=self;
    theWalletListVC.walletIDListArray=[[NSMutableArray alloc]initWithArray:self.walletIDListArray];
    theWalletListVC.currentWalletIndex=self.currentWalletIndex;
    [self.navigationController pushViewController:theWalletListVC animated:NO];
    
}
- (void)ClickMore:(UIButton*)sender {
    HMWTheWalletManagementViewController *theWalletManagementVC=[[HMWTheWalletManagementViewController alloc]init];
    theWalletManagementVC.currentWallet=self.currentWallet;
    theWalletManagementVC.currencyArray=self.dataSoureArray;
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLAssetTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLAssetTableCell"];
    assetsListModel *model=self.dataSoureArray[indexPath.row];
    cell.biName.text=model.iconName;
    
    cell.detailLab.text=[[FLTools share]elaScaleConversionWith: model.iconBlance];
    cell.updatetime.text=model.updateTime;
    cell.statusLabel.text=NSLocalizedString(@"连接中…", nil);
    NSString *symbolString=@"%";
    if ([model.updateTime rangeOfString:@"--:--"].location !=NSNotFound){
        cell.progress.progress=0;
    }else{
        cell.progress.progress=model.thePercentageMax;
    }
    if (cell.progress.progress==1) {
        cell.linkImageView.alpha=0.f;
    }else{
        cell.linkImageView.alpha=1.f;
    }
    if ([model.status isEqualToString:@"Connected"]) {
        cell.statusLabel.text=model.updateTime;
    }else if ([model.status isEqualToString:@"Connecting"]){
        cell.statusLabel.text=NSLocalizedString(@"连接中…", nil);
        
    }else if ([model.status isEqualToString:@"DIsconnected"]){
        cell.statusLabel.text=NSLocalizedString(@"丢失…", nil);
    }
    cell.progressLab.text=[NSString stringWithFormat:@"%.f%@", floor(cell.progress.progress*100),symbolString];
    [self startAnimationWithView:cell.linkImageView];
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
-(void)startAnimationWithView:(UIView*)view{
    [UIView animateWithDuration:1 animations:^{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
        animation.duration = 0.6;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [view.layer addAnimation:animation forKey:nil];
        
    }];
    
    
    
}
-(void)endAnimationWithView:(UIView*)view{
    [UIView animateWithDuration:1 animations:^{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue = [NSNumber numberWithFloat: M_PI *2];
        animation.duration = 0.6;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [view.layer addAnimation:animation forKey:nil];
        
    }];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isScro=YES;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.isScro=NO;
    for (int i=0; i<self.dataSoureArray.count; i++) {
        assetsListModel *model=self.dataSoureArray[i];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        [self updateCellInfoWithModel:model withInde:indexPath];
    }
}
-(void)updateCellInfoWithModel:(assetsListModel*)model withInde:(NSIndexPath*)inde{
    FLAssetTableCell *cell = [self.table cellForRowAtIndexPath:inde];
    cell.biName.text=model.iconName;
    cell.updatetime.text=model.updateTime;
    cell.detailLab.text=[[FLTools share]elaScaleConversionWith: model.iconBlance];
    NSString *symbolString=@"%";
    if ([model.updateTime rangeOfString:@"--:--"].location !=NSNotFound){
        cell.progress.progress=0;
    }else{
        cell.progress.progress=model.thePercentageMax;
    }
    if (cell.progress.progress==1) {
        cell.linkImageView.alpha=0.f;
    }else{
        cell.linkImageView.alpha=1.f;
    }
    
    if ([model.status isEqualToString:@"Connected"]) {
        cell.statusLabel.text=model.updateTime;
    }else if ([model.status isEqualToString:@"Connecting"]){
        cell.statusLabel.text=NSLocalizedString(@"连接中…", nil);
        
    }else if ([model.status isEqualToString:@"DIsconnected"]){
        cell.statusLabel.text=NSLocalizedString(@"丢失…", nil);
    }
    cell.progressLab.text=[NSString stringWithFormat:@"%.f%@", floor(cell.progress.progress*100),symbolString];
    [self startAnimationWithView:cell.linkImageView];
}

-(void)SweepCodeProcessingResultsWithQRCodeString:(NSString*)QRCodeString{
    __weak __typeof__(self) weakSelf = self;
    [[HWMQrCodeSignatureManager shareTools]QrCodeDataWithData:QRCodeString withDidString:self.currentWallet.didString withmastWalletID:self.currentWallet.masterWalletID withComplete:^(QrCodeSignatureType type, id  _Nonnull data) {
        if (data !=NULL) {
            
            NSLog(@"data is %@",data);
            
            
            
            [self ParseTheQrCodeJumpEventWithType:type withData:data tsWithQRCodeString:QRCodeString];
        }
        
    }];
}
-(void)ParseTheQrCodeJumpEventWithType:(QrCodeSignatureType)type withData:(id)data tsWithQRCodeString:(NSString*)QRCodeString{
    self.QRType=type;
    self.QRCodeData=data;
    self.QRCodeString=QRCodeString;
    if (type!= CreadDIDType&&
        type!=DIDTimePassType&&
        type!=CommonIdentityType&&
        type!=unknowQrCodeType&&type!=QRTimePassType&&type!= AuthenticationDID) {
        if (self.dataSoureArray.count<2) {
            UIView *mainView =[self mainWindow];
            self.openIDChainView.deleteType=openIDChainType;
            [mainView addSubview:self.openIDChainView];
            [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(mainView);
            }];
            return;
        }
    }
    switch (type) {
        case CreadDIDType:
            [[FLTools share]showErrorInfo:NSLocalizedString(@"钱包DID不匹配", nil)];
            break;
        case DIDTimePassType:
            [[FLTools share]showErrorInfo:NSLocalizedString(@"DID已过期", nil)];
            break;
        case CommonIdentityType:
            [self QrCodeScanningResultsWithString:QRCodeString withVC:self];
            break;
        case credaccessQrCodeType:
            [self ShowPlayInfoText:data withJWTString:QRCodeString];
            break;
            //xxl 2.2 flow TODO for go to the flow
        case suggestionQrCodeType:
            [self showAdviceInfoText:data withJWTString:QRCodeString WithType:type];
            break;
        case reviewPropalQrCodeType:
        case voteforProposalQrCodeType:
            [self parsingQRCodeDataWithType:type withDicData:data withQRString:QRCodeString];
            break;
        case billQrCodeType:
            [self showAdviceInfoText:data withJWTString:QRCodeString WithType:type];
            break;
        case unknowQrCodeType:
            [self QrCodeScanningResultsWithString:QRCodeString withVC:self];
            break;
            
            //        case ProposalLeaderType:
            //            [self QrCodeInfoPasswordViewInfoText:data withJWTString:QRCodeString WithType:type];
            //            break;
            //        case SecretaryGeneralType:
            //            [self QrCodeInfoPasswordViewInfoText:data withJWTString:QRCodeString WithType:type];
            //            break;
        case withdrawalsType:
            [self QrCodeInfoPasswordViewInfoText:data withJWTString:QRCodeString WithType:type];
            break;
        case Updatemilestone:
            [self QrCodeInfoPasswordViewInfoText:data withJWTString:QRCodeString WithType:type];
            break;
        case Reviewmilestone:
            [self QrCodeInfoPasswordViewInfoText:data withJWTString:QRCodeString WithType:type];
            break;
        case  QRTimePassType:
            [[FLTools share]showErrorInfo:NSLocalizedString(@"二维码已过期", nil)];
            break;
        case AuthenticationDID:
            [[FLTools share]showErrorInfo:NSLocalizedString(@"钱包DID不匹配", nil)];
            break;
        default:
            break;
    }
    
}
-(void)QrCodeInfoPasswordViewInfoText:(NSDictionary*)PayLoadDic withJWTString:(NSString*)jwtString WithType:(QrCodeSignatureType)type{
    HWMQrCodeInfoPasswordViewController *PasswordVC=[[HWMQrCodeInfoPasswordViewController alloc]init];
    PasswordVC.PayLoadDic = PayLoadDic;
    PasswordVC.jwtString = jwtString;
    PasswordVC.currentWallet = self.currentWallet;
    PasswordVC.type=type;
    [self.navigationController pushViewController:PasswordVC animated:NO];
}

-(void)showAdviceInfoText:(NSDictionary*)PayLoadDic withJWTString:(NSString*)jwtString WithType:(QrCodeSignatureType)type{
    
    HWMSuggestionViewController *SuggestionVC=[[HWMSuggestionViewController alloc]init];
    switch (type) {
        case suggestionQrCodeType:
            SuggestionVC.VCType=SuggestionType;
            break;
        case billQrCodeType:
            SuggestionVC.VCType=TheProposalType;
            break;
        default:
            break;
    }
    
    SuggestionVC.PayLoadDic=PayLoadDic;
    SuggestionVC.jwtString=jwtString;
    SuggestionVC.currentWallet=self.currentWallet;
    [self.navigationController pushViewController:SuggestionVC animated:YES];
}

-(void)ShowPlayInfoText:(NSDictionary*)PayLoadDic withJWTString:(NSString*)jwtString{
    HWMDIDAuthorizationViewController *DIDAuthorizationVC=[[HWMDIDAuthorizationViewController alloc]init];
    DIDAuthorizationVC.DIDString=self.currentWallet.didString;
    DIDAuthorizationVC.CRInfoDic=PayLoadDic;
    DIDAuthorizationVC.mastWalletID=self.currentWallet.masterWalletID;
    DIDAuthorizationVC.JWTString=jwtString;
    [self.navigationController pushViewController:DIDAuthorizationVC animated:NO];
}

-(void)GetTransactionSignedInfoWhereForm:(BOOL)isPWD{
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.QRCoreDic[@"extra"][@"SubWallet"],self.QRCoreDic[@"data"]] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
    PluginResult * result =[[ELWalletManager share]GetTransactionSignedInfo:mommand];
    
    if ([result.status  isEqual:@1]) {
        
        
        NSArray *SignArry=[NSArray arrayWithArray:result.message[@"success"]];
        
        for (NSDictionary *dic in SignArry) {
            self.SignStatusModel.N=dic[@"N"];
            self.SignStatusModel.M=dic[@"M"];
            NSObject *obj=dic[@"Signers"];
            
            if ([obj isKindOfClass:[NSArray class]]) {
                self.SignStatusModel.Signers=[NSArray arrayWithArray:dic[@"Signers"]].count;
            }
            if ([dic[@"SignType"] isEqualToString:@"MultiSign"]) {
                self.SignStatusModel.isHowSign=YES;
                if ([self.SignStatusModel.M integerValue]>self.SignStatusModel.Signers) {
                    self.SignStatusModel.isSignCom=NO;
                    NSObject *obj=dic[@"Signers"];
                    
                    if ([obj isKindOfClass:[NSArray class]]) {
                        self.SignStatusModel.Signers=[NSArray arrayWithArray:dic[@"Signers"]].count;
                    }
                }else{
                    self.SignStatusModel.isSignCom=YES;
                }
                
                //
            }else{
                self.SignStatusModel.isHowSign=NO;
                self.SignStatusModel.M=@"1";
            }
            
        }
        
        if (self.SignStatusModel.isSignCom==NO) {
            UIView *mainView=[self mainWindow];
            [mainView addSubview:self.pwdPopupV];
            [self.pwdPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(mainView);
            }];
        }else{
            if (isPWD) {
                [self cancelThePWDPageView];
            }
            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
            if (self.SignStatusModel.isHowSign) {
                SignatureTradingSingleQrCodeVC.type=HowSignSignedDeals;
            }else{
                SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
            }
            
            NSDictionary *successDic=[[NSDictionary alloc]initWithDictionary:[[FLTools share]dictionaryWithJsonString:self.QRCoreDic[@"data"]]]; SignatureTradingSingleQrCodeVC.QRCodeString =self.QRCoreDic[@"data"];
            SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=successDic;
            SignatureTradingSingleQrCodeVC.currentWallet=self.currentWallet; SignatureTradingSingleQrCodeVC.subW=self.QRCoreDic[@"extra"][@"SubWallet"];
            
            SignatureTradingSingleQrCodeVC.SignStatus=self.SignStatusModel;
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
            
        }
        
        
    }
    
}
-(HMWpwdPopupView *)pwdPopupV{
    if (!_pwdPopupV) {
        _pwdPopupV=[[HMWpwdPopupView alloc]init];
        _pwdPopupV.delegate=self;
        _pwdPopupV.backgroundColor=RGBA(0, 0, 0, 0.5);
    }
    return _pwdPopupV;
    
}
-(void)makeSureWithPWD:(NSString*)pwd{
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.QRCoreDic[@"extra"][@"SubWallet"],self.QRCoreDic[@"data"],pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"MSignAndReadOnlyCreateTransaction"];
    PluginResult *result = [[ELWalletManager share]SignTransaction:mommand];
    NSString *statue=[NSString stringWithFormat:@"%@",result.status];
    
    if ([statue isEqualToString:@"1"]) {
        if (self.SignStatusModel.Signers+1==[self.SignStatusModel.M integerValue]) {
            [self publishtransaction:result.message[@"success"]];
        }else{
            HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
            if (self.SignStatusModel.isHowSign) {
                SignatureTradingSingleQrCodeVC.type=HowSignSignedDeals;
            }else{
                SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
            }
            [self cancelThePWDPageView];
            
            NSDictionary *successDic=[[NSDictionary alloc]initWithDictionary:result.message[@"success"]]; SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:successDic];
            SignatureTradingSingleQrCodeVC.currentWallet=self.currentWallet;
            SignatureTradingSingleQrCodeVC.SignStatus=self.SignStatusModel; SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=result.message[@"success"];
            SignatureTradingSingleQrCodeVC.subW=self.QRCoreDic[@"extra"][@"SubWallet"];
            [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
            
        }
    }
    
}
-(void)cancelThePWDPageView{
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV=nil;
    
}
-(HWMSignStatusModel *)SignStatusModel{
    if (!_SignStatusModel) {
        _SignStatusModel =[[HWMSignStatusModel alloc]init];
    }
    return _SignStatusModel;
}
-(void)publishtransaction:(id)data{
    [self cancelThePWDPageView];
    if ([[FLTools share] connectedToNetwork]) {
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,self.QRCoreDic[@"extra"][@"SubWallet"],[[FLTools share] DicToString:data]] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"publishtransaction"];
        PluginResult *result = [[ELWalletManager share]publishtransaction:mommand];
        NSString *statue=[NSString stringWithFormat:@"%@",result.status];
        if ([statue isEqualToString:@"1"]){
            [self showSendSuccessPopuV];
        }
    }else{
        self.SignStatusModel.isSignCom=YES;
        HWMSignatureTradingSingleQrCodeViewController *SignatureTradingSingleQrCodeVC=[[HWMSignatureTradingSingleQrCodeViewController alloc]init];
        if (self.SignStatusModel.isHowSign) {
            SignatureTradingSingleQrCodeVC.type=HowSignSignedDeals;
        }else{
            SignatureTradingSingleQrCodeVC.type=SingleSignReadOnlyToBeSigned;
        }
        NSDictionary *successDic=[[NSDictionary alloc]initWithDictionary:data]; SignatureTradingSingleQrCodeVC.QRCodeString =[[FLTools share]DicToString:successDic];
        SignatureTradingSingleQrCodeVC.currentWallet=self.currentWallet;
        SignatureTradingSingleQrCodeVC.QRCodeSignatureDic=data;
        SignatureTradingSingleQrCodeVC.SignStatus=self.SignStatusModel; SignatureTradingSingleQrCodeVC.subW=self.QRCoreDic[@"extra"][@"SubWallet"];
        [self.navigationController pushViewController:SignatureTradingSingleQrCodeVC animated:YES];
        
    }
    
    
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    }
    
    return _sendSuccessPopuV;
}
-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenSendSuccessPopuV];
    });
}
-(void)hiddenSendSuccessPopuV{
    [self.sendSuccessPopuV removeFromSuperview];
    self.sendSuccessPopuV=nil;
}
-(HMWToDeleteTheWalletPopView *)openIDChainView{
    if (!_openIDChainView) {
        _openIDChainView =[[HMWToDeleteTheWalletPopView alloc]init];
        _openIDChainView.delegate=self;
    }
    return _openIDChainView;
}
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    [self toCancelOrCloseDelegate];
    HMWAddTheCurrencyListViewController *AddTheCurrencyListVC=[[HMWAddTheCurrencyListViewController alloc]init];
    AddTheCurrencyListVC.wallet=self.currentWallet;
    AddTheCurrencyListVC.didType=@"didType";
    AddTheCurrencyListVC.delegate=self;
    [self.navigationController pushViewController:AddTheCurrencyListVC animated:YES];
}
-(void)toCancelOrCloseDelegate{
    [self.openIDChainView removeFromSuperview];
    self.openIDChainView=nil;
    
}
-(void)openIDChainOfDIDAddWithWallet:(NSString*)walletID{
    self.needOpen=YES;
    
    //    [self ParseTheQrCodeJumpEventWithType:self.QRType withData:self.QRCodeData tsWithQRCodeString:self.QRCodeString];
}
-(void)parsingQRCodeDataWithType:(QrCodeSignatureType)type withDicData:(id)data withQRString:(NSString*)qrString{
    HWMCommentPerioDetailsViewController *CommentPerioDetailsVC=[[HWMCommentPerioDetailsViewController alloc]init];
    if (type==reviewPropalQrCodeType) {
        CommentPerioDetailsVC.type=CommentPerioVOTINGType;
    }else if (type==voteforProposalQrCodeType){
        CommentPerioDetailsVC.type=CommentPerioNOTIFICATIONType;
    }
    CommentPerioDetailsVC.qrString=qrString;
    CommentPerioDetailsVC.DicData=data;
    CommentPerioDetailsVC.codeSignatureT=type;
    
    CommentPerioDetailsVC.whereFrome=@"FirstView";
    [self.navigationController pushViewController:CommentPerioDetailsVC animated:NO];
}
@end
