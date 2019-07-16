//
//  HMWMyVoteViewController.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWMyVoteViewController.h"
#import "HMWmyVoteStatisticsTableViewCell.h"
#import "ELWalletManager.h"
#import "FLChangeVotedTicketsVC.h"
#import "FLCoinPointInfoModel.h"
static NSString *cellString=@"HMWmyVoteStatisticsTableViewCell";
@interface HMWMyVoteViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfTheWalletLabel;
@property (weak, nonatomic) IBOutlet UILabel *theWalletAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *waitingForTheImageView;
@property (weak, nonatomic) IBOutlet UIImageView *largeStateImageView;
@property (weak, nonatomic) IBOutlet UIImageView *stateIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *votesLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteInTotalLabel;
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property (weak, nonatomic) IBOutlet UIButton *changeVotesButton;
@property (weak, nonatomic) IBOutlet UIView *changeVotesBGView;
@property(nonatomic,strong)UILabel  *placeHolderLab;

@property (weak, nonatomic) IBOutlet UILabel *lastVoteLab;

@property(nonatomic,strong)NSArray *dataSource;

@end

@implementation HMWMyVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [[HMWCommView share]makeBordersWithView:self.changeVotesButton];
    [[HMWCommView share]makeBordersWithView:self.BGView];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"我的投票", nil) ;
    
    self.lastVoteLab.text =NSLocalizedString(@"上次投票记录", nil);
    [self.changeVotesButton setTitle:NSLocalizedString(@"重新投票", nil) forState:UIControlStateNormal];
    [self makeView];
    FLWallet *waller = [ELWalletManager share].currentWallet;
    IMainchainSubWallet *subWallet = [[ELWalletManager share]getWalletELASubWallet:waller.masterWalletID];
    String balanceSt = subWallet->GetBalance(Elastos::ElaWallet::Total);
    NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
    NSInteger balance=[balanceString integerValue];
    self.nameOfTheWalletLabel.text = waller.walletName;
    self.votesLabel.text = [NSLocalizedString(@"表决票权：", nil) stringByAppendingString:@(balance/unitNumber).stringValue];
    
//    self.theWalletAddressLabel.text = waller.walletAddress;
    [self getDataFromData];
}
-(void)getDataFromData{
    FLWallet *waller = [ELWalletManager share].currentWallet;
    IMainchainSubWallet *subWallet = [[ELWalletManager share]getWalletELASubWallet:waller.masterWalletID];
    Json cArray = subWallet->GetVotedProducerList();
    NSString *dataStr = [NSString stringWithUTF8String:cArray.dump().c_str()];
    
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

    NSMutableArray *showlistdata = [NSMutableArray array];
    NSInteger total =0;
    for (int i=0; i<param.allKeys.count; i++) {
        NSString *itemKey = param.allKeys[i];
        for (int j = 0;j<self.listData.count; j++) {
            FLCoinPointInfoModel *model = self.listData[j];
            if ([model.ownerpublickey isEqualToString:itemKey]) {
                model.hadVotedNumber = [param[itemKey] integerValue];
                [showlistdata addObject:model];
                total+=[param[itemKey] integerValue];
            }
        }
        
    }
    self.voteInTotalLabel.text = @(total/unitNumber).stringValue;
    self.dataSource = showlistdata;
    if (self.dataSource.count==0) {
        self.changeVotesButton.alpha=0.f;
     self.stateIconImageView.image=[UIImage imageNamed:@"my_vote_unlocked"];
    }else{
         self.changeVotesButton.alpha=1.f;
        self.stateIconImageView.image=[UIImage imageNamed:@"my_vote_going_on"];
    }
    [self.baseTableView reloadData];
    self.placeHolderLab.hidden  = self.dataSource.count==0? NO: YES;
    
}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    self.baseTableView.rowHeight=70;
   self.baseTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.baseTableView.bounces = NO;
    [self.baseTableView addSubview:self.placeHolderLab];
    [self.placeHolderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.baseTableView);
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FLCoinPointInfoModel *model = self.dataSource[indexPath.row];
    
   HMWmyVoteStatisticsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.leftLab.text = model.nickname;
    cell.rightLab.text =[NSString stringWithFormat:@"NO.%ld",model.index+1];
    return cell;
    
}
-(UILabel *)placeHolderLab
{
    if (!_placeHolderLab) {
        _placeHolderLab = [UIView FLLab_TextColor:[UIColor grayColor] Fort:18];
        _placeHolderLab.text =NSLocalizedString(@"暂无投票记录", nil) ;
        _placeHolderLab.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolderLab;
}
- (IBAction)changeVote:(id)sender {
    FLChangeVotedTicketsVC *vc = [[FLChangeVotedTicketsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
