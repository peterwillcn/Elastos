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


#import "ELACommitteeDetailViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "SYRingProgressView.h"
#import "RPTaggedNavView.h"
#import "UIView+Ext.h"
#import "ELACommitteeInfoViewController.h"
#import "ELACommitteeDutiesViewController.h"
#import "ELANetwork.h"
#import "ELAInformationDetail.h"
#import "ELWalletManager.h"
#import "ELAImpeachView.h"
#import "ELAPasswdView.h"
#import "ELAVotingProcessUtil.h"

@interface ELACommitteeDetailViewController ()<RPTaggedNavViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) SYRingProgressView *ringProgress;
@property (nonatomic, strong) UIScrollView * bgScroll;
@property (nonatomic, strong) RPTaggedNavView *taggedNavView;
@property (nonatomic, strong) ELAImpeachView *impeachView;
@property (nonatomic, strong) ELAPasswdView *passwdView;
@property (nonatomic, strong) ELAInformationDetail *model;

@property (nonatomic, strong) NSString *passwdValue;
@property (nonatomic, strong) NSString *impeachValue;


@property (nonatomic, strong) ELAVotingProcessUtil *votingProcessUtil;
@end


@implementation ELACommitteeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getNetworkData];
}
#pragma mark -

- (void)buttonAction:(id)sender
{
    
    ELAWeakSelf;
    _impeachView = [[ELAImpeachView alloc] init];
    [_impeachView showAlertView];
    
    [_impeachView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(0));
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(ScreenHeight));
        make.top.bottom.equalTo(@(0));
    }];
    _impeachView.valueBlock = ^(NSString *value){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.impeachValue = value;
            [weakSelf showPasswdView];
        });
        
    };
       
//    _passwdView = [[ELAPasswdView alloc] init];
//    [_passwdView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(@(0));
//        make.width.equalTo(@(ScreenWidth));
//        make.height.equalTo(@(ScreenHeight));
//        make.top.bottom.equalTo(@(0));
//    }];
//    _passwdView.valueBlock = ^(NSString *value){
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [weakSelf impeachment];
//        });
//
//    };
//    FLWallet *wallet = [ELWalletManager share].currentWallet;
    
//    invokedUrlCommand *mommand = [[invokedUrlCommand alloc] initWithArguments:@[wallet.masterWalletID]
//                                                            callbackId:wallet.walletID className:@"Wallet" methodName:@"createProposalWithdrawTransaction"];
//     [[ELWalletManager share] getVoteInfoList:wallet.masterWalletID];

    //get
}
- (void)showPasswdView
{
    ELAWeakSelf;
    _passwdView = [[ELAPasswdView alloc] init];
    [_passwdView showAlertView];
       [_passwdView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(@(0));
           make.width.equalTo(@(ScreenWidth));
           make.height.equalTo(@(ScreenHeight));
           make.top.bottom.equalTo(@(0));
       }];
       _passwdView.valueBlock = ^(NSString *value){

           dispatch_async(dispatch_get_main_queue(), ^{

               weakSelf.passwdValue = value;
               [weakSelf impeachment];
           });

       };
}
- (void)impeachment
{
    [self showLoading];
    NSString *amount = [[FLTools share] elsToSela:_impeachValue];
    NSString *hash = _model.cid;
    
    ELAWeakSelf;
   _votingProcessUtil = [ELAVotingProcessUtil shareVotingProcess];
    _votingProcessUtil.networkStateBlock = ^(BOOL networkState){
        if(networkState)//成功
        {
            [weakSelf.votingProcessUtil getImpeachmentWithNetworkState:hash amount:amount];
        }
    };
    _votingProcessUtil.getImpeachmentBlock = ^(NSDictionary * _Nonnull votes, NSArray * _Nonnull invalidCandidates){
        //获取数据
        [weakSelf toImpeachment:votes :invalidCandidates];
        
    };
    [_votingProcessUtil getVoteInfo];
}

