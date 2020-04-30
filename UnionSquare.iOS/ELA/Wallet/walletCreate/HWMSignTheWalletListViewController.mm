//
//  HWMSignTheWalletListViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import "HWMSignTheWalletListViewController.h"
#import "HMWtheWalletListTableViewCell.h"
#import "HMWFMDBManager.h"
#import "HMWSecurityVerificationPopView.h"
#import "ELWalletManager.h"
#import "HWMSignThePurseViewController.h"
static NSString *cellString=@"HMWtheWalletListTableViewCell";
@interface HWMSignTheWalletListViewController ()<UITableViewDelegate,UITableViewDataSource,HMWSecurityVerificationPopViewDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *walletIDListArray;
/*
 *<# #>
 */
@property(strong,nonatomic)UITableView *baseTableView;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSecurityVerificationPopView *securityVerificationPopV;
/*
 *<# #>
 */
@property(assign,nonatomic)NSIndexPath *selectIndex;

@end

@implementation HWMSignTheWalletListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"钱包列表", nil);
    
    [self.baseTableView reloadData];
}
-(NSArray *)walletIDListArray{
    if (!_walletIDListArray) {
        _walletIDListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
    }
    return _walletIDListArray;
    
}

-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, AppHeight) style:UITableViewStyleGrouped];
        
        _baseTableView.delegate=self;
        _baseTableView.dataSource=self;
        
        [_baseTableView  registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
        _baseTableView.backgroundColor=[UIColor clearColor];
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_baseTableView];
        
        [_baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.left.equalTo(self.view.mas_left).offset(30);
            make.right.equalTo(self.view.mas_right).offset(-30);
            
        }];
    }
    return _baseTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.walletIDListArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMWtheWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
//    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    cell.selectView.alpha=0.f;
    cell.typeString=@"1"; cell.model=self.walletIDListArray[indexPath.section];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.selectIndex) {
//        HMWtheWalletListTableViewCell *cell=[tableView cellForRowAtIndexPath:self.selectIndex];
//        cell.selectView.alpha=0.f;
//    }
    self.selectIndex=indexPath;
//    HMWtheWalletListTableViewCell *cell=[tableView cellForRowAtIndexPath:self.selectIndex];
//    cell.selectView.alpha=1.f;
    UIView *mainView=[self mainWindow];
    [mainView addSubview:self.securityVerificationPopV];
    [self.securityVerificationPopV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(mainView);
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
    
}
-(HMWSecurityVerificationPopView *)securityVerificationPopV{
    if (!_securityVerificationPopV) {
        _securityVerificationPopV =[[HMWSecurityVerificationPopView alloc]init];
        _securityVerificationPopV.backgroundColor=[UIColor clearColor];
        _securityVerificationPopV.delegate=self;
    }
    
    return _securityVerificationPopV;
}
-(void)takeOutOrShutDown{
    [self.securityVerificationPopV removeFromSuperview];
    self.securityVerificationPopV=nil;
}
-(void)makeSureWithPWD:(NSString*)pwdString{
    
    [self takeOutOrShutDown];
    FMDBWalletModel *model=self.walletIDListArray[self.selectIndex.section];
    NSString *xpk;
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID,pwdString] callbackId:model.walletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
    xpk =[[ELWalletManager share]ExportxPrivateKey:mommand];
    
    if (model.walletID.length>0&&xpk.length>0) {
    if (self.delegate) {
        [self.delegate CallbackWithWalletID:model.walletID withXPK:xpk withPWD:pwdString];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[HWMSignThePurseViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
        
    }
    
}
@end
