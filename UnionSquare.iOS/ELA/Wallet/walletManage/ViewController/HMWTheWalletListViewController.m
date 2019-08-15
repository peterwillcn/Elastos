//
//  HMWTheWalletListViewController.m
//  ELA
//
//  Created by  on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWTheWalletListViewController.h"
#import "HMWtheWalletListTableViewCell.h"
#import "HMWaddWalletListTableViewCell.h"
#import "FLPrepareVC.h"
#import "FMDBWalletModel.h"
#import "HMWFMDBManager.h"


static NSString *cellString=@"HMWtheWalletListTableViewCell";
static NSString *celladdString=@"HMWaddWalletListTableViewCell";

@interface HMWTheWalletListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
/*
 *<# #>
 */
@property(strong,nonatomic)NSIndexPath * selectIndex;
/*
 *<# #>
 */
//@property(strong,nonatomic)NSMutableArray *walletListArray;
/*
 *
 */
@property(assign,nonatomic) BOOL needUpdate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *walletIDListArray;
@end

@implementation HMWTheWalletListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    self.needUpdate=NO;
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"钱包列表", nil);
    [self makeView];
    self.selectIndex=[NSIndexPath indexPathForRow:0 inSection:self.currentWalletIndex];
    [self.baseTableView reloadData];
//    [self loadAddress];
    
}
-(NSArray *)walletIDListArray{
    if (!_walletIDListArray) {
        
        
        _walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    }
    return _walletIDListArray;
    
}

-(void)loadAddress{
//
//    for (FMDBWalletModel *model in self.walletListArray) {
////          invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.Wallet.masterWalletID,self.Wallet.mnemonic,self.Wallet.mnemonicPWD,self.Wallet.passWord,isSingleAddress] callbackId:self.Wallet.walletID className:@"wallet" methodName:@"createMasterWallet"];
//    }
    
    
}
//-(NSMutableArray *)walletListArray{
//    if (!_walletListArray) {
//        _walletListArray =[[NSMutableArray alloc]initWithArray:[[HMWFMDBManager sharedManagerType:walletType]allRecordWallet:self.walletIDListArray]];
//    }
//    return _walletListArray;
//}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
 self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.rowHeight=70;
    self.baseTableView.separatorStyle=UITableViewCellSelectionStyleNone;

    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    [self.baseTableView registerNib:[UINib nibWithNibName:celladdString bundle:nil] forCellReuseIdentifier:celladdString];
    
  
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        
        return self.walletIDListArray.count+1;
    }
    
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==self.walletIDListArray.count) {
        HMWaddWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:celladdString];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=RGBA(255, 255, 255, 0.15);
        return cell;
        
    }
    
    HMWtheWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.model=self.walletIDListArray[indexPath.section];
    cell.selectView.alpha=0.f;
    if (self.currentWalletIndex==indexPath.section) {
        cell.selectView.alpha=1.f;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==self.walletIDListArray.count) {
        FLPrepareVC *VC=[[FLPrepareVC alloc]init];
        VC.type=addWalletType;
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    if (self.selectIndex) {
        HMWtheWalletListTableViewCell *cell=[tableView cellForRowAtIndexPath:self.selectIndex];
        cell.selectView.alpha=0.f;
    }
    self.selectIndex=indexPath;
    HMWtheWalletListTableViewCell *cell=[tableView cellForRowAtIndexPath:self.selectIndex];
    cell.selectView.alpha=1.f;
    if (self.currentWalletIndex !=indexPath.section) {
        self.needUpdate=YES;
    }else{
        self.needUpdate=NO;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        
        return 0.01;
    }
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
 
    return 5;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
 
    
    UIView *fooView =[[UIView alloc]init];
    
    fooView.backgroundColor=[UIColor clearColor];
    
    return fooView;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if (self.needUpdate) {
        if ([self.delegate respondsToSelector:@selector(needUpdateInfo: withSelectIndex:)]) {
            FMDBWalletModel *model=self.walletIDListArray[self.selectIndex.section];
            FLWallet *wallet=[[FLWallet alloc]init];
            wallet.walletName=model.walletName;
            wallet.masterWalletID=model.walletID;
//            wallet.walletAddress=mode
            [self.delegate needUpdateInfo:wallet withSelectIndex: self.selectIndex.section];
        }
    }
    
}
- (void)setCurrentWalletIndex:(NSInteger)currentWalletIndex{
    _currentWalletIndex=currentWalletIndex;
    
    
}
@end