- (void)toImpeachment:(NSDictionary *)votes :(NSArray *)invalidCandidates
{
    FLWallet *wallet = [ELWalletManager share].currentWallet;
    
    invokedUrlCommand *mommand = [[invokedUrlCommand alloc] initWithArguments:
                                  @[wallet.masterWalletID,
                                    _passwdValue,
                                    votes,
                                    invalidCandidates]
                                                                   callbackId:wallet.walletID
                                                                    className:@"Wallet" methodName:@"CreateImpeachmentCRCTransaction"];
    PluginResult *pluginResult = [[ELWalletManager share] CreateImpeachmentCRCTransaction:mommand];
    
    if(pluginResult)
    {
        NSDictionary *resultDic = pluginResult.message[@"success"];
    }
    [self hiddLoading];
    
}
#pragma mark - taggedNavViewDelegate
- (void)haveSelectedIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.4 animations:^{
        self.bgScroll.contentOffset = CGPointMake(ScreenWidth * index, 0);
    }];
   
}

#pragma mark - Network

- (void)getNetworkData
{
    [self showLoadingView];
    ELAWeakSelf;
    [ELANetwork getInformation:_paramModel.did ID:_index block:^(id  _Nonnull data, NSError * _Nonnull error) {
        
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
                [weakSelf creatView];
            }
        });
        
    }];
}

#pragma mark - scrollviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger selectedIndx = scrollView.contentOffset.x / ScreenWidth;
    [self.taggedNavView selectingOneTagWithIndex:selectedIndx];
}

#pragma mark - View
- (void)creatButtonView:(UIView *)view
{
    UIView *infoView = [[UIView alloc]  init];
    infoView.backgroundColor = ELARGB(12, 27, 33);
    [self.view addSubview:infoView];
    
    UIButton *button = [[UIButton alloc] init];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1;
    button.backgroundColor = ELARGB(37, 52, 59);
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = PingFangRegular(14);
    [button setTitle:ELALocalizedString(@"弹劾该委员") forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [infoView addSubview:button];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(view.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(250));
        make.top.equalTo(infoView).offset(25);
        make.height.equalTo(@(40));
    }];
    
    UIView *_line = [[UIView alloc] init];
    _line.backgroundColor = ELARGB(149, 159, 171);
    [infoView addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView);
        make.top.equalTo(infoView.mas_top).offset(0);
        make.right.equalTo(infoView);
        make.height.equalTo(@(0.5));
    }];
}

