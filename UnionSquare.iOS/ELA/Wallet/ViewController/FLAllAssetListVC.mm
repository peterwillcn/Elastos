//
//  FLAllAssetListVC.m
//  FLWALLET
//
//  Created by  on 2018/4/26.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLAllAssetListVC.h"
#import "FLAssetManageTableCell.h"
#import "MJRefresh.h"

@interface FLAllAssetListVC ()<UITableViewDataSource,FLAssetManageTableCellDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong)NSMutableArray*dataSource;
/*
 *当前页数
 */
@property(assign,nonatomic)NSInteger current;
/*
 *总页数
 */
@property(assign,nonatomic) NSInteger allPageNumber;

/*
 *NO up YES Down
 */
@property(assign,nonatomic)BOOL isUpOrDown;

@end

@implementation FLAllAssetListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultBack];
    self.current=1;
    self.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.table.tableFooterView = [[UIView alloc]init];
    self.table.dataSource =self;
    [self.view addSubview:_table];
    self.table.tableFooterView = [[UIView alloc]init];
    
    [self.table registerNib:[UINib nibWithNibName:@"FLAssetManageTableCell" bundle:nil] forCellReuseIdentifier:@"FLAssetManageTableCell"];
    self.title  = @"添加新资产";
    self.table.rowHeight = 40;
    __weak __typeof__(self) weakSelf = self;
    self.table.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.current=1;
        weakSelf.isUpOrDown=YES;
    }];
    self.table.mj_footer= [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.current++;
        
        if(weakSelf.current>weakSelf.allPageNumber) {
            [weakSelf endUpDataRJ];
            return ;
        }
        
        weakSelf.isUpOrDown=NO;
        
    }];
}
-(void)endUpDataRJ{
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLAssetManageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLAssetManageTableCell"];
    
//    FLAllKindBi *model = self.dataSource[indexPath.row];
    cell.nameLab.text = @"ela";
    cell.delegate = self;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 5;
    return self.dataSource.count;
}
#pragma mark celldelegate
-(void)swichChange:(UISwitch *)swich model:(FLAllKindBi *)model
{
    swich.on = !swich.on;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [HttpUrl canleURL];
}

@end
