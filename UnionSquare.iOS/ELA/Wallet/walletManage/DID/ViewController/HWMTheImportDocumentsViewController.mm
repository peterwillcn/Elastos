//
//  HWMTheImportDocumentsViewController.m
//  elastos wallet
//
//  Created by  on 2020/2/14.
//

#import "HWMTheImportDocumentsViewController.h"
#import "HWMImportDocumentsTableViewCell.h"
#import "HWMallDocumentsListViewController.h"
#import "MyUtil.h"
#import "NSString+YYAdd.h"
#import "HWMDIDManager.h"
#import "HMWpwdPopupView.h"
#import "ELWalletManager.h"
#import "HMWToDeleteTheWalletPopView.h"
static NSString *cellString=@"HWMImportDocumentsTableViewCell";
UINib *ImportDocumentsNib;
@interface HWMTheImportDocumentsViewController ()<UITableViewDataSource,UITableViewDelegate,HMWpwdPopupViewDelegate,HMWToDeleteTheWalletPopViewDelegate>
@property(strong,nonatomic)UIButton*skipButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(strong,nonatomic)NSMutableArray *allDirAaary;

@property(assign,nonatomic)NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet UIButton *selectFlieButton;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWpwdPopupView*pwdPopupV;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView*documentsCoveringPopupV;
@end

@implementation HWMTheImportDocumentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"导入凭证", nil);
    self.selectIndex=-1;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
    [self.selectFlieButton setTitle: NSLocalizedString(@"选择文件", nil) forState:UIControlStateNormal];
    [self makeUI];
}
-(void)makeUI{
    ImportDocumentsNib=[UINib nibWithNibName:cellString bundle:nil];
    [self.table registerNib: ImportDocumentsNib forCellReuseIdentifier:cellString];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.rowHeight = 50;
    self.table.delegate =self;
    self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
}
-(UIButton *)skipButton{
    if (!_skipButton) {
        _skipButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_skipButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_skipButton addTarget:self action:@selector(skipVCEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
}
-(void)skipVCEvent{
    
    if (self.selectIndex<0||self.allDirAaary.count==0) {
        return;
    }
    UIView *manView=[self mainWindow];
    [manView addSubview:self.documentsCoveringPopupV];
    [self.documentsCoveringPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    
    
    
    
}
-(void)makeSureWithPWD:(NSString*)pwd{
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,pwd] callbackId:self.currentWallet.masterWalletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
      NSString * privatekeyString=[[ELWalletManager share]ExportxPrivateKey:mommand];
      if (privatekeyString.length==0) {
          return;
      }
      [[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.currentWallet.didString WithPrivatekeyString:privatekeyString WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO];
      NSDictionary *dic=self.allDirAaary[self.selectIndex];
      BOOL isSucce=  [[HWMDIDManager shareDIDManager]CertificateUpdateWithWalletID:self.currentWallet.masterWalletID WithFileName:dic[@"fileName"]];
      if (isSucce) {
          [[FLTools share]showErrorInfo:@"覆盖成功"];
          [self hiddenPWDView];
          [self.navigationController popViewControllerAnimated:NO];
      }else{
          [[FLTools share]showErrorInfo:@"覆盖失败"];
      }
    [self toCancelOrCloseDelegate];
}
-(void)hiddenPWDView{
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV=nil;
    
    
}
-(void)cancelThePWDPageView{
    [self hiddenPWDView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allDirAaary.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMImportDocumentsTableViewCell *cell=[ImportDocumentsNib instantiateWithOwner:nil options:nil].firstObject;
    NSDictionary *dic=self.allDirAaary[indexPath.row];
    cell.docNameLabel.text=dic[@"fileName"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==self.selectIndex) {
        cell.selectImageView.alpha=1.f;
    }else{
        cell.selectImageView.alpha=0.f;
    }
    return cell;
}
-(NSMutableArray *)allDirAaary{
    if (!_allDirAaary) {
        NSArray *allFarray=[MyUtil ReadDIDPathWithWalletID:self.currentWallet.masterWalletID];
        _allDirAaary =[[NSMutableArray alloc]initWithArray:allFarray];
        
    }
    return _allDirAaary;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectIndex>-1) {
        HWMImportDocumentsTableViewCell *cell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
        cell.selectImageView.alpha=0.f;
    }
    HWMImportDocumentsTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selectImageView.alpha=1.f;
    
    self.selectIndex=indexPath.row;
    
    
    
    
}
- (IBAction)selectFlieEvent:(id)sender {
    HWMallDocumentsListViewController *HWMallDocumentsListVC=[[HWMallDocumentsListViewController alloc]init];
    __weak __typeof__ (self) weakSelf = self;
    HWMallDocumentsListVC.block = ^(NSString * _Nonnull flieName) {
        [weakSelf ParsingJWTFileWithFileName:flieName];
    };
    [self.navigationController pushViewController:HWMallDocumentsListVC animated:YES];
}
-(void)ParsingJWTFileWithFileName:(NSString*)fileName{
    NSString *fileContString=[MyUtil readFlieCommDIDWithFlieName:fileName];
    
    NSDictionary *dicfileCont=[fileContString jsonValueDecoded];
    if ([dicfileCont[@"credentialSubject"][@"did"] isEqualToString:self.currentWallet.didString]) {
        [MyUtil saveDIDPathWithWalletID:self.currentWallet.masterWalletID withString:fileContString WithFielName:fileName];
        [self.allDirAaary addObject:@{@"fileName":fileName,@"date":@"1111"}];
        [self.table reloadData];
    }else{// 不是自己的
        [[FLTools share]showErrorInfo:NSLocalizedString(@"凭证文件不匹配", nil)];
    }
}
-(HMWpwdPopupView *)pwdPopupV{
    if (!_pwdPopupV) {
        _pwdPopupV =[[HMWpwdPopupView  alloc]init];
        _pwdPopupV.delegate=self;
    }
    return _pwdPopupV;
}
-(HMWToDeleteTheWalletPopView *)documentsCoveringPopupV{
    if (!_documentsCoveringPopupV) {
        _documentsCoveringPopupV=[[HMWToDeleteTheWalletPopView alloc]init];
        _documentsCoveringPopupV.delegate=self;
        _documentsCoveringPopupV.deleteType=documentsCoveringType;
    }
    return _documentsCoveringPopupV;;
}
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    
  UIView *manView=[self mainWindow];
    [manView addSubview:self.pwdPopupV];
    [self.pwdPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    [self toCancelOrCloseDelegate];
    
}
-(void)toCancelOrCloseDelegate{
    [self.documentsCoveringPopupV removeFromSuperview];
    self.documentsCoveringPopupV=nil;
}
@end