- (void)creatTabView:(UIView *)view
{
    self.taggedNavView = [[RPTaggedNavView alloc]initWithFrame:CGRectMake(0, view.bottomY, ScreenWidth, 44)];
    self.taggedNavView.delegate = self;
    //NSString stringWithFormat:@"履职记录(%d)", _model.term.count
//    ELALocalizedString(@"履职记录(4)"),
    NSString *titleStr = [NSString stringWithFormat:@"%@(%lu)", ELALocalizedString(@"履职记录"), _model.term.count];
    self.taggedNavView.dataArr = [NSArray arrayWithObjects:ELALocalizedString(@"委员信息"),
                                  titleStr, nil];
    self.taggedNavView.tagTextColor_normal = ELARGB(149, 159, 171);
    self.taggedNavView.tagTextColor_selected = [UIColor whiteColor];
    self.taggedNavView.tagTextFont_normal = 15;
    self.taggedNavView.tagTextFont_selected = 15;
    self.taggedNavView.sliderColor = [UIColor whiteColor];
    self.taggedNavView.sliderW =  100;
    self.taggedNavView.sliderH = 1.5;
    self.taggedNavView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.taggedNavView];
    
    self.bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.taggedNavView.bottomY, ScreenWidth, ScreenHeight - self.taggedNavView.bottomY - BottomHeight - 90)];
    self.bgScroll.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    self.bgScroll.delegate = self;
    self.bgScroll.pagingEnabled = YES;
    _bgScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bgScroll];
    
    ELACommitteeInfoViewController *committeeVc = [[ELACommitteeInfoViewController alloc] init];
    [committeeVc creatViewWithInitFrame:CGRectMake(0, 0, ScreenWidth, _bgScroll.height)];
    committeeVc.model = _model;
    [self addChildViewController:committeeVc];
    [_bgScroll addSubview:committeeVc.view];
    
    ELACommitteeDutiesViewController *committeeDutiesVc = [[ELACommitteeDutiesViewController alloc] init];
    [committeeDutiesVc creatViewWithInitFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _bgScroll.height)];
    committeeDutiesVc.model = _model;
    [self addChildViewController:committeeDutiesVc];
    [_bgScroll addSubview:committeeDutiesVc.view];
    
    [self creatButtonView:_bgScroll];
    
}
- (void)creatProgressView:(UIView *)view
{
    UIView *infoView = [[UIView alloc]  init];
    [self.view addSubview:infoView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(@"弹劾进度");
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:titleLabel];
    
    UIView *progressView = [[UIView alloc]  init];
    [self.view addSubview:progressView];
    
    self.ringProgress = [[SYRingProgressView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [progressView addSubview:self.ringProgress];
    
    self.ringProgress.lineColor = [UIColor colorWithWhite:1 alpha:0.4];
    self.ringProgress.lineWidth = 2.5;
    self.ringProgress.progressColor = [UIColor whiteColor];
    self.ringProgress.defaultColor = [UIColor whiteColor];
    self.ringProgress.label.textColor = [UIColor whiteColor];
    self.ringProgress.label.hidden = NO;
    [self.ringProgress initializeProgress];
    if(_model.impeachmentVotes != 0)
    {
        self.ringProgress.progress =  _model.impeachmentThroughVotes / _model.impeachmentVotes;
        
    }
    else
    {
        self.ringProgress.progress = 0;
    }
    
    UILabel *currentNumLabel = [[UILabel alloc] init];
    currentNumLabel.text = ELALocalizedString(@"当前票数");
    currentNumLabel.textColor = ELARGB(149, 159, 171);
    currentNumLabel.font = PingFangRegular(10);
    currentNumLabel.textAlignment = NSTextAlignmentCenter;
    currentNumLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:currentNumLabel];
    
    UILabel *currentNumValueLabel = [[UILabel alloc] init];
    currentNumValueLabel.text = [NSString stringWithFormat:@"%f", _model.impeachmentVotes];//ELALocalizedString(@"2312 ELA");
    currentNumValueLabel.textColor = [UIColor whiteColor];
    currentNumValueLabel.font = PingFangRegular(12);
    currentNumValueLabel.textAlignment = NSTextAlignmentCenter;
    currentNumValueLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:currentNumValueLabel];
    
    UILabel *impeachmentNumLabel = [[UILabel alloc] init];
    impeachmentNumLabel.text = ELALocalizedString(@"弹劾通过票数");
    impeachmentNumLabel.textColor = ELARGB(149, 159, 171);
    impeachmentNumLabel.font = PingFangRegular(10);
    impeachmentNumLabel.textAlignment = NSTextAlignmentCenter;
    impeachmentNumLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:impeachmentNumLabel];
    
    UILabel *impeachmentNumValueLabel = [[UILabel alloc] init];
    impeachmentNumValueLabel.text = [NSString stringWithFormat:@"%f", _model.impeachmentThroughVotes];
    //ELALocalizedString(@"2312111 ELA");
    impeachmentNumValueLabel.textColor = [UIColor whiteColor];
    impeachmentNumValueLabel.font = PingFangRegular(12);
    impeachmentNumValueLabel.textAlignment = NSTextAlignmentCenter;
    impeachmentNumValueLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:impeachmentNumValueLabel];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.text = ELALocalizedString(@"/");
    lineLabel.textColor = ELARGB(149, 159, 171);
    lineLabel.font = PingFangRegular(17);
    lineLabel.textAlignment = NSTextAlignmentCenter;
    lineLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:lineLabel];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(view.mas_bottom).offset(20);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(15);
        make.top.equalTo(infoView);
    }];
    
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.width.height.equalTo(@(80));
        make.bottom.equalTo(infoView.mas_bottom).offset(-20);
    }];
    
    [currentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressView.mas_right).offset(40);
        make.bottom.equalTo(progressView.mas_centerY).offset(-5);
    }];
    
    [currentNumValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressView.mas_right).offset(40);
        make.top.equalTo(progressView.mas_centerY).offset(5);
    }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(progressView);
        make.left.equalTo(currentNumLabel.mas_right).offset(60);
        make.height.equalTo(@(80));
    }];
    
    [impeachmentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineLabel.mas_right).offset(40);
        make.centerY.equalTo(currentNumLabel);
    }];
    
    [impeachmentNumValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(impeachmentNumLabel);
        make.centerX.equalTo(impeachmentNumLabel);
         make.centerY.equalTo(currentNumValueLabel);
    }];
    [self.view layoutIfNeeded];
    [self creatTabView:infoView];
    
}

