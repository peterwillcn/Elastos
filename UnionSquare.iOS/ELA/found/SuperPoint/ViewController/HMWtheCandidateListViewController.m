//
//  HMWtheCandidateListViewController.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWtheCandidateListViewController.h"
#import "HMWtheCandidateListTableViewCell.h"


static NSString *cellString=@"HMWtheCandidateListTableViewCell";
@interface HMWtheCandidateListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *immediatelyToVoteButton;
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

@end

@implementation HMWtheCandidateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@"tab_bg"];
    self.title=@"超级节点选举";
    [[HMWCommView share]makeBordersWithView:self.immediatelyToVoteButton];
    [self makeView];
    
}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    self.baseTableView.rowHeight=70;
//    self.baseTableView.separatorInset=UIEdgeInsetsMake(-0, 15, 0, 15);
    self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   HMWtheCandidateListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    HMWtransferTransactionDetailsViewController *transferTransactionDetailsVC=[[HMWtransferTransactionDetailsViewController alloc]init];
//    [self.navigationController pushViewController:transferTransactionDetailsVC animated:YES];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
