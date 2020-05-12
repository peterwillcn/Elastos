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


#import "HWMImplementationScheduleView.h"
#import "HWMCommitteeMembersToVoteTableViewCell.h"
#import "HWMSecretaryGeneralTableViewCell.h"
static NSString *cellCommitteeMembersToVote=@"HWMCommitteeMembersToVoteTableViewCell";
static NSString *cellSecretaryGeneralString=@"HWMSecretaryGeneralTableViewCell";

UINib *CommitteeMembersToVoteNib;
UINib *SecretaryGeneralNib;
@interface HWMImplementationScheduleView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTable;

@end

@implementation HWMImplementationScheduleView
-(instancetype)init{
    self=[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMImplementationScheduleView" owner:nil options:nil].firstObject;
         [self makeView];
    }
    return self;
}
-(void)makeView{
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.rowHeight=44;
    //    self.baseTable.separatorInset=UIEdgeInsetsMake(-0, 15, 0, 15);
    self.baseTable.backgroundColor=[UIColor clearColor];
    CommitteeMembersToVoteNib=[UINib nibWithNibName:cellCommitteeMembersToVote bundle:nil];
    [self.baseTable registerNib: CommitteeMembersToVoteNib forCellReuseIdentifier:cellCommitteeMembersToVote];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
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
    HWMCommitteeMembersToVoteTableViewCell *cell=[CommitteeMembersToVoteNib instantiateWithOwner:nil options:nil].firstObject;
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView*)sesionHeadView{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 40)];
    UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 40)];
    headLabel.text=NSLocalizedString(@"第一阶段", nil);
    [headView addSubview:headLabel];
    return headView;;
}
@end
