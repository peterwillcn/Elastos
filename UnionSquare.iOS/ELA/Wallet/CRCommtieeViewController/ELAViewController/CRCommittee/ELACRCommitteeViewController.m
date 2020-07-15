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
#import "ELACRCommitteeViewController.h"
#import "UIViewController+FLVCExt.h"
#import "RPTaggedNavView.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"
#import "ELACommitteeListViewController.h"
#import "ELASecretaryListViewController.h"
#import "ELANetwork.h"
#import "ELACouncilAndSecretariatModel.h"

@interface ELACRCommitteeViewController ()<UIScrollViewDelegate, RPTaggedNavViewDelegate>

@property (nonatomic, strong) UIScrollView * bgScroll;
@property (nonatomic, strong) RPTaggedNavView *taggedNavView;

@property (nonatomic, strong) ELACouncilAndSecretariatModel *model;

@property (nonatomic, strong) ELACommitteeListViewController *committeeVc;
@property (nonatomic, strong) ELASecretaryListViewController *secretaryVc;

 
@end

@implementation ELACRCommitteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defultWhite];
    //    [self setBackgroundImg:@""];
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self CAGradientColorFrome:ELARGB(83, 136, 136) withToColor:ELARGB(16, 47, 58) withView:bg];
    [self.view addSubview:bg];
    
    self.taggedNavView = [[RPTaggedNavView alloc]initWithFrame:CGRectMake(0, NavigitionBarHeight, ScreenWidth, 44)];
    self.taggedNavView.delegate = self;
    self.taggedNavView.dataArr = [NSArray arrayWithObjects:ELALocalizedString(@"委员列表"), ELALocalizedString(@"秘书长列表"), nil];
    self.taggedNavView.tagTextColor_normal = ELARGB(149, 159, 171);
    self.taggedNavView.tagTextColor_selected = [UIColor whiteColor];
    self.taggedNavView.tagTextFont_normal = 15;
    self.taggedNavView.tagTextFont_selected = 15;
    self.taggedNavView.sliderColor = [UIColor whiteColor];
    self.taggedNavView.sliderW =  100;
    self.taggedNavView.sliderH = 1.5;
    self.taggedNavView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.taggedNavView];

    self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.taggedNavView.bottomY, ScreenWidth, ScreenHeight - self.taggedNavView.bottomY)];
    self.bgScroll.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    self.bgScroll.delegate = self;
    self.bgScroll.pagingEnabled = YES;
    _bgScroll.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.bgScroll];
//    if(iPhoneX)
//    {
//        [_bgScroll setFrame:CGRectMake(0, self.taggedNavView.bottomY, ScreenWidth, ScreenHeight - self.taggedNavView.bottomY - 16)];
//    }
    
    ELACommitteeListViewController *committeeVc = [[ELACommitteeListViewController alloc] init];
    [committeeVc creatViewWithInitFrame:CGRectMake(0, 0, ScreenWidth, _bgScroll.height)];
    committeeVc.index = _index;
    [self addChildViewController:committeeVc];
    [_bgScroll addSubview:committeeVc.view];
    
    
    ELASecretaryListViewController *secretaryVc = [[ELASecretaryListViewController alloc] init];
    [secretaryVc creatViewWithInitFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _bgScroll.height)];
    secretaryVc.index = _index;
    [self addChildViewController:secretaryVc];
    [_bgScroll addSubview:secretaryVc.view];
    
    _committeeVc = committeeVc;
    _secretaryVc = secretaryVc;
    [self getNetworkData];
}

#pragma mark -- Network

- (void)getNetworkData
{
    [self showLoadingView];
    ELAWeakSelf;
    [ELANetwork getCouncilListInfo:_index block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf hideLoadingView];
            if(error)
            {
                if(error.code == -999)
                {
                    //已取消
                }
                else
                {
                    [weakSelf showErrorInfo:error.localizedDescription];

                }
            }
            else
            {
                weakSelf.model = data;
                weakSelf.committeeVc.infoModel = weakSelf.model;
                weakSelf.secretaryVc.infoModel = weakSelf.model;
                [weakSelf.committeeVc reloadTableView];
                 [weakSelf.secretaryVc reloadTableView];
            }
        });
        
    }];
}

#pragma mark -- taggedNavViewDelegate
- (void)haveSelectedIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.4 animations:^{
        self.bgScroll.contentOffset = CGPointMake(ScreenWidth * index, 0);
    }];
   
}

#pragma mark -- scrollviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger selectedIndx = scrollView.contentOffset.x / ScreenWidth;
    [self.taggedNavView selectingOneTagWithIndex:selectedIndx];
}

//-(void)setBackgroundImg{
//    UIImageView *bg = [[UIImageView alloc]initWithFrame:self.bounds];
//        [self CAGradientColorFrome:RGB(83, 136, 136) withToColor:RGB(16, 47, 58) withView:bg];
//    [self insertSubview:bg atIndex:0];
//    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self);
//    }];
//}

-(void)CAGradientColorFrome:(UIColor*)fclolr withToColor:(UIColor*)tcolor withView:(UIView*)view{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,AppWidth,AppHeight);
    gl.colors = @[(__bridge id)fclolr.CGColor,(__bridge id)tcolor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer addSublayer:gl];
    
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
