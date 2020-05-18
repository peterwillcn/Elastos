//
//  ELAUpdateSecretaryDidViewController.m
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/13.
//  Copyright © 2020 64. All rights reserved.
//

#import "ELAUpdateSecretaryDidViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"
#import "ELATUpdateSecretaryDidModel.h"
#import "ELATUpdateSecretaryDidTableViewCell.h"


@interface ELAUpdateSecretaryDidViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *datasArray;
@end

@implementation ELAUpdateSecretaryDidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    ELATUpdateSecretaryDidModel *model = [[ELATUpdateSecretaryDidModel alloc] init];
    model.title = ELALocalizedString(@"- DID基本信息");
    model.isChecked = YES;
    
    [array addObject:model];
    
    ELATUpdateSecretaryDidModel *model1 = [[ELATUpdateSecretaryDidModel alloc] init];
    model1.title = ELALocalizedString(@"- 出生日期");
    model1.isChecked = NO;
    
    [array addObject:model1];
    
    ELATUpdateSecretaryDidModel *model2 = [[ELATUpdateSecretaryDidModel alloc] init];
    model2.title = ELALocalizedString(@"- 头像");
    model2.isChecked = NO;
    
    [array addObject:model2];
    
    ELATUpdateSecretaryDidModel *model3 = [[ELATUpdateSecretaryDidModel alloc] init];
    model3.title = ELALocalizedString(@"- 邮箱");
    model3.isChecked = NO;
    
    [array addObject:model3];
    
    ELATUpdateSecretaryDidModel *model4 = [[ELATUpdateSecretaryDidModel alloc] init];
    model4.title = ELALocalizedString(@"- 个人简介");
    model4.isChecked = NO;
    
    [array addObject:model4];
    
    ELATUpdateSecretaryDidModel *model5 = [[ELATUpdateSecretaryDidModel alloc] init];
    model5.title = ELALocalizedString(@"- 个人主页");
    model5.isChecked = NO;
    
    [array addObject:model5];
    
    ELATUpdateSecretaryDidModel *model6 = [[ELATUpdateSecretaryDidModel alloc] init];
    model6.title = ELALocalizedString(@"- 微信账号");
    model6.isChecked = NO;
    
    [array addObject:model6];
    _datasArray = [NSArray arrayWithArray:array];
    
    [self creatView];
}

#pragma mark -


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return _datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ELATUpdateSecretaryDidTableViewCell *cell = [ELATUpdateSecretaryDidTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.index = indexPath.row;
    ELATUpdateSecretaryDidModel *model = [_datasArray objectAtIndex:indexPath.row];
    cell.model = model;
  
//    static NSString *identifier = @"TableViewCell";
//    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//
//    }
//    NSArray *subViews = [cell.contentView subviews];
//    for(UIView *view in subViews)
//    {
//        [view removeFromSuperview];
//    }
//    cell.contentView.backgroundColor = [UIColor clearColor];
//    cell.backgroundColor = [UIColor clearColor];
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    UIView *infoView = [[UIView alloc] init];
//    infoView.backgroundColor = [UIColor clearColor];
//    [cell.contentView addSubview:infoView];
//
//    NSString *title = [_titlesArray objectAtIndex:indexPath.row];
//
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.text = ELALocalizedString(title);
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.font = PingFangRegular(14);
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.numberOfLines = 0;
//    [infoView addSubview:titleLabel];
//
//    CheckBox *checkBox = [[CheckBox alloc] init];
//    checkBox.tag = indexPath.row;
//    [checkBox addTarget:self action:@selector(checkBoxAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [infoView addSubview:checkBox];
//    if(indexPath.row == 0)
//    {
//        [checkBox setImage:ImageNamed(@"authorization_locked") forState:(UIControlStateNormal)];
//        [checkBox setImage:ImageNamed(@"authorization_locked") forState:(UIControlStateSelected)];
//    }
//
//
//    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(cell.contentView);
//        make.right.equalTo(cell.contentView);
//        make.top.equalTo(cell.contentView);
//        make.height.equalTo(cell.contentView);
//        make.bottom.equalTo(cell.contentView).offset(0);
//    }];
//
//
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(infoView).offset(15);
//        make.right.equalTo(checkBox.mas_left).offset(0);
//        make.centerY.equalTo(infoView);
//    }];
//
//    [checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(infoView).offset(0);
//        make.centerY.equalTo(infoView);
//        make.width.height.equalTo(@(68));
//    }];
    
    
    
    

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

#pragma mark - View

- (void)creatView
{
  
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];


    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = ImageNamed(@"point_information_img");
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 5;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 1;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [infoView addSubview:headImageView];
//
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(@"CR委员名称");
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(16);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel sizeToFit];
    [infoView addSubview:titleLabel];


    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = @"did:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    subLabel.textColor = ELARGB(149, 159, 171);
    subLabel.font = PingFangRegular(12);
    subLabel.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:subLabel];
    
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.text = ELALocalizedString(@"申请使用您的DID信息（包括但不限于存储、展示等用途）：");
    desLabel.textColor = ELARGB(149, 159, 171);
    desLabel.font = PingFangRegular(14);
    desLabel.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:desLabel];
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:ImageNamed(@"cr_did_copy") forState:(UIControlStateNormal)];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
   // [button addTarget:self action:@selector(manageButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [infoView addSubview:button];

    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(@(NavigitionBarHeight));
        make.height.equalTo(@(285));
    }];


    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(infoView);
        make.top.equalTo(infoView).offset(59);
        make.width.height.equalTo(@(109));

    }];
