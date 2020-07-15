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


#import "HWMCommunityProposalViewController.h"
#import "HWMCommunityProposalBaseView.h"
#import "HWMCRsearchViewController.h"
#import "HWMCommentPerioDetailsViewController.h"
#import "HWMCommunityProposalScrollView.h"
#import "HWMallBaseViewController.h"
#import "HWMMemberReviewBaseViewController.h"
#import "HWMpublicBaseViewController.h"
#import "HWMexecutionBaseViewController.h"
#import "HWMcompletedBaseViewController.h"
#import "HWMabolishedBaseViewController.h"
#import "HWMCRSuggestionNetWorkManger.h"
#import "HWMSecretaryGeneralAndMembersDetailsViewModel.h"
#import "FMDBWalletModel.h"
#import "HMWFMDBManager.h"
#import "HWMDIDManager.h"
@interface HWMCommunityProposalViewController ()<UIScrollViewDelegate,HWMCommunityProposalScrollViewDelegate>
@property(strong,nonatomic)UIImageView *placeHolferImage;
@property (weak, nonatomic) IBOutlet UIScrollView *baseScroView;
@property(strong,nonatomic)HWMallBaseViewController *allBaseVC;
@property(strong,nonatomic)HWMMemberReviewBaseViewController *MemberReviewBaseVC;
@property(strong,nonatomic)HWMpublicBaseViewController *publicBaseVC;
@property(strong,nonatomic)HWMCommunityProposalScrollView *CommunityProposalSV;
@property (weak, nonatomic) IBOutlet UIView *scBGView;
@property(assign,nonatomic)NSInteger selectIndex;
@property(strong,nonatomic)NSMutableArray*allBillListAarray;
@property(assign,nonatomic)NSInteger  startContentOffsetX;
@end

@implementation HWMCommunityProposalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"社区提案", nil);
    self.selectIndex=0;
    [self makeUI];
}
-(HWMCommunityProposalScrollView *)CommunityProposalSV{
    if (!_CommunityProposalSV) {
        _CommunityProposalSV =[[HWMCommunityProposalScrollView alloc]init];
        _CommunityProposalSV.delegate=self;
    }
    return _CommunityProposalSV;
}
-(void)makeUI{
    
    UIBarButtonItem *ClickMorenButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cr_search_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(searchVC)];
    self.navigationItem.rightBarButtonItem=ClickMorenButton;
    [self.scBGView addSubview:self.CommunityProposalSV];
    [self.CommunityProposalSV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.scBGView);
    }];
    self.baseScroView.showsVerticalScrollIndicator = NO;
    self.baseScroView.showsHorizontalScrollIndicator = NO;
    self.baseScroView.pagingEnabled = YES;
    self.baseScroView.delegate = self;
    self.allBaseVC=[[HWMallBaseViewController alloc]init];
    [self addChildViewController:self.allBaseVC];
    [self.baseScroView addSubview:self.allBaseVC.view];
    
    [self.allBaseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseScroView.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.baseScroView.mas_left).offset(0);
        make.width.mas_equalTo(@(AppWidth));
    }];
    self.MemberReviewBaseVC=[[HWMMemberReviewBaseViewController alloc]init];
    [self addChildViewController:self.MemberReviewBaseVC];
    [self.baseScroView addSubview:self.MemberReviewBaseVC.view];
    
    [self.MemberReviewBaseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.allBaseVC.view);
        make.width.mas_equalTo(@(AppWidth));
        make.left.equalTo(self.allBaseVC.view.mas_left).offset(AppWidth);
    }];
    self.publicBaseVC=[[HWMpublicBaseViewController alloc]init];
    [self addChildViewController:self.publicBaseVC];
    [self.baseScroView addSubview:self.publicBaseVC.view];
    
    [self.publicBaseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.allBaseVC.view);
        make.width.mas_equalTo(@(AppWidth));
        make.left.equalTo(self.MemberReviewBaseVC.view.mas_right).offset(0);
    }];
    HWMexecutionBaseViewController *executionBaseVC=[[HWMexecutionBaseViewController alloc]init];
    [self addChildViewController:executionBaseVC];
    [self.baseScroView addSubview:executionBaseVC.view];
    
    [executionBaseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.allBaseVC.view);
        make.width.mas_equalTo(@(AppWidth));
        make.left.equalTo(self.publicBaseVC.view.mas_right).offset(0);
    }];
    
    HWMcompletedBaseViewController *completedBaseVC=[[HWMcompletedBaseViewController alloc]init];
    [self addChildViewController:completedBaseVC];
    [self.baseScroView addSubview:completedBaseVC.view];
    [completedBaseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.allBaseVC.view);
        make.width.mas_equalTo(@(AppWidth));
        make.left.equalTo(executionBaseVC.view.mas_right).offset(0);
    }];
    HWMabolishedBaseViewController *abolishedBaseVC=[[HWMabolishedBaseViewController alloc]init];
    [self addChildViewController:abolishedBaseVC];
    
    [self.baseScroView addSubview:abolishedBaseVC.view];
    [abolishedBaseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.allBaseVC.view);
        make.width.mas_equalTo(@(AppWidth));
        make.left.equalTo(completedBaseVC.view.mas_right).offset(0);
    }];
    self.baseScroView.contentSize = CGSizeMake(AppWidth*6,0);
}

-(void)showContextViewWithTag:(NSInteger)tag{
    [self.baseScroView setContentOffset:CGPointMake(AppWidth*tag, 0.0f)];
    self.selectIndex=tag;
}
-(void)searchVC{
    HWMCRsearchViewController  *searchVC=[[HWMCRsearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:NO];
}
-(void)CommunityProposalScrollWithIndex:(NSInteger)index{
    [self showContextViewWithTag:index];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.startContentOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger pageindex=scrollView.contentOffset.x/AppWidth;
    [self showTitleWithIndex:pageindex];
}
-(void)showTitleWithIndex:(NSInteger)index{
    self.selectIndex=index;
    [self.CommunityProposalSV selectTitleWithIndex:index];
}
-(NSMutableArray *)allBillListAarray{
    if (!_allBillListAarray) {
        _allBillListAarray=[[NSMutableArray alloc]init];
    }
    return _allBillListAarray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self hiddLoading];
}
-(void)setDetailsModel:(HWMSecretaryGeneralAndMembersDetailsModel *)detailsModel{
    _detailsModel=detailsModel;
}
@end
