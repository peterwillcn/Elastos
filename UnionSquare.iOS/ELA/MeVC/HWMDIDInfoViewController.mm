//
//  HWMDIDInfoViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/30.
//

#import "HWMDIDInfoViewController.h"
#import "HWMDIDInfoTableViewCell.h"
#import "HWMTheEditorDIDInfoViewController.h"
#import "HWMConfidentialInformationViewController.h"
#import "HMWFMDBManager.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HWMDIDManager.h"
#import "ELWalletManager.h"

static NSString *cellString=@"HWMDIDInfoTableViewCell";
@interface HWMDIDInfoViewController ()<UITableViewDataSource,UITableViewDelegate,HMWToDeleteTheWalletPopViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *DIDInfoTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *theEditorButton;
@property (weak, nonatomic) IBOutlet UIButton *ConfidentialInformationButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(copy,nonatomic)NSString *PubKeyString;

@property(copy,nonatomic)NSArray *dataArray;
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *deleteDIDPopView;
@end

@implementation HWMDIDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=@"DID";
    [self getDIDInfo];
    self.DIDInfoTextLabel.text=NSLocalizedString(@"DID信息", nil);
    [[HMWCommView share]makeBordersWithView:self.theEditorButton];
    [[HMWCommView share]makeBordersWithView:self.ConfidentialInformationButton];
    [self.theEditorButton setTitle:NSLocalizedString(@"编辑", nil) forState:UIControlStateNormal];
    [self.ConfidentialInformationButton setTitle:NSLocalizedString(@"凭证信息", nil) forState:UIControlStateNormal];
    [self makeUI];
}
-(void)getDIDInfo{
    [[HWMDIDManager shareDIDManager]hasDIDWithPWD:@"" withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO];
    NSDictionary *didInfoDic=[[HWMDIDManager shareDIDManager]getDIDInfo];
    if (self.model==nil) {
        self.model=[[HWMDIDInfoModel alloc]init];
    }
    self.model.did=didInfoDic[@"DIDString"];
    self.model.didName=didInfoDic[@"nickName"];
    self.model.endString=didInfoDic[@"endTime"];
    if (self.model.didName.length==0) {
        self.model.didName=@"unknown";
    }
    invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,@"IDChain",@"0",@"100"] callbackId:self.currentWallet.masterWalletID className:@"wallet" methodName:@"createMasterWallet"];
    PluginResult * resultBasePublicKeysList =[[ELWalletManager share]getAllPublicKeys:cmommand];
    NSString *status=[NSString stringWithFormat:@"%@",resultBasePublicKeysList.status];
    if ([status isEqualToString:@"1"]) {
        
        NSArray *PublicKeysListArray=resultBasePublicKeysList.message[@"success"][@"PublicKeys"];
        
        self.PubKeyString=PublicKeysListArray.firstObject;
        
        
    }
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[NSArray arrayWithObjects:NSLocalizedString(@"姓名", nil),NSLocalizedString(@"主管理公钥", nil),NSLocalizedString(@"DID", nil),NSLocalizedString(@"有效期", nil), nil];
    }
    return _dataArray;
}
-(void)deleteDIDEvent{
    
    UIView * mainView=[self mainWindow];
    [mainView addSubview:self.deleteDIDPopView];
    [self.deleteDIDPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
    
}
-(HMWToDeleteTheWalletPopView *)deleteDIDPopView{
    if (!_deleteDIDPopView) {
        _deleteDIDPopView =[[HMWToDeleteTheWalletPopView alloc]init];
        _deleteDIDPopView.delegate=self;
        _deleteDIDPopView.deleteType=deleteDIDInfoType;
    }
    return _deleteDIDPopView;
}

-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self toCancelOrCloseDelegate];
}
-(void)toCancelOrCloseDelegate{
    [self.deleteDIDPopView removeFromSuperview];
    self.deleteDIDPopView=nil;
    
}
- (IBAction)theEditorEvent:(id)sender {
    HWMTheEditorDIDInfoViewController *TheEditorDIDInfoVC=[[HWMTheEditorDIDInfoViewController alloc]init];
    TheEditorDIDInfoVC.model=self.model;
    TheEditorDIDInfoVC.currentWallet=self.currentWallet;
    TheEditorDIDInfoVC.PubKeyString=self.PubKeyString;
    [self.navigationController pushViewController:TheEditorDIDInfoVC animated:YES];
}
- (IBAction)ConfidentialInformationEvent:(id)sender {
    HWMConfidentialInformationViewController *ConfidentialInformationVC=[[HWMConfidentialInformationViewController alloc]init];
    ConfidentialInformationVC.model=self.model;
    ConfidentialInformationVC.currentWallet=self.currentWallet;
    [self.navigationController pushViewController:ConfidentialInformationVC animated:YES];
}
-(void)makeUI{
    [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.rowHeight = 55;
    self.table.delegate =self;
    self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
    [self.table reloadData];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HWMDIDInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    cell.leftTextLabel.text=self.dataArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.arrImageView.alpha=0.f;
            cell.infoLabel.text=self.model.didName;
            break;
        case 1:
            cell.infoLabel.text=self.PubKeyString;
            break;
        case 2:
            cell.infoLabel.text=self.model.did;
            
            break;
        case 3:
            cell.arrImageView.alpha=0.f;
            if (self.model.endString.length>0) {
                cell.infoLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"至", nil),[[FLTools share]YMDCommunityTimeConversionTimeFromTimesTamp:self.model.endString]];
            }
            
            break;
            
        default:
            
            break;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}

-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
}

@end
