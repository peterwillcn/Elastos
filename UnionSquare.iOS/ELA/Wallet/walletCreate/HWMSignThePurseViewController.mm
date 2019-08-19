//
//  HWMSignThePurseViewController.m
//  elastos wallet
//HWMSingleSignReadOnlyWalletViewController
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
#import "ELWalletManager.h"
#import "FMDBWalletModel.h"
#import "HMWFMDBManager.h"
#import "AppDelegate.h"
#import "FLPrepareVC.h"
#import "FLFLTabBarVC.h"
#import "WCQRCodeScanningVC.h"

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
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger typeInt;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *WalletID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *PWD;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *xprv;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *mnemonic;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *phrasePassword;

@end

@implementation HWMSignThePurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.SignThePurseInter=3;
    self.title=NSLocalizedString(@"创建多签钱包", nil);
    [self makeUI];
    self.typeInt=0;
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
    
    if (self.SignThePurseInter>6&&self.SignThePurseView.addPurseButton.userInteractionEnabled==YES){
       [[FLTools share]showErrorInfo:NSLocalizedString(@"公钥数量过多", nil)];
        return;
    }
    if (self.SignThePurseInter>7) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"公钥数量过多", nil)];
        return;
    }
    self.SignThePurseInter++;
    [self.baseTableView reloadData];
    
    
}
-(void)ConfirmToCreate{
    if (self.SignThePurseView.addPurseButton.userInteractionEnabled==YES) {
        if (self.SignThePurseInter-1<[self.SignThePurseView.numberLabel.text intValue]) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"公钥数量过少", nil)];
        }
        
    }
    if (self.SignThePurseView.addPurseButton.userInteractionEnabled==NO){} {
        if (self.SignThePurseInter<[self.SignThePurseView.numberLabel.text intValue]) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"公钥数量过少", nil)];
        }
    }
    if (self.typeInt==0) {
        [self creatReadOnlyWallet];
    }else if (self.typeInt==2){
        [self creatImportWalletID];
        
    }else{
        
        
    }
    
    
}
-(void)creatReadOnlyWallet{
    if (![[FLTools share]checkWalletName:self.SignThePurseView.walletNameTextField.text]) {
        return;
    }
    NSString *walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    NSString *masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:walletID];
    NSMutableArray*publicKeysArray=[[NSMutableArray alloc]init];
    for (int i=0; i<self.SignThePurseInter-1;i++) {
        NSIndexPath* indepa=[NSIndexPath indexPathForRow:i inSection:0];
                HWMaddSignThePurseViewTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:indepa];
        if (cell.signThePublicKeyTextField.text.length>0) {
         [publicKeysArray addObject:cell.signThePublicKeyTextField.text];
        }else{
            [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入多签公钥", nil)];
            return;}

    }
    FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
    model.walletID=masterWalletID;
    model.walletName=self.SignThePurseView.walletNameTextField.text;
    model.TypeW=HowSignReadonly;
   
    
   
    
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[masterWalletID,publicKeysArray,self.SignThePurseView.numberLabel.text] callbackId:masterWalletID className:@"Wallet" methodName:@"CreateMultiSignMasterWalletmasterReadonly"];
    PluginResult * result =[[ELWalletManager share]CreateMultiSignMasterWalletmasterReadonly:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]){
    
        [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
        invokedUrlCommand *subCmommand=[[invokedUrlCommand alloc]initWithArguments:@[masterWalletID,@"ELA",@"10000"] callbackId:masterWalletID className:@"Wallet" methodName:@"createMasterWallet"];
        
        PluginResult *subResult= [[ELWalletManager share] createSubWallet:subCmommand];
        NSString *status =[NSString stringWithFormat:@"%@",subResult.status];
        
        if([status isEqualToString:@"1"]){
            
            FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
            model.walletID=masterWalletID;
            model.walletName=self.SignThePurseView.walletNameTextField.text;
            model.TypeW=SingleSign;
            [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
            sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
            sideModel.walletID=model.walletID;
            sideModel.sideChainName=@"ELA";
            
            sideModel.sideChainNameTime=@"--:--";
            sideModel.thePercentageCurr=@"0";
            sideModel.thePercentageMax=@"100";
            
            [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
            [self successfulSwitchingRootVC];
            
            
        }
    }
    
}
-(void)creatImportTheMnemonic{
    if (![[FLTools share]checkWalletName:self.SignThePurseView.walletNameTextField.text]) {
        return;
    }
    NSString *walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    NSString *masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:walletID];
    NSMutableArray*publicKeysArray=[[NSMutableArray alloc]init];
    for (int i=0; i<self.SignThePurseInter-1;i++) {
        NSIndexPath* indepa=[NSIndexPath indexPathForRow:i inSection:0];
        HWMaddSignThePurseViewTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:indepa];
        if (cell.signThePublicKeyTextField.text.length>0) {
            [publicKeysArray addObject:cell.signThePublicKeyTextField.text];
        }else{
            [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入多签公钥", nil)];
            return;}
        
    }
    FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
    model.walletID=masterWalletID;
    model.walletName=self.SignThePurseView.walletNameTextField.text;
    model.TypeW=HowSign;
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[masterWalletID,self.mnemonic,self.phrasePassword,self.PWD,publicKeysArray,self.SignThePurseView.numberLabel.text] callbackId:masterWalletID className:@"Wallet" methodName:@"CreateMultiSignMasterWalletMnemonic"];
    PluginResult * result =[[ELWalletManager share]CreateMultiSignMasterWalletMnemonic:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]){
        [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
        FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
        model.walletID=masterWalletID;
        model.walletName=self.SignThePurseView.walletNameTextField.text;
        model.TypeW=SingleSign;
        
        [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
        invokedUrlCommand *subCmommand=[[invokedUrlCommand alloc]initWithArguments:@[masterWalletID,@"ELA",@"10000"] callbackId:masterWalletID className:@"Wallet" methodName:@"createMasterWallet"];
        
        PluginResult *subResult= [[ELWalletManager share] createSubWallet:subCmommand];
        NSString *status =[NSString stringWithFormat:@"%@",subResult.status];
        
        if([status isEqualToString:@"1"]){
        
        sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
        sideModel.walletID=model.walletID;
        sideModel.sideChainName=@"ELA";
        
        sideModel.sideChainNameTime=@"--:--";
        sideModel.thePercentageCurr=@"0";
        sideModel.thePercentageMax=@"100";
        
        [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
            [self successfulSwitchingRootVC];
            
        }
    }
}

-(void)creatImportWalletID{
    if (![[FLTools share]checkWalletName:self.SignThePurseView.walletNameTextField.text]) {
        return;
    }
    NSMutableArray*publicKeysArray=[[NSMutableArray alloc]init];
    for (int i=0; i<self.SignThePurseInter-1;i++) {
        NSIndexPath* indepa=[NSIndexPath indexPathForRow:i inSection:0];
        HWMaddSignThePurseViewTableViewCell *cell=[self.baseTableView cellForRowAtIndexPath:indepa];
        if (cell.signThePublicKeyTextField.text.length>0) {
            [publicKeysArray addObject:cell.signThePublicKeyTextField.text];
        }else{
            [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入多签公钥", nil)];
            return;
        }
    }
    FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
    model.walletID=self.WalletID;
    model.walletName=self.SignThePurseView.walletNameTextField.text;
    model.TypeW=HowSign;
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.WalletID,self.xprv,self.PWD,publicKeysArray,self.SignThePurseView.numberLabel.text] callbackId:self.WalletID className:@"Wallet" methodName:@"CreateMultiSignMasterWalletmasterWalletID"];
    PluginResult * result =[[ELWalletManager share]CreateMultiSignMasterWalletmasterMasterWalletId:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]){
        [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
        FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
        model.walletID=self.WalletID;
        model.walletName=self.SignThePurseView.walletNameTextField.text;
        model.TypeW=SingleSign;
        [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
        invokedUrlCommand *subCmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.WalletID,@"ELA",@"10000"] callbackId:self.WalletID className:@"Wallet" methodName:@"createMasterWallet"];
        
        PluginResult *subResult= [[ELWalletManager share] createSubWallet:subCmommand];
        NSString *status =[NSString stringWithFormat:@"%@",subResult.status];
        
        if([status isEqualToString:@"1"]){
        sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
        sideModel.walletID=model.walletID;
        sideModel.sideChainName=@"ELA";
        
        sideModel.sideChainNameTime=@"--:--";
        sideModel.thePercentageCurr=@"0";
        sideModel.thePercentageMax=@"100";
        
        [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
            [self successfulSwitchingRootVC];
            
        }
    }
}
-(void)CallbackWithWalletID:(NSString *)wallet withXPK:(NSString *)XPK withPWD:(NSString * _Nonnull)PWD{
     [self makeButtonKEY];
    self.WalletID=wallet;
    self.xprv=XPK;
    self.PWD=PWD;
    self.typeInt=2;
}
-(void)backWithWord:(NSString *)word withPWD:(NSString * _Nonnull)PWD withPhrasePassword:(NSString *)phrasePassword{
    if (word.length>0) {
        self.mnemonic=word;
        self.typeInt=1;
         self.PWD=PWD;
        self.phrasePassword=phrasePassword;
        [self makeButtonKEY];
    }
}
-(void)ImportTheMnemonicWordViewWithMnemonic:(NSString*)Mnemonic withPWD:(NSString*)PWD withPhrasePassword:(NSString *)phrasePassword{
    self.mnemonic=Mnemonic;
    self.typeInt=1;
     self.PWD=PWD;
    self.phrasePassword=phrasePassword;
    [self makeButtonKEY];
}
-(void)QrCodeIndex:(NSInteger)row{
    __weak __typeof__(self) weakSelf = self;
    WCQRCodeScanningVC *WCQRCode=[[WCQRCodeScanningVC alloc]init];
    WCQRCode.scanBack=^(NSString *addr){
        NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
        HWMaddSignThePurseViewTableViewCell *cell = [weakSelf.baseTableView cellForRowAtIndexPath:index];
        cell.signThePublicKeyTextField.text=addr;
    };
}
-(void)makeButtonKEY{
    [self.SignThePurseView.addPurseButton setTitle:NSLocalizedString(@"编辑根私钥", nil) forState:UIControlStateNormal];
    self.SignThePurseView.iconImageView.image=[UIImage imageNamed:@"asset_adding_select"];
}
-(void)successfulSwitchingRootVC{
    
    
    
    [[FLTools share]showErrorInfo:NSLocalizedString(@"创建成功", nil)];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appdelegate.window.rootViewController;
    if ([rootViewController.childViewControllers.firstObject isKindOfClass:[FLPrepareVC class]]) {
        FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
        appdelegate.window.rootViewController=tabVC;
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:updataCreateWallet object:nil ];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
@end
