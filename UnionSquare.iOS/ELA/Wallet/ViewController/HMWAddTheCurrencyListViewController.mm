//
//  HMWAddTheCurrencyListViewController.m
//  ELA
//
//  Created by  on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWAddTheCurrencyListViewController.h"
#import "HMWAddTheCurrencyListTableViewCell.h"
#import "ELWalletManager.h"
#import "assetsListModel.h"
#import "AddTheCurrencyListModel.h"
#import "sideChainInfoModel.h"
#import "HMWFMDBManager.h"
#import "HMWToDeleteTheWalletPopView.h"
static NSString *cellString=@"HMWAddTheCurrencyListTableViewCell";
@interface HMWAddTheCurrencyListViewController ()<UITableViewDataSource,UITableViewDelegate,HMWAddTheCurrencyListTableViewCellDelegate,HMWToDeleteTheWalletPopViewDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *addTheCurrencyList;
/*
 *<# #>
 */
@property(strong,nonatomic)UITableView *baseTable;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL needUpdate;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *CloseIDChainView;
@property(assign,nonatomic)NSInteger selcIndex;

@end

@implementation HMWAddTheCurrencyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"添加币种", nil);
    [self makeView];
    [self loadTheCurrencyList];
    self.needUpdate=NO;
}
-(void)loadTheCurrencyList{
    invokedUrlCommand * cmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"getSupportedChains"];
    PluginResult *result=
    [[ELWalletManager share]getSupportedChains:cmommand];
    NSArray *arr=[NSArray arrayWithArray:result.message[@"success"]];
    for (int i=0; i<arr.count; i++) {
        NSString *iconName = arr[i];
        AddTheCurrencyListModel *listModel=[[AddTheCurrencyListModel alloc]init];
        listModel.nameIcon=iconName;
        listModel.isAdd=NO;
        for (assetsListModel *model in self.openedTheSubstringArrayList) {
            if ([model.iconName isEqualToString:iconName]){
                listModel.isAdd=YES;
            }
        }
        if ([listModel.nameIcon isEqualToString:@"ELA"]||[listModel.nameIcon isEqualToString:@"IDChain"]) {
            [self.addTheCurrencyList addObject:listModel];
        }
    }
    [self.baseTable reloadData];
    
}
-(NSMutableArray *)addTheCurrencyList{
    if (!_addTheCurrencyList) {
        _addTheCurrencyList =[[NSMutableArray alloc]init];
    }
    return _addTheCurrencyList;
}
-(void)makeView{
    
    self.baseTable=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.rowHeight=55;
    
    self.baseTable.backgroundColor=[UIColor clearColor];
    [self.baseTable registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTable.scrollEnabled=NO;
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.baseTable];
    CGFloat heOff=64;
    if (AppHeight>736) {
        heOff=106;
    }
    [self.baseTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(heOff);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.addTheCurrencyList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return NULL;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return NULL;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMWAddTheCurrencyListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    //    cell.backgroundColor=[UIColor clearColor];
    cell.model=self.addTheCurrencyList[indexPath.section];
    cell.delegate=self;
    cell.index=indexPath;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
-(void)setWallet:(FLWallet *)wallet{
    _wallet=wallet;
    
}
-(void)setOpenedTheSubstringArrayList:(NSArray *)openedTheSubstringArrayList{
    _openedTheSubstringArrayList=openedTheSubstringArrayList;
    
    
}
-(void)isOpenOrCloseWithIndex:(NSIndexPath*)index{
    self.selcIndex=index.section;
    AddTheCurrencyListModel *model=self.addTheCurrencyList[index.section];
    NSString *methodNameString=@"";
    if (model.isAdd) {
        methodNameString=@"";
    }
    invokedUrlCommand * cmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,model.nameIcon,@"10000"] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"methodNameString"];
    if (model.isAdd) {
        UIView *mainView=[self mainWindow];
        [mainView addSubview:self.CloseIDChainView];
        [self.CloseIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
        
    }else{
        AddTheCurrencyListModel *model=self.addTheCurrencyList[index.section];
        model.isAdd=YES;
        self.addTheCurrencyList[index.section]=model;
        [self.baseTable reloadData];
        PluginResult *result = [[ELWalletManager share]createSubWallet:cmommand];
        
        sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
        sideModel.walletID=self.wallet.masterWalletID;
        sideModel.sideChainName=model.nameIcon;
        sideModel.sideChainNameTime=@"--:--";
        sideModel.thePercentageMax=@"100";
        sideModel.thePercentageCurr=@"0";
        
        [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
        if (self.didType.length>0) {
            if (self.didType.length>0) {
                if (self.delegate) {
                    [self.navigationController popViewControllerAnimated:NO];
                    [self.delegate openIDChainOfDIDAddWithWallet:self.wallet.masterWalletID];
                }
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }
    }
    
    
    
    
    
    self.needUpdate=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.needUpdate) {
        [[NSNotificationCenter defaultCenter] postNotificationName:updataWallet object:@"index"];
        //         addObserver:self selector:@selector(updataWalletListInfo:) name:updataWallet object:nil];
        
    }
    
}

-(HMWToDeleteTheWalletPopView *)CloseIDChainView{
    if (!_CloseIDChainView) {
        _CloseIDChainView=[[HMWToDeleteTheWalletPopView alloc]init];
        _CloseIDChainView.deleteType=CloseChainIDType;
        _CloseIDChainView.delegate=self;
    }
    return _CloseIDChainView;
}
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    AddTheCurrencyListModel *model=self.addTheCurrencyList[self.selcIndex];
    model.isAdd=NO;
    invokedUrlCommand * cmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,model.nameIcon,@"10000"] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"methodNameString"];
    
    self.addTheCurrencyList[self.selcIndex]=model;
    [self.baseTable reloadData];
    PluginResult *result=
    [[ELWalletManager share]DestroySubWallet:cmommand];
    [[HMWFMDBManager sharedManagerType:sideChain] delectSideChain:self.wallet.masterWalletID withIconName:model.nameIcon];
    [self toCancelOrCloseDelegate];
}
-(void)toCancelOrCloseDelegate{
    
    [self.CloseIDChainView  removeFromSuperview];
    self.CloseIDChainView=nil;
}

@end
