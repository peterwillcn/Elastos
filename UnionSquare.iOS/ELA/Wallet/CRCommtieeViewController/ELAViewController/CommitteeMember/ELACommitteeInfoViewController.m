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
#import "ELACommitteeInfoViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "UIView+Ext.h"

@interface ELACommitteeInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation ELACommitteeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setModel:(ELAInformationDetail *)model
{
    _model = model;
    if(_model)
    {
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:ELALocalizedString(@"委员 DID"), ELALocalizedString(@"委员网站"), ELALocalizedString(@"委员简介"), nil];
        _titlesArray = [NSArray arrayWithArray:array];
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
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString([_titlesArray objectAtIndex:indexPath.row]);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:titleLabel];

    NSString *subTitile = @"";
    if(indexPath.row == 0)
    {
        subTitile = _model.did;
    }
    else if(indexPath.row == 1)
    {
        subTitile = _model.address;
    }
    else if(indexPath.row == 2)
    {
        subTitile = _model.introduction;
    }
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = subTitile;
    subLabel.textColor = [UIColor whiteColor];
    subLabel.font = PingFangRegular(12);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.numberOfLines = 0;
    [infoView addSubview:subLabel];

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
    _contentTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_contentTableView];
    
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.bottom.equalTo(self.view);
    }];
  
}
@end
