//
//  HMWChooseSideChainViewController.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWChooseSideChainViewController.h"
#import "HMWSideChainAndTheContactTableViewCell.h"
#import "HMWTop_upPageForDetailsViewController.h"
#import "assetsListModel.h"
#import "HMWFMDBManager.h"


static NSString *cellString=@"HMWSideChainAndTheContactTableViewCell";

@interface HMWChooseSideChainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTable;
/*
 *<# #>
 */
@property(assign,nonatomic)NSIndexPath *selectIndexPath;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *friedsListArray;


@end

@implementation HMWChooseSideChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];

    if (self.type==chooseSideChainType) {
           self.title=NSLocalizedString(@"选择侧链", nil);
    }else if (self.type==chooseFriendsType){
        self.title=NSLocalizedString(@"选择联系人", nil);
        
    }
    [self makeView];
    [self.baseTable reloadData];
}
-(NSArray *)friedsListArray{
    if (!_friedsListArray) {
        _friedsListArray =[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:friendsModelType]allRecord]];
    }
    return _friedsListArray;
}
-(void)makeView{
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.rowHeight=44;
    self.baseTable.separatorInset=UIEdgeInsetsMake(-0, 15, 0, 15);
    self.baseTable.backgroundColor=[UIColor clearColor];
    [self.baseTable registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.type ==chooseSideChainType) {
        return 1;
//     return self.supportOfTheCurrencyArray.count-1;
    }
    if (self.type==chooseFriendsType) {
     return self.friedsListArray.count;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMWSideChainAndTheContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
//    cell.type=0;
    cell.backgroundColor=[UIColor clearColor];
    if (self.type==chooseSideChainType) {
        if (self.selectIndexPath==indexPath) {
            cell.selectImageView.alpha=1.f;
        }else{
            cell.selectImageView.alpha=0.f;
        }
       
        
//        assetsListModel *model=self.supportOfTheCurrencyArray[indexPath.section+1];
        cell.iChinaLabel.text=@"IDChain";
    }else if (self.type==chooseFriendsType){
        if (self.selectIndexPath==indexPath) {
            cell.selectImageView.image=[UIImage imageNamed:@"asset_linkman_select"];
        }else{
            cell.selectImageView.image=[UIImage imageNamed:@"asset_linkman"];
        }
        friendsModel *model=self.friedsListArray[indexPath.section];
        cell.iChinaLabel.text=model.nameString;
    }
  
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.type==chooseSideChainType) {
        if (self.selectIndexPath) {
            HMWSideChainAndTheContactTableViewCell *cell =[tableView cellForRowAtIndexPath:self.selectIndexPath];
            cell.selectImageView.alpha=0.f;
        }
        
        
        HMWSideChainAndTheContactTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.selectImageView.alpha=1.f;
        cell.selectImageView.image=[UIImage imageNamed:@"asset_adding_select"];
        
    }else if (self.type==chooseFriendsType){
        
        
        //        asset_linkman_select
        //    asset_linkman
        if (self.selectIndexPath) {
            HMWSideChainAndTheContactTableViewCell *cell =[tableView cellForRowAtIndexPath:self.selectIndexPath];
            cell.selectImageView.image=[UIImage imageNamed:@"asset_linkman"];
        }
        
        
        HMWSideChainAndTheContactTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        cell.selectImageView.image=[UIImage imageNamed:@"asset_linkman_select"];
    }
    
   
        
        
    
    self.selectIndexPath=indexPath;
    if (self.type==chooseSideChainType) {
        HMWTop_upPageForDetailsViewController *top_upPageForDetailsVC=[[HMWTop_upPageForDetailsViewController alloc]init];
        top_upPageForDetailsVC.title=NSLocalizedString(@"侧链充值", nil);
        assetsListModel *model=[[assetsListModel alloc]init];
        model.iconName=@"IDChain";
        top_upPageForDetailsVC.selectmModel=model;
        top_upPageForDetailsVC.currentWallet=self.currentWallet;
        top_upPageForDetailsVC.fromModel=self.model;
        top_upPageForDetailsVC.type=sideChainTop_upType;
        top_upPageForDetailsVC.addressArray=self.addressArray;
        [self.navigationController pushViewController:top_upPageForDetailsVC animated:YES];
        
    }else if (self.type ==chooseFriendsType){
        if (self.delegate) {
            friendsModel *model=self.friedsListArray[indexPath.section];
            [self.delegate choosedFriedsMode:model];
        }
        [self.navigationController popViewControllerAnimated:YES];
        }
    
    
    
    
    
    
}
-(void)setType:(ChooseSideChainType)type{
    _type=type;
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
    
}
-(void)setModel:(assetsListModel *)model{
    _model=model;
}
-(void)setSupportOfTheCurrencyArray:(NSArray *)supportOfTheCurrencyArray{
_supportOfTheCurrencyArray=supportOfTheCurrencyArray;
}
-(void)setAddressArray:(NSArray *)addressArray{
    _addressArray=addressArray;
    
}
@end
