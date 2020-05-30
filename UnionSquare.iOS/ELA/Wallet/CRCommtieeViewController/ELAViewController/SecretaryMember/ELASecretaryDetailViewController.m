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
#import "ELASecretaryDetailViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "SYRingProgressView.h"
#import "RPTaggedNavView.h"
#import "UIView+Ext.h"
#import "ELAUpdateSecretaryDidViewController.h"
#import "ELANetwork.h"
#import "ELAInformationDetail.h"

@interface ELASecretaryDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ELAInformationDetail *model;

@end

@implementation ELASecretaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray= [[NSMutableArray alloc] init];
    
    [self getNetworkData];
}
- (void)formatData:(ELAInformationDetail *)data
{
    if(_model)
    {
        if(_model.did)
        {
            [self addData:ELALocalizedString(@"秘书长 DID")  other:_model.did];
        }
        else
        {
            [self addData:ELALocalizedString(@"秘书长 DID")  other:_model.did];
        }
        if(_model.startDate > 0)
        {
            NSString *date = [NSString stringWithFormat:@"%@-%@", [ELAUtils getTimeWithNumber:_model.startDate], [ELAUtils getTimeWithNumber:_model.endDate]];
            [self addData:ELALocalizedString(@"在职时间")  other:date];
        }
        else
        {
            [self addData:ELALocalizedString(@"在职时间")  other:@""];
        }
        if(_model.birthday > 0)
        {
            [self addData:ELALocalizedString(@"出生日期")  other:[ELAUtils getTimeWithNumber:_model.birthday]];
        }
        if(ELAIsNoEmpty(_model.email))
        {
            [self addData:ELALocalizedString(@"邮箱")  other:_model.email];
        }
        if(ELAIsNoEmpty(_model.address))
        {
            [self addData:ELALocalizedString(@"个人主页")  other:_model.address];
        }
        if(ELAIsNoEmpty(_model.wechat))
        {
            [self addData:ELALocalizedString(@"微信账号")  other:_model.wechat];
        }
        if(ELAIsNoEmpty(_model.weibo))
        {
            [self addData:ELALocalizedString(@"微博账号")  other:_model.weibo];
        }
        if(ELAIsNoEmpty(_model.facebook))
        {
            [self addData:ELALocalizedString(@"Facebook 账号")  other:_model.facebook];
        }
        if(ELAIsNoEmpty(_model.microsoft))
        {
            [self addData:ELALocalizedString(@"微软账号")  other:_model.microsoft];
        }
        if(ELAIsNoEmpty(_model.introduction))
        {
            [self addData:ELALocalizedString(@"个人简介")  other:_model.introduction];
        }
        
    }
}
- (void)addData:(id)value other:(NSString *)otherValue
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:value forKey:@"title"];
    [dic setValue:otherValue forKey:@"value"];

    [_dataArray addObject:dic];
}

#pragma mark -- Network

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
                [weakSelf formatData:data];
                [weakSelf creatView];
            }
        });
        
    }];
}
#pragma mark - Action

- (void)updateDidInfoButtonAction:(id)sender
{
    ELAUpdateSecretaryDidViewController *vc = [[ELAUpdateSecretaryDidViewController alloc] init];
//    vc.title = ELALocalizedString(@"")
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
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
    
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    
    NSString *value = dic[@"value"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = value;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    [infoView addSubview:titleLabel];
    if(indexPath.section == 0)
    {
        titleLabel.text = _model.did;
    }
    else if(indexPath.section == 1)
    {
        titleLabel.text = [NSString stringWithFormat:@"%@-%@", [ELAUtils getTimeWithNumber:_model.startDate], [ELAUtils getTimeWithNumber:_model.endDate]];
    }
    
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
    NSDictionary *dic = [_dataArray objectAtIndex:section];
    NSString *title = dic[@"title"];
    
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
    
//    {did:igCSy8ht7yDwV5qqcRzf5SGioMX8H9RXcj,status:CURRENT,didName:SecretaryGeneral-did,startDate:1589608108,type:SecretaryGeneral
    UIImageView *headImageView = [[UIImageView alloc] init];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:nil];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 25;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [infoView addSubview:headImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = _model.didName;
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
    
    if([_model.status isEqualToString:@"CURRENT"])
    {
        bgView.backgroundColor = ELARGB(40, 164, 124);//绿色
    }
    else if([_model.status isEqualToString:@"NONCURRENT"])
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
