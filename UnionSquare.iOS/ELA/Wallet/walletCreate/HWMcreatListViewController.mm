//
//  HWMcreatListViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/2.
//

#import "HWMcreatListViewController.h"
#import "HWMHWMcreatWalletListlTableViewCell.h"
#import "FLCreatAcountVC.h"
#import "HWMSignThePurseViewController.h"
#import "HWMSingleSignReadOnlyWalletViewController.h"
#import "WCQRCodeScanningVC.h"

static NSString *cellString=@"HWMHWMcreatWalletListlTableViewCell";
@interface HWMcreatListViewController ()<UITableViewDelegate,UITableViewDataSource,FLCreatAcountVCDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)UITableView *baseTableView;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *dataSourceArray;

@end

@implementation HWMcreatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"创建钱包", nil);
    self.dataSourceArray =[NSArray arrayWithObjects:@{@"image":@"single_wallet",@"name":NSLocalizedString(@"单签钱包", nil)}
//                           ,@{@"image":@"multi_wallet",@"name":NSLocalizedString(@"多签钱包", nil)}
//                           ,@{@"image":@"single_walllet_readonly",@"name":NSLocalizedString(@"单签只读钱包", nil)}
                           , nil];
    [self.baseTableView reloadData];
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
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _baseTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSourceArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   HWMHWMcreatWalletListlTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];    cell.dic=self.dataSourceArray[indexPath.section];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=self.dataSourceArray[indexPath.section];
    NSString *nameString=dic[@"name"];
    if ([nameString isEqualToString:NSLocalizedString(@"单签钱包", nil)]) {
        FLCreatAcountVC *vc = [[FLCreatAcountVC alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([nameString isEqualToString:NSLocalizedString(@"多签钱包", nil)]){
        HWMSignThePurseViewController*VC=[[HWMSignThePurseViewController alloc]init];
        
        [self.navigationController pushViewController:VC animated:YES];
    }else if ([nameString isEqualToString:NSLocalizedString(@"单签只读钱包", nil)]){
        __weak __typeof__(self) weakSelf = self;
        WCQRCodeScanningVC *WCQRCode=[[WCQRCodeScanningVC alloc]init];
        WCQRCode.scanBack=^(NSString *addr){
            NSString *data=[[FLTools share]WhetherTheCurrentTypeWithDataString:addr withType:@"1"];
            [weakSelf popSingleSignReadOnlyWalletVCWithAddString:data withQRCodeString:addr];
        };
    
        [self QRCodeScanVC:WCQRCode];
       
       
        
    }
    
}

-(void)popSingleSignReadOnlyWalletVCWithAddString:(NSString*)addS withQRCodeString:(NSString*)QRCodeString{
    if (addS.length>0) {
        HWMSingleSignReadOnlyWalletViewController *VC=[[HWMSingleSignReadOnlyWalletViewController alloc]init];
        VC.jsonString=addS;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        HWMQrCodeScanningResultsViewController *QrCodeScanningResultsVC=[[HWMQrCodeScanningResultsViewController alloc]init];
        QrCodeScanningResultsVC.resultString=QRCodeString;
        [self.navigationController pushViewController:QrCodeScanningResultsVC animated:NO];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
-(void)backTheWallet:(FLWallet *)wallet{
    
    
}
@end
