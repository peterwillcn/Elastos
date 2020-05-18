//
//  ELASecretaryDetailViewController.m
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/13.
//  Copyright © 2020 64. All rights reserved.
//

#import "ELASecretaryDetailViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "SYRingProgressView.h"
#import "RPTaggedNavView.h"
#import "UIView+Ext.h"
#import "ELAUpdateSecretaryDidViewController.h"

@interface ELASecretaryDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation ELASecretaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"秘书长 DID", @"在职时间", @"出生日期", @"邮箱", @"个人简介", nil];
    _titlesArray = [NSArray arrayWithArray:array];
    [self creatView];
}

- (void)updateDidInfoButtonAction:(id)sender
{
    ELAUpdateSecretaryDidViewController *vc = [[ELAUpdateSecretaryDidViewController alloc] init];
//    vc.title = ELALocalizedString(@"")
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"TableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    NSArray *subViews = [cell.contentView subviews];
    for(UIView *view in subViews)
    {
        [view removeFromSuperview];
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:infoView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(@"个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介");
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    [infoView addSubview:titleLabel];
    
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
        make.top.equalTo(cell.contentView);
        make.height.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView).offset(0);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(15);
        make.right.equalTo(infoView).offset(-15);
        make.centerY.equalTo(infoView);
    }];
    
    
    
    

    return cell;
}


#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [_titlesArray objectAtIndex:section];
    
    
    UIView *_infoView = [[UIView alloc] init];
    [_infoView setFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    _infoView.backgroundColor = [UIColor clearColor];
    _infoView.tag = section;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    [_infoView addSubview:contentView];
    
    
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.text = title;
    _titleLabel.font =  PingFangRegular(14);
    _titleLabel.textColor =  [UIColor whiteColor];
    [contentView addSubview:_titleLabel];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_infoView).offset(15);
        make.right.equalTo(_infoView).offset(-15);
        make.centerY.equalTo(_infoView);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView);
        make.centerY.equalTo(contentView);
        make.right.equalTo(contentView);
    }];
    
        
    return _infoView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

#pragma makr - view

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
    [button setTitle:ELALocalizedString(@"更新DID信息") forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(updateDidInfoButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
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

- (void)creatView
{
    UIView *infoView = [[UIView alloc] init];
    [self.view addSubview:infoView];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = ImageNamed(@"point_information_img");
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 25;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [infoView addSubview:headImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(@"Feng zhang");
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:titleLabel];

    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = ELARGB(40, 164, 124);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 2;
    [infoView addSubview:bgView];
    
    UILabel *jobLabel = [[UILabel alloc] init];
    jobLabel.text = @"现任";
    jobLabel.textColor = [UIColor whiteColor];
    jobLabel.font = PingFangRegular(10);
    jobLabel.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:jobLabel];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = @"中国";
    subLabel.textColor = [UIColor whiteColor];
    subLabel.font = PingFangRegular(12);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.alpha = 0.5;
    [infoView addSubview:subLabel];
    
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
    
   _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    [_contentTableView setBackgroundColor:[UIColor clearColor]];
    _contentTableView.rowHeight = UITableViewAutomaticDimension;
    _contentTableView.estimatedRowHeight = 44;
    [self.view addSubview:_contentTableView];
    
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoView.mas_bottom);
        make.bottom.mas_equalTo( -BottomHeight - 90);
        
    }];
    [self.view layoutIfNeeded];
    [self creatButtonView:_contentTableView];
}

@end
