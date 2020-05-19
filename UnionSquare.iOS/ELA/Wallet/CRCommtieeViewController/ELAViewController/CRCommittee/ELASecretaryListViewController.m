//
//  ELASecretaryListViewController.m
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/12.
//  Copyright © 2020 64. All rights reserved.
//

#import "ELASecretaryListViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "UIView+Ext.h"
#import "ELASecretaryDetailViewController.h"

@interface ELASecretaryListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@end

@implementation ELASecretaryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)reloadTableView
{
    [_contentTableView reloadData];
}

#pragma mark - Action

- (void)loadNewData
{
    
}

- (void)loadMoreData
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_infoModel)
    {
        if(_infoModel.secretariat)
        {
            return _infoModel.secretariat.count;
        }
    }
    return 0;
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
    
    ELASecretariatModel *model = nil;
    NSString *nameStr = @"";
    NSString *headStr = @"";
    NSInteger location = 0;
    NSString *status = @"";
    NSString *dateStr = @"";
    if(_infoModel.secretariat)
    {
        model = [_infoModel.secretariat objectAtIndex:indexPath.row];
        
        nameStr = model.didName;
        headStr = model.avatar;
        status = model.status;
        location = model.location;
        dateStr = [NSString stringWithFormat:@"%@-%@", [ELAUtils getTime:model.startDate],
        [ELAUtils getTime:model.endDate]];
    }
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:infoView];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:headStr] placeholderImage:nil];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 25;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [infoView addSubview:headImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(nameStr);
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
    jobLabel.text = ELALocalizedString(status);
    jobLabel.textColor = [UIColor whiteColor];
    jobLabel.font = PingFangRegular(10);
    jobLabel.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:jobLabel];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text =  [ELAUtils getNationality:location];
    subLabel.textColor = [UIColor whiteColor];
    subLabel.font = PingFangRegular(12);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.alpha = 0.5;
    [infoView addSubview:subLabel];
    
    UIView *timeBgView = [[UIView alloc] init];
    timeBgView.backgroundColor = ELARGB(107, 142, 143);
    timeBgView.layer.masksToBounds = YES;
    timeBgView.layer.cornerRadius = 2;
    [infoView addSubview:timeBgView];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = dateStr;
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = PingFangRegular(10);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.alpha = 0.5;
    [infoView addSubview:timeLabel];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = ImageNamed(@"asset_list_arrow");
    [infoView addSubview:imageView];

    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
        make.top.equalTo(cell.contentView);
        make.height.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
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
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subLabel.mas_right).offset(10);
        make.centerY.equalTo(subLabel);
    }];
    
    [timeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.centerX.equalTo(timeLabel);
        make.top.equalTo(timeLabel.mas_top).offset(-0.5);
        make.left.equalTo(timeLabel.mas_left).offset(-2);
        make.right.equalTo(timeLabel.mas_right).offset(2);
        make.bottom.equalTo(timeLabel.mas_bottom).offset(0.5);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoView).offset(-15);
        make.centerY.equalTo(infoView);
    }];
    
    UIView *_line = [[UIView alloc] init];
    _line.backgroundColor = ELARGB(149, 159, 171);//[UIColor whiteColor];
    [infoView addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView);
        make.top.equalTo(infoView.mas_bottom).offset(-0.5);
        make.right.equalTo(imageView.mas_right);
        make.height.equalTo(@(0.5));
    }];
    
    return cell;
}


#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     ELASecretaryDetailViewController *vc = [[ELASecretaryDetailViewController alloc] init];
     vc.title = ELALocalizedString(@"秘书长详情");
     [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - View

- (void)creatViewWithInitFrame:(CGRect)frame;
{
    self.view.frame = frame;
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    [_contentTableView setBackgroundColor:[UIColor clearColor]];
    _contentTableView.rowHeight = UITableViewAutomaticDimension;
    _contentTableView.estimatedRowHeight = 44;
    [self.view addSubview:_contentTableView];
    
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.bottom.equalTo(self.view);
    }];
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    _contentTableView.mj_header = header;
//  
//    
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    _contentTableView.mj_footer = footer;
    
//   _contentTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//   }];
//   _contentTableView.mj_footer= [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//
//   }];
    
}
@end
