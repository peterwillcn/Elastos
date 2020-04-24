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


#import "HWMNodeConnectionSettingsViewController.h"
#import "HWMNodeConnectionSettingsTableViewCell.h"
#import "ELWalletManager.h"
#import "AddTheCurrencyListModel.h"
#import "assetsListModel.h"
#import "HWMnodeConnectionSettingsDetailsViewController.h"


static NSString *cellString=@"HWMNodeConnectionSettingsTableViewCell";
@interface HWMNodeConnectionSettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property(strong,nonatomic)NSMutableArray *addTheCurrencyList;

@end

@implementation HWMNodeConnectionSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"节点连接设置", nil);
    [self makeView];
}
//-(void)loadTheCurrencyList{
//    invokedUrlCommand * cmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"getSupportedChains"];
//    PluginResult *result=
//    [[ELWalletManager share]getSupportedChains:cmommand];
//    NSArray *arr=[NSArray arrayWithArray:result.message[@"success"]];
//    for (int i=0; i<arr.count; i++) {
//        NSString *iconName = arr[i];
//        AddTheCurrencyListModel *listModel=[[AddTheCurrencyListModel alloc]init];
//        listModel.nameIcon=iconName;
//        listModel.isAdd=NO;
//        if ([listModel.nameIcon isEqualToString:@"ELA"]||[listModel.nameIcon isEqualToString:@"IDChain"]) {
//            [self.addTheCurrencyList addObject:listModel];
//        }
//
//    }
//    [self.baseTableView reloadData];
//
//}
-(NSMutableArray *)addTheCurrencyList{
    if (!_addTheCurrencyList) {
        _addTheCurrencyList=[[NSMutableArray alloc]init];
    }
    return _addTheCurrencyList;;
}
-(void)makeView{
    
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
    self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.rowHeight=50;
    self.baseTableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.currencyArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMNodeConnectionSettingsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    assetsListModel *listModel=self.currencyArray[indexPath.row];
    cell.nickNameLabel.text=listModel.iconName;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMnodeConnectionSettingsDetailsViewController *nodeConnectionSettingsDetailsVC=[[HWMnodeConnectionSettingsDetailsViewController alloc]init];
    nodeConnectionSettingsDetailsVC.wallet=self.wallet;
    nodeConnectionSettingsDetailsVC.model=self.currencyArray[indexPath.row];
    [self.navigationController pushViewController:nodeConnectionSettingsDetailsVC animated:YES];
}
@end
