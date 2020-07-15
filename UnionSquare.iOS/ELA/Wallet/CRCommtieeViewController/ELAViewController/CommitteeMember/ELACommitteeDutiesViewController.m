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
#import "ELACommitteeDutiesViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "UIView+Ext.h"

@interface ELACommitteeDutiesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation ELACommitteeDutiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"马尔代夫联谊活动", @"马尔代夫联谊活动", @"马尔代夫联谊活动", nil];
    
//    if(_model.term)
//    {
//        _titlesArray = [NSArray arrayWithArray:_model.term];
//    }
//    else
//    {
//        _titlesArray = [[NSArray alloc] init];
//    }
}

- (void)setModel:(ELAInformationDetail *)model
{
    _model = model;
    if(_model.term)
    {
        _titlesArray = [NSArray arrayWithArray:_model.term];
    }
    else
    {
        _titlesArray = [[NSArray alloc] init];
    }
    
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
   
    return _titlesArray.count;
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
    
    ELATermModel *termModel = [_titlesArray objectAtIndex:indexPath.row];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = [NSString stringWithFormat:@"#%@", termModel.title];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:titleLabel];
    NSString *date = [ELAUtils  getTimeWithNumber:termModel.createdAt];
    NSString *subTitle = [NSString stringWithFormat:@"%ld %@ %@", (long)termModel.ID,  date, termModel.status];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = subTitle;
    subLabel.textColor = ELARGB(149, 159, 171);
    subLabel.font = PingFangRegular(12);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.numberOfLines = 0;
    [infoView addSubview:subLabel];
   
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = ELARGB(40, 164, 124);
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 2;
    [infoView addSubview:bgView];
    
    NSString *result = termModel.voteResult;
    
    UILabel *agreeLabel = [[UILabel alloc] init];
    agreeLabel.text = ELALocalizedString(@"support");
    agreeLabel.textColor = [UIColor whiteColor];
    agreeLabel.font = PingFangRegular(10);
    agreeLabel.textAlignment = NSTextAlignmentCenter;
    [infoView addSubview:agreeLabel];
    
    if([result isEqualToString:@"reject"])
    {
        bgView.backgroundColor = ELARGB(160, 45, 37);
        agreeLabel.text = ELALocalizedString(@"reject");
    }
    else if([result isEqualToString:@"abstention"])
    {
        bgView.backgroundColor = [UIColor grayColor];
        agreeLabel.text = ELALocalizedString(@"abstention");
    }
    else if([result isEqualToString:@"undecided"])
    {
        bgView.backgroundColor = [UIColor grayColor];
        agreeLabel.text = ELALocalizedString(@"undecided");
    }
//    if(indexPath.row == 1)
//    {
//        bgView.backgroundColor = ELARGB(160, 45, 37);
//        agreeLabel.text = @"反对";
//    }
//    else if(indexPath.row == 2)
//    {
//        bgView.backgroundColor = [UIColor grayColor];
//        agreeLabel.text = @"弃权";
//    }
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
        make.top.equalTo(cell.contentView);
        make.height.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(15);
        make.top.equalTo(infoView).offset(10);
        make.right.equalTo(infoView).offset(-15);
        
    }];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(infoView.mas_bottom).offset(-10);
        make.right.equalTo(titleLabel);
    }];
    
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(infoView.mas_right).offset(-15);
        make.centerY.equalTo(subLabel);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.centerX.equalTo(agreeLabel);
        make.top.equalTo(agreeLabel.mas_top).offset(-1);
        make.left.equalTo(agreeLabel.mas_left).offset(-2);
        make.right.equalTo(agreeLabel.mas_right).offset(2);
        make.bottom.equalTo(agreeLabel.mas_bottom).offset(1);
    }];
    
    UIView *_line = [[UIView alloc] init];
    _line.backgroundColor = ELARGB(149, 159, 171);
    [infoView addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(infoView.mas_bottom).offset(-0.5);
        make.right.equalTo(titleLabel.mas_right);
        make.height.equalTo(@(0.5));
    }];
    
    return cell;
}


#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
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
  
}

@end
