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


#import "HWMCollectionProposalPerformViewController.h"
#import "HWMCommentPerioDetailsHeadView.h"
#import "HWMCommunityProposalBaseTableViewCell.h"
#import "HWMCommitteeMembersToVoteView.h"
#import "HWMCRProposalConfirmView.h"
#import "HMWSendSuccessPopuView.h"
static NSString *BaseTableViewCell=@"HWMCommunityProposalBaseTableViewCell";
@interface HWMCollectionProposalPerformViewController ()<UITableViewDelegate,UITableViewDataSource,HWMCRProposalConfirmViewDelgate>
@property (weak, nonatomic) IBOutlet UITableView *baseTable;

@property(strong,nonatomic)HMWSendSuccessPopuView*sendSuccessPopuV;
@property(strong,nonatomic)HWMCommentPerioDetailsHeadView*headView;
@property(strong,nonatomic)HWMCommitteeMembersToVoteView*foodView;
@property(strong,nonatomic)HWMCRProposalConfirmView*CRProposalConfirmV;

@end

@implementation HWMCollectionProposalPerformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"提案执行", nil);
    [self makeView];
}
-(void)makeView{
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.rowHeight=44;
    //    self.baseTable.separatorInset=UIEdgeInsetsMake(-0, 15, 0, 15);
    self.baseTable.backgroundColor=[UIColor clearColor];
    [self.baseTable registerNib:[UINib nibWithNibName:BaseTableViewCell bundle:nil] forCellReuseIdentifier:BaseTableViewCell];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 60)];
    [headView addSubview:self.headView ];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(headView);
    }];
    self.baseTable.tableHeaderView=headView;
    UIView *foodView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 300)];
    [foodView addSubview:self.foodView];
    [self.foodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(foodView);
    }];
    self.baseTable.tableFooterView=foodView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
    HWMCommunityProposalBaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:BaseTableViewCell];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(HWMCommentPerioDetailsHeadView *)headView{
    if (!_headView) {
        _headView =[[HWMCommentPerioDetailsHeadView alloc]init];
    }
    return _headView;
}
-(HWMCommitteeMembersToVoteView *)foodView{
    if (!_foodView) {
        _foodView=[[HWMCommitteeMembersToVoteView alloc]init];
    }
    return _foodView;;
    
}
@end
