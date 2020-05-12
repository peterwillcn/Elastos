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


#import "HWMallBaseViewController.h"
#import "HWMCommunityProposalBaseView.h"
#import "HWMCommentPerioDetailsViewController.h"
#import "HWMBillListViewModel.h"
#import "HWMCRSuggestionNetWorkManger.h"
@interface HWMallBaseViewController ()<HWMCommunityProposalBaseViewDelegate>
@property(strong,nonatomic)HWMCommunityProposalBaseView *allBaseView;
@property(strong,nonatomic)HWMBillListViewModel*allBillListVM;
@property(strong,nonatomic)NSMutableArray*allBillListAarray;

@end

@implementation HWMallBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.allBaseView];
    [self.allBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
    }];
    [self loadDataSourceWithIndex:1];
}
-(HWMCommunityProposalBaseView *)allBaseView{
    if (!_allBaseView) {
        _allBaseView=[[HWMCommunityProposalBaseView alloc]init];
        _allBaseView.delegate=self;
    }
    return _allBaseView;
}
-(void)didShowDetailsWithIndex:(NSInteger)index{
    HWMCommentPerioDetailsViewController *CommentPerioDetailsVC=[[HWMCommentPerioDetailsViewController alloc]init];
    [self.navigationController pushViewController:CommentPerioDetailsVC animated:YES];
    
}
-(void)needUpdateDataSource{
    [self.allBillListAarray removeAllObjects];
    [self loadDataSourceWithIndex:1];
}
-(void)loadListDataSourceWithIndex:(NSInteger)index{
    [self loadDataSourceWithIndex:index];
}
-(NSMutableArray *)allBillListAarray{
    if (!_allBillListAarray) {
        _allBillListAarray =[[NSMutableArray alloc]init];
    }
    return _allBillListAarray;
}
-(HWMBillListViewModel *)allBillListVM{
    if (!_allBillListVM) {
        _allBillListVM=[[HWMBillListViewModel alloc]init];
    }
    return _allBillListVM;
}
-(void)loadDataSourceWithIndex:(NSInteger)staIndex{
    
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadCRSuggestionDataSourceWithType:0 withStartIndex:staIndex withNumbers:10 withComplete:^(_Nonnull id data) {
        
        [self.allBillListVM BillListWithDataJosn:data[@"data"][@"list"] completion:^(NSArray * _Nonnull dataArray) {
            if (dataArray.count>0) {
                [self.allBillListAarray addObjectsFromArray:dataArray];
                self.allBaseView.dataSourceArray=self.allBillListAarray;
                id total=data[@"data"][@"total"];
                self.allBaseView.allTotle=[total intValue];
            }
            
        }];
        
    }];
    
}
@end
