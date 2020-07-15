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
#import "ELWalletManager.h"


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
    [self loadAddress];
}
-(void)setWalletIDListArray:(NSMutableArray *)walletIDListArray{
    _walletIDListArray =walletIDListArray;
}
-(void)loadAddress{
    for (int i=0; i<self.walletIDListArray.count; i++) {
        FMDBWalletModel *model=self.walletIDListArray[i];
        invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID] callbackId:model.walletID className:@"wallet" methodName:@"createMasterWallet"];
        PluginResult * resultBase =[[ELWalletManager share]getMasterWalletBasicInfo:cmommand];
        NSString *statusBase=[NSString stringWithFormat:@"%@",resultBase.status];
        NSDictionary *baseDic=[[NSDictionary alloc]init];
        if ([statusBase isEqualToString:@"1"] ) {
            baseDic=[[FLTools share]dictionaryWithJsonString:resultBase.message[@"success"]];
            NSString *Readonly=[NSString stringWithFormat:@"%@",baseDic[@"Readonly"]];
            if ([Readonly isEqualToString:@"0"]) {
                if ([baseDic[@"M"] integerValue]==1) {
                    model.TypeW=SingleSign;
                }else{
                    model.TypeW=HowSign;
                }
            }else{
                if ([baseDic[@"M"] integerValue]==1) {
                    model.TypeW=SingleSignReadonly;
                }else{
                    model.TypeW=HowSignReadonly;
                }
            }
        }
        
        
        self.walletIDListArray[i] =model;
    }
    [self.baseTableView reloadData];
}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
 self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.rowHeight=50;
    self.baseTableView.separatorStyle= UITableViewCellSeparatorStyleNone;

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
