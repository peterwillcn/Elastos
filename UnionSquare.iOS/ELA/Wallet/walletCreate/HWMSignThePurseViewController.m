//
//  HWMSignThePurseViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/2.
//

#import "HWMSignThePurseViewController.h"
#import "HWMaddSignThePursefootView.h"
#import "HWMaddSignThePurseViewTableViewCell.h"
#import "HWMSignThePurseHeadView.h"
#import "AddressPickerView.h"
#import "HWMAddThePrivateKeyViewController.h"
#import "ScanQRCodeViewController.h"
#import "HWMaddSignThePursefootTableViewCell.h"

static NSString*cellString=@"HWMaddSignThePurseViewTableViewCell";
static NSString*cellFootString=@"HWMaddSignThePursefootTableViewCell";

@interface HWMSignThePurseViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate,HWMAddThePrivateKeyViewControllerDelegate,HWMaddSignThePurseViewTableViewCellDeleagate>

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMSignThePurseHeadView *SignThePurseView;
/*
 *<# #>
 */
@property(strong,nonatomic)AddressPickerView *PickerV;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger SignThePurseInter;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMaddSignThePursefootView *footView;


@end

@implementation HWMSignThePurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.SignThePurseInter=2;
    self.title=NSLocalizedString(@"创建多签钱包", nil);
    [self makeUI];
}
-(void)makeUI{
   
    self.baseTableView.dataSource=self;
    self.baseTableView.delegate=self;
    self.baseTableView.backgroundColor=[UIColor clearColor];
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
        [self.baseTableView registerNib:[UINib nibWithNibName:cellFootString bundle:nil] forCellReuseIdentifier:cellFootString];
    [self.baseTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit)];
    self.baseTableView.userInteractionEnabled=YES;
  
    [self.baseTableView addGestureRecognizer:tap];
    
}
-(AddressPickerView *)PickerV{
    if (!_PickerV) {
        _PickerV =[[AddressPickerView alloc]init];
        _PickerV.delegate=self;
        
    }
    return _PickerV;
}
- (void)sureActionWithNumber:(NSString*)number{
    self.SignThePurseView.numberLabel.text=number;
    [self closePickerView];
}
-(void)closePickerView{
    [self.PickerV removeFromSuperview];
    self.PickerV=nil;
}
-(HWMSignThePurseHeadView *)SignThePurseView{
    if (!_SignThePurseView) {
        _SignThePurseView =[[HWMSignThePurseHeadView alloc]initWithFrame:CGRectMake(130, 0, AppWidth-60, 150)];
        [_SignThePurseView.changeNumberSignatureButton addTarget:self action:@selector(aleartNumberView) forControlEvents:UIControlEventTouchUpInside];
        [_SignThePurseView.addPurseButton addTarget:self action:@selector(AddThePrivateKeyView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SignThePurseView;
}
-(HWMaddSignThePursefootView *)footView{
    if (!_footView) {
       _footView =[[HWMaddSignThePursefootView alloc]init];
        _footView.frame=CGRectMake(0, 0, AppWidth, 230);
        [_footView.addButton addTarget:self action:@selector(addSinWallet) forControlEvents:UIControlEventTouchUpInside];
        [_footView.confirmCreateButton addTarget:self action:@selector(ConfirmToCreate) forControlEvents:UIControlEventTouchUpInside];
    }

    return _footView;
}
-(void)AddThePrivateKeyView{
    HWMAddThePrivateKeyViewController*vc=[[HWMAddThePrivateKeyViewController alloc]init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)aleartNumberView{
    UIView *maView=[self mainWindow];
    [maView addSubview:self.PickerV];
    [self.PickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(maView);
    }];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return  self.SignThePurseInter;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.SignThePurseInter==indexPath.row+1) {
        HWMaddSignThePursefootTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellFootString];
        [cell.addButton addTarget:self action:@selector(addSinWallet) forControlEvents:UIControlEventTouchUpInside];
        [cell.confirmCreateButton addTarget:self action:@selector(ConfirmToCreate) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
   HWMaddSignThePurseViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.row=indexPath.row;
    cell.delegate=self;

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.SignThePurseView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
 
    return [[UIView alloc]initWithFrame:CGRectZero];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.SignThePurseInter==indexPath.row+1) {
        return 230;
    }
    return 54;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    
    return 230;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 230;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEdit];
}
-(void)endEdit{
    [self.view endEditing:YES];
}
#pragma mark ---------<#string #>----------
-(void)addSinWallet{
    
    self.SignThePurseInter++;
    [self.baseTableView reloadData];
    
}
-(void)ConfirmToCreate{
   NSString *walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    
  NSString *masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:walletID];
    
}
-(void)backWithWord:(NSString *)word withPWD:(NSString * _Nonnull)PWD{
    if (word.length>0) {
        
        [self.SignThePurseView.addPurseButton setTitle:NSLocalizedString(@"编辑主私钥", nil) forState:UIControlStateNormal];
        self.SignThePurseView.iconImageView.image=[UIImage imageNamed:@"asset_adding_select"];
    }
    
}
-(void)QrCodeIndex:(NSInteger)row{
        __weak __typeof__(self) weakSelf = self;
        ScanQRCodeViewController *scanQRCodeVC = [[ScanQRCodeViewController alloc]init];
        scanQRCodeVC.scanBack = ^(NSString *addr) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
            HWMaddSignThePurseViewTableViewCell *cell = [weakSelf.baseTableView cellForRowAtIndexPath:index];
        cell.signThePublicKeyTextField.text=addr;
    
        };
        [self QRCodeScanVC:scanQRCodeVC];
    
}

@end