- (void)creatView
{
    if(!_model)
    {
        return;
    }
    UIView *infoView = [[UIView alloc] init];
    [self.view addSubview:infoView];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
//    headImageView.image = ImageNamed(@"point_information_img");
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_model.address] placeholderImage:nil];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 25;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [infoView addSubview:headImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(_model.didName);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:titleLabel];

    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = ELARGB(160, 45, 37);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 2;
    [infoView addSubview:bgView];
    
    UILabel *jobLabel = [[UILabel alloc] init];
    jobLabel.text = ELALocalizedString(_model.status);
    jobLabel.textColor = [UIColor whiteColor];
    jobLabel.font = PingFangRegular(10);
    jobLabel.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:jobLabel];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = [ELAUtils getNationality:_model.location];
    subLabel.textColor = [UIColor whiteColor];
    subLabel.font = PingFangRegular(12);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.alpha = 0.5;
    [infoView addSubview:subLabel];
    
    //    状态 ['Elected', 'Impeached', 'Returned']
    if([_model.status isEqualToString:@"Elected"])
    {
        bgView.backgroundColor = ELARGB(40, 164, 124);//绿色
    }
    else if([_model.status isEqualToString:@"Returned"])
    {
        bgView.backgroundColor = [UIColor grayColor];//灰色
        
    }
    else if([_model.status isEqualToString:@"Impeached"])
    {
        bgView.backgroundColor = ELARGB(160, 45, 37);//红色
        
    }
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(@(NavigitionBarHeight));
    }];
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(15);
        make.top.equalTo(infoView).offset(15);
        make.width.height.equalTo(@(50));
        make.centerY.equalTo(infoView);
        
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(15);
        make.top.equalTo(headImageView);
    }];
    
    [jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.centerY.equalTo(titleLabel);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.centerX.equalTo(jobLabel);
        make.top.equalTo(jobLabel.mas_top).offset(-1);
        make.left.equalTo(jobLabel.mas_left).offset(-2);
        make.right.equalTo(jobLabel.mas_right).offset(2);
        make.bottom.equalTo(jobLabel.mas_bottom).offset(1);
    }];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.bottom.equalTo(headImageView.mas_bottom);
    }];
    [self creatProgressView:infoView];
    
//    _contentTableView = [[UITableView alloc] init];
//    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _contentTableView.delegate = self;
//    _contentTableView.dataSource = self;
//    [_contentTableView setBackgroundColor:ELARGB(246, 247, 252)];
//    _contentTableView.rowHeight = UITableViewAutomaticDimension;
//    _contentTableView.estimatedRowHeight = 44;
//    [self.view addSubview:_contentTableView];
//
//    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.mas_equalTo(NavigitionBarHeight - 44);
//        make.bottom.mas_equalTo(-TabBarBottomHeight);
//    }];
   
    
}

@end
