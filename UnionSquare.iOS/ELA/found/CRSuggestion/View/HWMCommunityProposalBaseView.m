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


#import "HWMCommunityProposalBaseView.h"
#import "HWMCommunityProposalBaseTableViewCell.h"
#import "HWMCommentPerioDetailsViewController.h"
#import "HWMBillListModel.h"
CGFloat  BillListCellHeight=55;
static NSString *cellBaseString=@"HWMCommunityProposalBaseTableViewCell";
UINib *_basenib;
@interface HWMCommunityProposalBaseView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *baseTabView;
@property(assign,nonatomic)NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *textLable;
@property (weak, nonatomic) IBOutlet UIView *placeBGvew;
@end

@implementation HWMCommunityProposalBaseView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMCommunityProposalBaseView" owner:nil options:nil].firstObject;
        [self makeView];
        self.allTotle=1;
        self.index=1;
        self.placeBGvew.alpha=0.f;
        self.textLable.text=NSLocalizedString(@"暂无提案", nil);
    }
    return self;
}
-(void)makeView{
    self.baseTabView.separatorStyle= UITableViewCellSeparatorStyleNone;
    _basenib=[UINib nibWithNibName:cellBaseString bundle:nil];
    [self.baseTabView registerNib:_basenib forCellReuseIdentifier:cellBaseString];
    self.baseTabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    __weak __typeof(self) weakSelf = self;
    MJRefreshHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.index=0;
        if ([weakSelf.delegate respondsToSelector:@selector(needUpdateDataSource)]) {
            [weakSelf.delegate needUpdateDataSource];
        }
        [self.baseTabView.mj_header endRefreshing];
        [self.baseTabView.mj_footer endRefreshing];
    }];
    self.baseTabView.mj_header=header;
    self.baseTabView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.index++;
        if (weakSelf.index<weakSelf.allTotle) {
            if ([weakSelf.delegate respondsToSelector:@selector(loadListDataSourceWithIndex:)]) {
                [weakSelf.delegate loadListDataSourceWithIndex:weakSelf.index];
            }
        }
        [self.baseTabView.mj_header endRefreshing];
        [self.baseTabView.mj_footer endRefreshing];
    }];
    self.baseTabView.delegate=self;
    self.baseTabView.dataSource=self;
    [self.baseTabView reloadData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMCommunityProposalBaseTableViewCell *cell=  [_basenib instantiateWithOwner:nil options:nil][0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (self.searchString.length>0) {
        cell.isSearch=YES;
    }
    cell.model=self.dataSourceArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMBillListModel *model=self.dataSourceArray[indexPath.row];
    return model.lastCellHeight+BillListCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didShowDetailsWithIndex:)]) {
        [self.delegate didShowDetailsWithIndex:indexPath.row];
    }
}
-(void)setDataSourceArray:(NSMutableArray *)dataSourceArray{
    _dataSourceArray=dataSourceArray;
    if (dataSourceArray.count==0) {
        if (self.searchString.length==0) {
           self.placeBGvew.alpha=1.f;
        }
       
    }else{
        self.placeBGvew.alpha=0.f;
    }
    [self.baseTabView reloadData];
    [self.baseTabView.mj_header endRefreshing];
    [self.baseTabView.mj_footer endRefreshing];
}
-(void)setAllTotle:(NSInteger)allTotle{
    if (allTotle<10) {
        _allTotle=1;
    }else{
        _allTotle=allTotle/10+1;
    }
}
-(void)setSearchString:(NSString *)searchString{
    _searchString=searchString;
}
@end
