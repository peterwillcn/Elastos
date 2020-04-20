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


#import "HWMTheMessageSettingViewController.h"
#import "HWMnodeConnectionSettingsDetailsTableViewCell.h"
static NSString *cellString=@"HWMnodeConnectionSettingsDetailsTableViewCell";
@interface HWMTheMessageSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *baseTabView;
@property(strong,nonatomic)NSArray *MessageList;

@end

@implementation HWMTheMessageSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"设置", nil);
    [self makeView];
}
-(NSArray *)MessageList{
    if (!_MessageList) {
        _MessageList=@[NSLocalizedString(@"红点开关", nil),NSLocalizedString(@"信息推送", nil)];
    }
    return _MessageList;;
}
-(void)makeView{
    self.baseTabView.delegate=self;
    self.baseTabView.dataSource=self;
    self.baseTabView.backgroundColor=[UIColor clearColor];
    self.baseTabView.rowHeight=65;
    self.baseTabView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.baseTabView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.MessageList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMnodeConnectionSettingsDetailsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.leftLable.text=self.MessageList[indexPath.row];
    cell.index=indexPath;
    cell.rightLabel.alpha=0;
    cell.connSwitch.alpha=1.f;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