//
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headImageView);
        make.top.equalTo(headImageView.mas_bottom).offset(10);
    }];

    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(infoView);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subLabel.mas_right);
        make.centerY.equalTo(subLabel);
        make.width.height.equalTo(@(22));
    }];
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView);
        make.top.equalTo(subLabel.mas_bottom).offset(45);
    }];
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    [_contentTableView setBackgroundColor:[UIColor clearColor]];
    _contentTableView.rowHeight = UITableViewAutomaticDimension;
    _contentTableView.estimatedRowHeight = 44;
//    _contentTableView.scrollEnabled = NO;
    [self.view addSubview:_contentTableView];
    
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoView.mas_bottom).offset(8);
        make.bottom.mas_equalTo( -BottomHeight - 150);
        
    }];
    
    [self creatButtonView:_contentTableView];
}

- (void)creatButtonView:(UIView *)view
{
    UIView *infoView = [[UIView alloc]  init];
    infoView.backgroundColor = [UIColor clearColor];//ELARGB(12, 27, 33);
    [self.view addSubview:infoView];
    
    UIButton *button = [[UIButton alloc] init];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1;
    button.backgroundColor = ELARGB(40, 64, 72);
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = PingFangRegular(14);
    [button setTitle:ELALocalizedString(@"同意") forState:(UIControlStateNormal)];
   // [button addTarget:self action:@selector(updateDidInfoButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [infoView addSubview:button];
    
    UIButton *cancelbutton = [[UIButton alloc] init];
     cancelbutton.layer.borderColor = [UIColor whiteColor].CGColor;
     cancelbutton.layer.borderWidth = 1;
     cancelbutton.backgroundColor = ELARGB(40, 64, 72);
     cancelbutton.titleLabel.textColor = [UIColor whiteColor];
     cancelbutton.titleLabel.font = PingFangRegular(14);
     [cancelbutton setTitle:ELALocalizedString(@"拒绝") forState:(UIControlStateNormal)];
    // [button addTarget:self action:@selector(updateDidInfoButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [infoView addSubview:cancelbutton];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(view.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(190));
        make.top.equalTo(infoView).offset(0);
        make.height.equalTo(@(40));
    }];
    
    [cancelbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(190));
        make.top.equalTo(button.mas_bottom).offset(20);
        make.height.equalTo(@(40));
    }];
    
//    UIView *_line = [[UIView alloc] init];
//    _line.backgroundColor = ELARGB(149, 159, 171);
//    [infoView addSubview:_line];
//
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(infoView);
//        make.top.equalTo(infoView.mas_top).offset(0);
//        make.right.equalTo(infoView);
//        make.height.equalTo(@(0.5));
//    }];
}

@end
