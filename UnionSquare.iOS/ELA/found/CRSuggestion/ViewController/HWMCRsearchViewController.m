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


#import "HWMCRsearchViewController.h"
#import "HWMCRSuggestionNetWorkManger.h"
#import "HWMCommentPerioDetailsViewController.h"
#import "HWMBillListViewModel.h"
#import "HWMCommunityProposalBaseView.h"
#import "HWMCollectionProposalPerformViewController.h"
@interface HWMCRsearchViewController ()<HWMCommunityProposalBaseViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backVC;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property(strong,nonatomic)HWMCommunityProposalBaseView *allBaseView;
@property(strong,nonatomic)HWMBillListViewModel*allBillListVM;
@property(strong,nonatomic)NSMutableArray*allBillListAarray;
@property (weak, nonatomic) IBOutlet UIView *searchResultsView;

@property(strong,nonatomic)UILabel*NoSearchLbael;
@end

@implementation HWMCRsearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    UIView *righView =[[UIView alloc]initWithFrame: CGRectMake(0,0, 34, 34)];
    UIImageView *rightImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 14, 14)];
    rightImageView.image=[UIImage imageNamed:@"cr_search_icon"];
    [righView addSubview:rightImageView];
    self.searchTextField.leftView=righView;
    self.searchTextField.leftViewMode=UITextFieldViewModeAlways;
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.searchTextField withTxt:NSLocalizedString(@"请输入提案号、提案名称或提案人", nil)];
    [self.searchResultsView addSubview:self.allBaseView];
    [self.allBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.searchResultsView);
    }];
    [self.searchButton setTitle:NSLocalizedString(@"搜索", nil) forState:UIControlStateNormal];
    self.searchResultsView.alpha=0.f;
    
}
-(UILabel *)NoSearchLbael{
    if (!_NoSearchLbael) {
        _NoSearchLbael=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, AppWidth-30, 20)];
        _NoSearchLbael.text=NSLocalizedString(@"没有搜索结果。", nil);
        _NoSearchLbael.font=[UIFont systemFontOfSize:14];
        _NoSearchLbael.textColor=RGBA(255, 255, 255, 0.5);
        _NoSearchLbael.textAlignment=NSTextAlignmentCenter;
        [self.searchResultsView addSubview:_NoSearchLbael];
    }
    return _NoSearchLbael;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)searchEvent:(id)sender {
    [self.view endEditing:YES];
    if (self.searchTextField.text.length==0) {
        return;
    }
    [self.allBillListAarray removeAllObjects];
    [self loadDataSourceWithIndex:1];
}
- (IBAction)backEV:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
-(HWMCommunityProposalBaseView *)allBaseView{
    if (!_allBaseView) {
        _allBaseView=[[HWMCommunityProposalBaseView alloc]init];
        _allBaseView.delegate=self;
        
    }
    return _allBaseView;
}
-(void)didShowDetailsWithIndex:(NSInteger)index{
    HWMBillListModel *model=self.allBillListAarray[index];
    if ([model.status isEqualToString:NSLocalizedString(@"委员评议",nil)]) {
        HWMCommentPerioDetailsViewController *CommentPerioDetailsVC=[[HWMCommentPerioDetailsViewController alloc]init];
        CommentPerioDetailsVC.model=model;
        CommentPerioDetailsVC.type=CommentPerioVOTINGType;
        [self.navigationController pushViewController:CommentPerioDetailsVC animated:YES];
    }else if ([model.status isEqualToString:NSLocalizedString(@"公示中",nil)]){
        
        HWMCommentPerioDetailsViewController *CommentPerioDetailsVC=[[HWMCommentPerioDetailsViewController alloc]init];
        CommentPerioDetailsVC.model=model;
        CommentPerioDetailsVC.type=CommentPerioNOTIFICATIONType;
        [self.navigationController pushViewController:CommentPerioDetailsVC animated:YES];
    }else if ([model.status isEqualToString:NSLocalizedString(@"执行中",nil)]){
        HWMCollectionProposalPerformViewController *CollectionProposalPerformVC=[[HWMCollectionProposalPerformViewController alloc]init];
        CollectionProposalPerformVC.model=model;
        [self.navigationController pushViewController:CollectionProposalPerformVC animated:YES];
    }else if ([model.status isEqualToString:NSLocalizedString(@"已完成",nil)]){
        HWMCollectionProposalPerformViewController *CollectionProposalPerformVC=[[HWMCollectionProposalPerformViewController alloc]init];
        CollectionProposalPerformVC.model=model;
        [self.navigationController pushViewController:CollectionProposalPerformVC animated:YES];
    }else if ([model.status isEqualToString:NSLocalizedString(@"未通过",nil)]){
        HWMCommentPerioDetailsViewController *CommentPerioDetailsVC=[[HWMCommentPerioDetailsViewController alloc]init];
        CommentPerioDetailsVC.model=model;
        CommentPerioDetailsVC.type=CommentPerioREJECTEDType;
        [self.navigationController pushViewController:CommentPerioDetailsVC animated:YES];
    }else if ([model.status isEqualToString:NSLocalizedString(@"已否决",nil)]){
        HWMCommentPerioDetailsViewController *CommentPerioDetailsVC=[[HWMCommentPerioDetailsViewController alloc]init];
        CommentPerioDetailsVC.model=model;
        CommentPerioDetailsVC.type=CommentPerioVETOEDType;
        [self.navigationController pushViewController:CommentPerioDetailsVC animated:YES];
    }
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
    if (self.searchTextField.text.length==0) {
        return;
    }
    [self showLoading];
    self.allBillListVM.searchString=self.searchTextField.text;
    self.allBaseView.searchString=self.searchTextField.text;
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]searchReloadCRSuggestionDataSourceWithType:0 withStartIndex:staIndex withNumbers:10 withSearchContent:self.searchTextField.text withComplete:^(id  _Nonnull data) {
        [self.allBillListVM BillListWithDataJosn:data[@"data"][@"list"]  completion:^(NSArray * _Nonnull dataArray) {
            if (dataArray.count>0) {
                [self.allBillListAarray addObjectsFromArray:dataArray];
                //                self.allBaseView.dataSourceArray=self.allBillListAarray;
            }
            if (self.allBillListAarray.count>0) {
                self.searchResultsView.alpha=1.f;
                self.NoSearchLbael.alpha=0.f;
                self.searchResultsView.userInteractionEnabled=YES;
            }else{
                self.searchResultsView.alpha=1.f;
                self.searchResultsView.userInteractionEnabled=NO;
                self.NoSearchLbael.alpha=1.f;
            }
            self.allBaseView.dataSourceArray=self.allBillListAarray;
            id total=data[@"data"][@"total"];
            self.allBaseView.allTotle=[total intValue];
            [self hiddLoading];
        }];
        
    }];
    
    
}
@end
