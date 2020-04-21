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


#import "HWMTheMessageCenterViewController.h"
#import "HWMTheMessageCenterTableViewCell.h"
#import "HWMMessageCenterModel.h"
#import "HMWFMDBManager.h"
#import "HWMAllNoView.h"
static NSString *cellString=@"HWMTheMessageCenterTableViewCell";
@interface HWMTheMessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTabView;
@property(strong,nonatomic)NSMutableArray *MessageList;
@property(strong,nonatomic)HWMAllNoView *NoView;
@end

@implementation HWMTheMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"消息中心", nil);
    UIBarButtonItem *ClickMorenButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"asset_wallet_setting"] style:UIBarButtonItemStyleDone target:self action:@selector(messageCenterSetting)];
       self.navigationItem.rightBarButtonItem=ClickMorenButton;
    [self makeView];
//    [[FLTools share] sethasMessageNeedRead:@"0"]
    if (self.MessageList.count==0) {
        [self.baseTabView addSubview:self.NoView];
    }
}
-(NSMutableArray *)MessageList{
    if (!_MessageList) {
        _MessageList=[[NSMutableArray alloc]initWithArray:[[HMWFMDBManager sharedManagerType:MessageCenterType]allMessageListWithIndex:10]];
    }
    return _MessageList;
}
-(void)messageCenterSetting{
   
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
    HWMTheMessageCenterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.model=self.MessageList[indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    HWMnodeConnectionSettingsDetailsViewController *nodeConnectionSettingsDetailsVC=[[HWMnodeConnectionSettingsDetailsViewController alloc]init];
    //    nodeConnectionSettingsDetailsVC.wallet=self.wallet;
    //    nodeConnectionSettingsDetailsVC.model=self.currencyArray[indexPath.row];
    //    [self.navigationController pushViewController:nodeConnectionSettingsDetailsVC animated:YES];
}
-(HWMAllNoView *)NoView{
    if (!_NoView) {
        _NoView=[[HWMAllNoView alloc]init];
        _NoView.type=meeeagerType;
    }
    return _NoView;
}
@end
