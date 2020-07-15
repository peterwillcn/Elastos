//
//  HMWAddressListViewController.m
//  ELA
//
//  Created by  on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWAddressListViewController.h"
#import "HMWaddressListTableViewCell.h"

static NSString *cellString=@"HMWaddressListTableViewCell";

@interface HMWAddressListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTable;

@end

@implementation HMWAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self defultWhite];
     [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"地址列表", nil);

    [self makeView];
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
    return self.addressListArray.count;
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
    HMWaddressListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.backgroundColor=[UIColor clearColor];
cell.addressLabel.text=self.addressListArray[indexPath.section];
cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setAddressListArray:(NSArray *)addressListArray{
    _addressListArray=addressListArray;
    
}
@end
