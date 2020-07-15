//
//  HMWMyVoteViewController.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWMyVoteViewController.h"
#import "HMWmyVoteStatisticsTableViewCell.h"
static NSString *cellString=@"HMWmyVoteStatisticsTableViewCell";
@interface HMWMyVoteViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfTheWalletLabel;
@property (weak, nonatomic) IBOutlet UILabel *theWalletAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *waitingForTheImageView;
@property (weak, nonatomic) IBOutlet UIImageView *largeStateImageView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *stateIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *votesLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteInTotalLabel;
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property (weak, nonatomic) IBOutlet UIButton *changeVotesButton;
@property (weak, nonatomic) IBOutlet UIView *changeVotesBGView;

@end

@implementation HMWMyVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [[HMWCommView share]makeBordersWithView:self.changeVotesButton];
    [[HMWCommView share]makeBordersWithView:self.BGView];
    [self setBackgroundImg:@"tab_bg"];
    self.title=@"我的投票";
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
    
   HMWmyVoteStatisticsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    HMWtransferTransactionDetailsViewController *transferTransactionDetailsVC=[[HMWtransferTransactionDetailsViewController alloc]init];
    //    [self.navigationController pushViewController:transferTransactionDetailsVC animated:YES];
    
}

@end
