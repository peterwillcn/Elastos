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


#import "HWMnodeConnectionSettingsDetailsViewController.h"
#import "HWMnodeConnectionSettingsDetailsTableViewCell.h"
#import "assetsListModel.h"
#import "ELWalletManager.h"
#import "invokedUrlCommand.h"
#import "HWMManuallyEnterView.h"
#import "HMWFMDBManager.h"
static NSString *cellString=@"HWMnodeConnectionSettingsDetailsTableViewCell";
@interface HWMnodeConnectionSettingsDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,HWMManuallyEnterViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
@property(strong,nonatomic)NSArray *detailsArray;
@property (weak, nonatomic) IBOutlet UIButton *connChainButton;
@property(strong,nonatomic)HWMManuallyEnterView*EnterIPView;

@property(assign,nonatomic)BOOL ManuallyEnter;
@end

@implementation HWMnodeConnectionSettingsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=[NSString stringWithFormat:@"%@%@",self.model.iconName,NSLocalizedString(@"节点连接设置", nil)];
    [self makeView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(iconInfoUpdate:) name:progressBarcallBackInfo object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AsnyConnectStatusChanged:) name:ConnectStatusChanged object:nil];
    self.ManuallyEnter=YES;
    [[HMWCommView share]makeBordersWithView:self.connChainButton];
    [self.connChainButton setTitle:NSLocalizedString(@"随机切换", nil) forState:UIControlStateNormal];
}
-(void)iconInfoUpdate:(NSNotification *)notification{
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSString *IP=dic[@"DownloadPeer"];
    NSString *BytesPerSecond=dic[@"BytesPerSecond"];
    assetsListModel *model;
    
    if ([self.wallet.masterWalletID isEqualToString:walletID]){
        if ([chainID isEqualToString:model.iconName]) {
            model.IP=IP;
            model.ConnectionSpeed=BytesPerSecond;
            
        }
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.baseTableView reloadData];
    });
    
}
-(NSArray *)detailsArray{
    if (!_detailsArray) {
        _detailsArray =@[NSLocalizedString(@"状态", nil),NSLocalizedString(@"IP地址", nil),NSLocalizedString(@"速度", nil),NSLocalizedString(@"自动连接", nil)];
        
    }
    return _detailsArray;
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
    return  self.detailsArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMnodeConnectionSettingsDetailsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.leftLable.text=self.detailsArray[indexPath.row];
    cell.rightLabel.alpha=1.f;
    cell.connSwitch.alpha=0.f;
    cell.connSwitch.on=self.ManuallyEnter;
    [cell.swButton addTarget:self action:@selector(connSwitch) forControlEvents:UIControlEventTouchUpInside];
    if (![self.model.status isEqualToString:@"Connected"]) {
        cell.rightLabel.text=@"--";
        if (indexPath.row==3) {
            cell.rightLabel.alpha=0.f;
            cell.connSwitch.alpha=1.f;
        }
        return cell;
    }
    switch (indexPath.row) {
        case 0:
            if ([self.model.status isEqualToString:@"Connected"]) {
                cell.rightLabel.text=cell.rightLabel.text=NSLocalizedString(@"已连接", nil);
            }
            break;
        case 1:
            cell.rightLabel.text=self.model.IP;
            break;
        case 2:
            cell.rightLabel.text=[[FLTools share]bytesToAvaiUnit: self.model.ConnectionSpeed];
            break;
        case 3:
            cell.rightLabel.alpha=0.f;
            cell.connSwitch.alpha=1.f;
            break;
        default:
            break;
    }
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:progressBarcallBackInfo object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:ConnectStatusChanged object:nil];
}
-(void)setModel:(assetsListModel *)model{
    _model=model;
}
-(void)setWallet:(FLWallet *)wallet{
    _wallet=wallet;
}
-(void)AsnyConnectStatusChanged:(NSNotification *)notification{
    NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:notification.object];
    NSArray *infoArray=[[FLTools share]stringToArray:dic[@"callBackInfo"]];
    
    NSString *walletID=infoArray.firstObject;
    NSString *chainID=infoArray[1];
    NSInteger index = [infoArray[2] integerValue];
    NSString * statusString=dic[@"status"];
    if ([self.wallet.masterWalletID isEqualToString:walletID]&&[self.model.iconName isEqualToString:chainID]) {
        self.model.status=statusString;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.baseTableView reloadData];
    });
    
}
- (IBAction)connChainEvent:(id)sender {
    if (self.ManuallyEnter) {
        [[FLTools share]showErrorInfo:@"连接中…"];
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,self.model.iconName] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
        [[ELWalletManager share]RandomSwitchLink:mommand];
        
        self.model.status=@"connting";
        self.ManuallyEnter=YES;
        [self.baseTableView reloadData];
    }else{
        UIView *mainView= [self mainWindow];
        [mainView addSubview:self.EnterIPView];
        [self.EnterIPView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }
}
-(HWMManuallyEnterView *)EnterIPView{
    if (!_EnterIPView) {
        _EnterIPView =[[HWMManuallyEnterView alloc]init];
        _EnterIPView.delegate=self;
    }
    return _EnterIPView;
}

-(void)selectIPWithString:(NSString*_Nullable)ip withPort:(NSString*_Nullable)port{
    if ([self.model.iconName isEqualToString:@"ELA"]&&port.length==0) {
        port=ELAPort;
        
    }else if ([self.model.iconName isEqualToString:@"IDChain"]&&port.length==0){
        port=IDChainPort;
    }
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.wallet.masterWalletID,self.model.iconName,ip,port] callbackId:self.wallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
    BOOL isSucc=  [[ELWalletManager share]ManualInputIP:mommand];
    if (isSucc) {
        [[FLTools share]showErrorInfo:@"连接中…"];
        self.ManuallyEnter=NO;
        [[HMWFMDBManager sharedManagerType:IPInfoType]addIPString:ip withPort:port];
        [self closEnterView];
    }else{
        [[FLTools share]showErrorInfo:@"当前地址无法连接"];
    }
    [self updaeButtonTitle];
    [self.baseTableView reloadData];
}

-(void)closEnterView{
    [self.EnterIPView removeFromSuperview];
    self.EnterIPView=nil;
}
-(void)updaeButtonTitle{
    NSString *buTiString;
    if (self.ManuallyEnter) {
        buTiString=@"随机切换";
    }else{
        buTiString=@"手动输入";
    }
    [self.connChainButton setTitle:NSLocalizedString(buTiString, nil) forState:UIControlStateNormal];
    
}
-(void)connSwitch{
    
    if (self.ManuallyEnter) {
        UIView *mainView= [self mainWindow];
        [mainView addSubview:self.EnterIPView];
        [self.EnterIPView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
        
    }else{
        self.ManuallyEnter=YES;
        [self connChainEvent:nil];
        [self updaeButtonTitle];
    }
    
}

@end
