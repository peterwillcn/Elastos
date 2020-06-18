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


#import "WYResyncChainDataViewController.h"
#import "WYResyncChainDataTableViewCell.h"
#import "ELWalletManager.h"
#import "AddTheCurrencyListModel.h"
#import "HWMSecretaryGeneralAndMembersInfo.h"
#import "HMWToDeleteTheWalletPopView.h"

NSString *cellString = @"WYResyncChainDataTableViewCell";

@interface WYResyncChainDataViewController ()<UITableViewDelegate, UITableViewDataSource, WYResyncChainDataTableViewCellDelegate, HMWToDeleteTheWalletPopViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property (weak, nonatomic) IBOutlet UIButton *resyncButton;
@property (strong, nonatomic) NSMutableArray *walletArr;
@property (strong, nonatomic) HMWToDeleteTheWalletPopView *resyncPopView;

@end

@implementation WYResyncChainDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"选择重置范围", nil);
    [self.resyncButton setTitle:NSLocalizedString(@"确认重置", nil) forState:UIControlStateNormal];
    [self defultWhite];
    [self setBackgroundImg:@""];
    [self makeView];
    [self loadTheCurrencyList];
}

- (IBAction)buttonPressed:(id)sender {
    UIView *mainWindow = [self mainWindow];
    int count = 0;
    for (int i = 0; i < self.walletArr.count; i++) {
        if ([self.walletArr[i] isAdd]) {
            count++;
        }
    }
    if (count) {
        self.resyncPopView.deleteType = ResyncChainDataType;
    } else {
        self.resyncPopView.deleteType = ResyncChainDataPromptType;
    }
    [mainWindow addSubview:self.resyncPopView];
    [self.resyncPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainWindow);
    }];
}

-(void)loadTheCurrencyList{
    NSString *masterWalletID = [[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID];
    invokedUrlCommand * cmommand=[[invokedUrlCommand alloc]initWithArguments:@[masterWalletID] callbackId:masterWalletID className:@"Wallet" methodName:@"getAllSubWallets"];
    PluginResult *result=
    [[ELWalletManager share]getAllSubWallets:cmommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
        NSArray *arr=[[FLTools share]stringToArray:result.message[@"success"]];
        for (int i=0; i<arr.count; i++) {
            NSString *iconName = arr[i];
            AddTheCurrencyListModel *listModel=[[AddTheCurrencyListModel alloc]init];
            listModel.nameIcon=iconName;
            listModel.isAdd=NO;
            if ([listModel.nameIcon isEqualToString:@"ELA"]||[listModel.nameIcon isEqualToString:@"IDChain"]) {
                [self.walletArr addObject:listModel];
            }
        }
    }
    [self.baseTableView reloadData];
    
}

- (void)makeView {
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.rowHeight = 70.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.walletArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYResyncChainDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    cell.model = self.walletArr[indexPath.row];
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    return cell;
}

- (void)selectStatus:(bool)selected withIndex:(NSIndexPath *)indexPath {
    AddTheCurrencyListModel *model = self.walletArr[indexPath.row];
    model.isAdd = selected;
    self.walletArr[indexPath.row] = model;
}

- (NSMutableArray *)walletArr{
    if (!_walletArr) {
        _walletArr = [[NSMutableArray alloc] init];
    }
    return _walletArr;
}

- (HMWToDeleteTheWalletPopView *)resyncPopView {
    if (!_resyncPopView) {
        _resyncPopView = [[HMWToDeleteTheWalletPopView alloc] init];
        _resyncPopView.delegate = self;
        _resyncPopView.deleteType = ResyncChainDataType;
    }
    return _resyncPopView;
}

-(void)sureToDeleteViewWithPWD:(NSString*)pwd {
    NSString *masterWalletID = [[HWMSecretaryGeneralAndMembersInfo shareTools] getmasterWalletID];
    int count = 0;
    for (int i = 0; i < self.walletArr.count; i++) {
        if ([self.walletArr[i] isAdd]) {
            [[ELWalletManager share] resyncChainData:masterWalletID withSubWalletID:[self.walletArr[i] nameIcon]];
            count++;
        }
    }
    [self CancelEvent];
    if (count) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)toCancelOrCloseDelegate {
    [self CancelEvent];
}
-(void)CancelEvent {
    [self.resyncPopView removeFromSuperview];
    self.resyncPopView = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
