//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import "HWMTheMessageCenterViewController.h"
#import "HWMTheMessageCenterTableViewCell.h"
#import "HWMMessageCenterModel.h"
#import "HMWFMDBManager.h"
#import "HWMAllNoView.h"
#import "HWMTheMessageSettingViewController.h"
#import "HMWTheLatestMessagetTableViewCell.h"
static NSString *cellString=@"HWMTheMessageCenterTableViewCell";
static NSString *TheLatestMessaget=@"HMWTheLatestMessagetTableViewCell";
@interface HWMTheMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTabView;
@property(strong,nonatomic)NSMutableArray *MessageList;
@property(strong,nonatomic)HWMAllNoView *NoView;
@property(assign,nonatomic)NSInteger allCount;
@property(assign,nonatomic)NSInteger UNREADNumber;
@property(assign,nonatomic)NSInteger LastreadTime;
@end

@implementation HWMTheMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"消息中心", nil);
    self.UNREADNumber=-1;
    self.LastreadTime=[[FLTools share]readLastReadTime];
    UIBarButtonItem *ClickMorenButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"asset_wallet_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(messageCenterSetting)];
    self.navigationItem.rightBarButtonItem=ClickMorenButton;
    [self makeView];
    [[FLTools share] sethasMessageNeedRead:@"0"];
    if (self.MessageList.count==0) {
        [self.baseTabView addSubview:self.NoView];
    }
    self.allCount=[[HMWFMDBManager sharedManagerType:MessageCenterType]allMessageCount];
    [self findNunreadMessageIndexWithFomeIndex:0];
}
-(NSMutableArray *)MessageList{
    if (!_MessageList) {
        
        _MessageList=[[NSMutableArray alloc]initWithArray:[[HMWFMDBManager sharedManagerType:MessageCenterType]allMessageListWithIndex:0]];
        
    }
    return _MessageList;
}
-(void)messageCenterSetting{
    HWMTheMessageSettingViewController *TheMessageSettingVC=[[HWMTheMessageSettingViewController alloc]init];
    [self.navigationController pushViewController:TheMessageSettingVC animated:YES];
}
-(void)makeView{
    
    self.baseTabView.delegate=self;
    self.baseTabView.dataSource=self;
    self.baseTabView.backgroundColor=[UIColor clearColor];
    self.baseTabView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.baseTabView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    [self.baseTabView registerNib:[UINib nibWithNibName:TheLatestMessaget bundle:nil] forCellReuseIdentifier:TheLatestMessaget];
    self.baseTabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    __weak __typeof(self) weakSelf = self;
    MJRefreshHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         weakSelf.UNREADNumber=-1;
        [[FLTools share]setLastReadTime];
      weakSelf.UNREADNumber=[[FLTools share]readLastReadTime];
        [weakSelf.MessageList removeAllObjects];
        [weakSelf.MessageList addObjectsFromArray:[[HMWFMDBManager sharedManagerType:MessageCenterType]allMessageListWithIndex:0]];
        [weakSelf findNunreadMessageIndexWithFomeIndex:0];
        [weakSelf.baseTabView reloadData];
        [weakSelf.baseTabView.mj_header endRefreshing];
        
    }];
    self.baseTabView.mj_header=header;
    self.baseTabView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        HWMMessageCenterModel *model=weakSelf.MessageList.lastObject;
        if (model.walletName.length==0) {
            [weakSelf.MessageList removeLastObject];
        }
        if (weakSelf.MessageList.count<weakSelf.allCount) {
            [weakSelf.MessageList addObjectsFromArray:[[HMWFMDBManager sharedManagerType:MessageCenterType]allMessageListWithIndex:weakSelf.MessageList.count]];
        }
        [self findNunreadMessageIndexWithFomeIndex:(int)weakSelf.MessageList.count];
        [weakSelf.baseTabView.mj_footer endRefreshing];
        [weakSelf.baseTabView reloadData];
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.MessageList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==self.UNREADNumber) {
        HMWTheLatestMessagetTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TheLatestMessaget];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.model=self.MessageList[indexPath.row];
        return cell;
    }
    HWMTheMessageCenterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.model=self.MessageList[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.UNREADNumber ==indexPath.row) {
        return  110;
    }
    return 75;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    HWMnodeConnectionSettingsDetailsViewController *nodeConnectionSettingsDetailsVC=[[HWMnodeConnectionSettingsDetailsViewController alloc]init];
    //    nodeConnectionSettingsDetailsVC.wallet=self.wallet;
    //    nodeConnectionSettingsDetailsVC.model=self.currencyArray[indexPath.row];
    //    [self.navigationController pushViewController:nodeConnectionSettingsDetailsVC animated:YES];
}
-(HWMAllNoView *)NoView{
    if (!_NoView) {
        _NoView=[[HWMAllNoView alloc]init];
        _NoView.type=meeeagerType;
    }
    return _NoView;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[FLTools share]setLastReadTime];
}
-(void)findNunreadMessageIndexWithFomeIndex:(int)fmIndex{
    
    for (int i=fmIndex; i<self.MessageList.count; i++) {
        HWMMessageCenterModel *model=self.MessageList[i];
        if (self.LastreadTime<[model.time intValue] ) {
            self.UNREADNumber=i+1;
        }
    }
    if (self.UNREADNumber==self.MessageList.count) {
        HWMMessageCenterModel *model=[[HWMMessageCenterModel alloc]init];
        [self.MessageList addObject:model];
    }
}
@end
