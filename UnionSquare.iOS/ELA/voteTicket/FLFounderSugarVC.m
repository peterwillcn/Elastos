//
//  FLSugarVC.m
//  FLWALLET
//
//  Created by  on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLFounderSugarVC.h"
#import "FLSugarTableCell.h"
#import "FLSugarModel.h"


@interface FLFounderSugarVC()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong)NSMutableArray *dataSouse;
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, strong)NSArray   *bannerData;

@end

@implementation FLFounderSugarVC

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
   
    self.title = @"糖果";
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    
    
    [self.table registerNib:[UINib nibWithNibName:@"FLSugarTableCell" bundle:nil] forCellReuseIdentifier:@"FLSugarTableCell"];
    self.table.rowHeight = 100;
    self.table.dataSource =self;
    self.table.delegate =self;
    
    _currentIndex = 1;

    UIView *v= [[UIView alloc]initWithFrame:CGRectMake(0, -150, AppWidth, 150)];
    v.backgroundColor = defultColor;
    [self.table insertSubview:v atIndex:0];
    self.table.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 20)];
 //  [self getSugarData];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // FLSugarModel *model = self.dataSouse[indexPath.row];
    FLSugarTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLSugarTableCell"];
//    NSString *imagename = [NSString stringWithFormat:@"card%ld",indexPath.row%5];
//    cell.backImage.image = [UIImage imageNamed:imagename];
//    cell.model = model;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataSouse.count;

    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FLSugarModel *model = self.dataSouse[indexPath.row];
//    [self dealWithActivityId:model model1:nil];
}

-(NSMutableArray *)dataSouse
{
    if (!_dataSouse) {
        _dataSouse = [NSMutableArray array];
    }
    return _dataSouse;
}

@end
