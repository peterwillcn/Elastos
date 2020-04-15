//
//  HWMCreateDIDViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/21.
//

#import "HWMCreateDIDViewController.h"
#import "HWMCreateDIDListTableViewCell.h"
#import "HWMDIDWalletListView.h"
#import "HWMDIDDataListView.h"
#import "HMWFMDBManager.h"
#import "ELWalletManager.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HMWAddTheCurrencyListViewController.h"
#import "HWMAddPersonalInformationViewController.h"
#import "HWMDIDInfoModel.h"
#import "HMWpwdPopupView.h"
static NSString *cellString=@"HWMCreateDIDListTableViewCell";

@interface HWMCreateDIDViewController ()<UITableViewDelegate,UITableViewDataSource,HWMDIDWalletListViewDelegate,HWMDIDDataListViewDelegate,HMWToDeleteTheWalletPopViewDelegate,HMWAddTheCurrencyListViewControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,HMWpwdPopupViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *dataSorse;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDDataListView *dataListView;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDWalletListView *walletListView;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *walletListArray;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger wallerSelectIndex;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *YYMMDD;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *openIDChainView;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL  NeedsSaved;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL  isNext;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString*DIDString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString*PublicKeysString;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDInfoModel *DIDInfoModel;
/*
 *<# #>-(HMWpwdPopupView *)ShowPoPWDView
 */
@property(strong,nonatomic)HMWpwdPopupView *ShowPoPWDView;
@property (nonatomic, strong)FLWallet *currentWallet;


@end

@implementation HWMCreateDIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defultWhite];
    [self setBackgroundImg:@""];
    
    self.title=NSLocalizedString(@"创建DID", nil);
 
    self.wallerSelectIndex=-1;
    self.NeedsSaved=NO;
    [self makeUI];
    self.navigationController.delegate=self;
//       [self isOpenIDChain];
 
}
-(HWMDIDInfoModel *)DIDInfoModel{
    if (!_DIDInfoModel) {
        _DIDInfoModel =[[HWMDIDInfoModel alloc]init];
    }
    return _DIDInfoModel;
}
-(void)isOpenIDChain{
   
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.walletID] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
       PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
         NSString *status=[NSString stringWithFormat:@"%@",result.status];
         if ([status isEqualToString:@"1"]) {
         NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
             if (array.count>1) {
              
                 [self showPWDView];
             }else{
               
                 UIView *mainView =[self mainWindow];
                 self.openIDChainView.deleteType=openIDChainType;
                 [mainView addSubview:self.openIDChainView];
                 [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.left.right.top.bottom.equalTo(mainView);
                 }];
                 
             }
         }
         
}
-(HMWpwdPopupView *)ShowPoPWDView{
    if (!_ShowPoPWDView) {
        _ShowPoPWDView=[[HMWpwdPopupView alloc]init];
        _ShowPoPWDView.delegate=self;
        
    }
    return _ShowPoPWDView;
}
-(void)makeUI{
    self.dataSorse =@[NSLocalizedString(@"请输入姓名(必填)", nil)
//    ,NSLocalizedString(@"请选择钱包", nil),NSLocalizedString(@"主管理公钥（发布后不可更改）", nil),NSLocalizedString(@"DID（与主管理公钥一一对应）",nil)
    ,NSLocalizedString(@"请选择失效日期", nil)];
    [self.nextButton setTitle:NSLocalizedString(@"下一步", nil) forState: UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.nextButton];
    [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
       self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
       self.table.rowHeight = 55;
       self.table.delegate =self;
       self.table.dataSource =self;
       self.table.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditingTap)];
    [self.table addGestureRecognizer:tap];
}
-(void)endEditingTap{
    [self.view endEditing:YES];
}
-(void)getDIDAndDIDPublicKey{
    FMDBWalletModel *model=self.walletListArray[self.wallerSelectIndex];
     invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID,@"IDChain",@"0",@"100"] callbackId:model.walletID className:@"wallet" methodName:@"createMasterWallet"];
   PluginResult * resultBaseDIDlist =[[ELWalletManager share]getDIDlist:cmommand];
   PluginResult * resultBasePublicKeysList =[[ELWalletManager share]getAllPublicKeys:cmommand];
    NSString *status=[NSString stringWithFormat:@"%@",resultBaseDIDlist.status];
       if ([status isEqualToString:@"1"]) {
    NSArray *DIDlistArray=resultBaseDIDlist.message[@"success"][@"DID"];
    NSArray *PublicKeysListArray=resultBasePublicKeysList.message[@"success"][@"PublicKeys"];
    self.DIDString=DIDlistArray.firstObject;
    self.PublicKeysString=PublicKeysListArray.firstObject;
    self.DIDInfoModel.did=self.DIDString;
//           self.DIDInfoModel.PubKeyString=self.PublicKeysString;
        
           
       }
}
-(HMWToDeleteTheWalletPopView *)openIDChainView{
    if (!_openIDChainView) {
        _openIDChainView =[[HMWToDeleteTheWalletPopView alloc]init];
        _openIDChainView.delegate=self;
    }
    return _openIDChainView;
}
-(HWMDIDDataListView *)dataListView{
    if (!_dataListView) {
        _dataListView =[[HWMDIDDataListView alloc]init];
        _dataListView.delegate=self;
        _dataListView.ListViewType=DIDDataType;
    }
    return _dataListView;
}
-(HWMDIDWalletListView *)walletListView{
    if (!_walletListView) {
        _walletListView =[[HWMDIDWalletListView alloc]init];
        _walletListView.delegate=self;
    }
    return _walletListView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // FLSugarModel *model = self.dataSouse[indexPath.row];
    HWMCreateDIDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.intPutTextField.tag=100+indexPath.row;
    cell.intPutTextField.delegate=self;
    NSString *textString=self.dataSorse[indexPath.row];
    switch (indexPath.row) {
            case 0:
            cell.arrowImageView.alpha=0.f;
            cell.intPutTextField.placeholder=textString;
//            [cell.intPutTextField addTarget:self action:@selector(nameChanged:) forControlEvents:UIControlEventValueChanged];
            [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.intPutTextField withTxt:textString];
            break;
            case 1:
              if (self.YYMMDD.length>0) {
                          textString=self.YYMMDD;
                      }
                  
                      cell.arrowImageView.alpha=1.f;
                    cell.arrowImageView.image=[UIImage imageNamed:@"asset_list_arrow"];
                      cell.intPutTextField.text=textString;
//            cell.intPutTextField.enabled=NO;
            
            break;
            case 2:
            cell.arrowImageView.alpha=0.f;
            if (self.DIDString.length>0) {
//                cell.intPutTextField.text=self.DIDString;
                cell.intPutTextField.alpha=0;
                cell.infoLabel.text=self.PublicKeysString;
                cell.infoLabel.alpha=1.f;
            }else{
                cell.intPutTextField.placeholder=textString;
                [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.intPutTextField withTxt:textString];
            }
            
            break;
            case 3:
            cell.arrowImageView.alpha=0.f;
          if (self.PublicKeysString.length>0) {
              cell.intPutTextField.alpha=0;
              cell.infoLabel.text=[NSString stringWithFormat:@"did:elastos:%@",self.PublicKeysString];
                 cell.infoLabel.alpha=1.f;
//              cell.intPutTextField.text=self.PublicKeysString;
          }else{
              cell.intPutTextField.placeholder=textString;
              [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.intPutTextField withTxt:textString];
          }
            break;
            case 4:
            if (self.YYMMDD.length>0) {
                textString=self.YYMMDD;
            }
        
            cell.arrowImageView.alpha=1.f;
            cell.arrowImageView.image=[UIImage imageNamed:@"asset_list_arrow"];
            cell.intPutTextField.text=textString;
//            cell.intPutTextField.enabled=NO;
            break;
            
        default:
            break;
    }

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSorse.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    if (indexPath.row==1){
        UIView *mainView =[self mainWindow];
               [mainView addSubview:self.dataListView];
        [self.dataListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 50)];
    headView.backgroundColor=[UIColor clearColor];
    UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, AppWidth-30, 50)];
    headLabel.text=NSLocalizedString(@"DID信息", nil);
    headLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    headLabel.textColor=[UIColor whiteColor];
    [headView addSubview:headLabel];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.f;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
#pragma mark ---------HWMDIDWalletListViewDelegate----------
- (void)cancelDIDListViewView {
    [self.walletListView removeFromSuperview];
    self.walletListView=nil;
}

- (void)selectListIndex:(NSInteger)index {
    [self cancelDIDListViewView];
    FMDBWalletModel *model=self.walletListArray[index];
     invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID] callbackId:model.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
    PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
      NSString *status=[NSString stringWithFormat:@"%@",result.status];
      if ([status isEqualToString:@"1"]) {
      NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
          if (array.count>1) {
            self.wallerSelectIndex=index;
              [self getDIDAndDIDPublicKey];
              [self.table reloadData];
//              self.DIDInfoModel.walletID=model.walletID;
         
          }else{
              self.wallerSelectIndex=index;
              UIView *mainView =[self mainWindow];
              self.openIDChainView.deleteType=openIDChainType;
              [mainView addSubview:self.openIDChainView];
              [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.left.right.top.bottom.equalTo(mainView);
              }];
              
          }
      }
      
    
}
-(void)cancelDataListView{
    [self.dataListView removeFromSuperview];
    self.dataListView=nil;
}
-(void)selectDataWithYY:(NSString*_Nullable)yy withMM:(NSString*_Nullable)mm wihMMWithInt:(NSInteger)mInt wtihDD:(NSString*_Nullable)dd{
    self.YYMMDD=[NSString stringWithFormat:@"%@ %@.%@.%@",NSLocalizedString(@"有效期至 ",nil),yy,mm,dd];
    [self.table reloadData];
    self.DIDInfoModel.endString=[[FLTools share]timeSwitchTimestamp:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",yy,mm,dd]];
    [self cancelDataListView];
}
#pragma mark --------HMWToDeleteTheWalletPopViewDelegate-----------
-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    if (self.openIDChainView.deleteType==openIDChainType) {
        FMDBWalletModel *model=self.walletListArray[self.wallerSelectIndex];
        FLWallet *wallet =[[FLWallet alloc]init];
           wallet.masterWalletID =model.walletID;
           wallet.walletName     =model.walletName;
           wallet.walletAddress  = model.walletAddress;
        HMWAddTheCurrencyListViewController *AddTheCurrencyListVC=[[HMWAddTheCurrencyListViewController alloc]init];
        AddTheCurrencyListVC.wallet=wallet;
        AddTheCurrencyListVC.didType=@"didType";
        AddTheCurrencyListVC.delegate=self;
        self.wallerSelectIndex=-1;
         [self toCancelOrCloseDelegate];
        [self.navigationController pushViewController:AddTheCurrencyListVC animated:YES];

    }else if (self.openIDChainView.deleteType==NeedsSavedType){
         [self toCancelOrCloseDelegate];
    }
}
-(FLWallet *)currentWallet{
    
    if (!_currentWallet) {
        NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
                         FMDBWalletModel *model =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
              self.currentWallet=[[FLWallet alloc]init];
                  self.currentWallet.masterWalletID =model.walletID;
                  self.currentWallet.walletName     =model.walletName;
                  self.currentWallet.walletAddress  = model.walletAddress;
                  self.currentWallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
                  self.currentWallet.TypeW  = model.TypeW;
    }
    return _currentWallet;
}
-(void)toCancelOrCloseDelegate{
    [self.openIDChainView removeFromSuperview];
    self.openIDChainView=nil;
}
#pragma mark ---------  ----------
-(void)openIDChainOfDIDAddWithWallet:(NSString*)walletID{
    if (walletID.length>0&&[walletID isEqualToString:self.currentWallet.walletID]) {
        [self showPWDView];
    }
}
- (IBAction)nextButtonEvent:(id)sender {
    [self.view endEditing:YES];
    if (self.DIDInfoModel.didName.length==0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"请输入姓名(必填)", nil)];
        return;
    }
//    if (self.DIDInfoModel.did.length==0) {
//        [[FLTools share]showErrorInfo:NSLocalizedString(@"请选择钱包", nil)];
//          return;
//    }
//    if (self.DIDInfoModel.PubKeyString.length==0) {
//        [[FLTools share]showErrorInfo:NSLocalizedString(@"请选择钱包", nil)];
//          return;
//    }
    if (self.DIDInfoModel.endString.length==0) {
         [[FLTools share]showErrorInfo:NSLocalizedString(@"请选择失效日期", nil)];
          return;
    }
    HWMAddPersonalInformationViewController *AddPersonalInformationVC=[[HWMAddPersonalInformationViewController alloc]init];
    self.isNext=YES;
    AddPersonalInformationVC.model=self.DIDInfoModel;
    AddPersonalInformationVC.currentWallet=self.currentWallet;
    __weak __typeof__ (self) weakSelf = self;
    AddPersonalInformationVC.successBlock = ^(NSString * _Nonnull DIDString) {
        if (weakSelf.walletIDBlock) {
            weakSelf.walletIDBlock(DIDString);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.navigationController pushViewController:AddPersonalInformationVC animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
   
    if (self.isNext==NO&&self.NeedsSaved) {
        self.openIDChainView.deleteType=NeedsSavedType;
        UIView *mainView =[self mainWindow];
        [mainView addSubview:self.openIDChainView];
        [self.openIDChainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }
     [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isNext=NO;
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
        if (textField.tag==101){
        UIView *mainView =[self mainWindow];
               [mainView addSubview:self.dataListView];
        [self.dataListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
        return NO;
    }
    return YES;

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length==0) {
        NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
          if (![string isEqualToString:tem]) {
              return NO;
          }
    }
    
  return [[FLTools share]textField:textField replacementString:string withStringLenth:50];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==100) {
        self.DIDInfoModel.didName=textField.text;
    }
}
-(void)makeSureWithPWD:(NSString*)pwd{
    
    [self.ShowPoPWDView removeFromSuperview];
      self.ShowPoPWDView=nil;
}
-(void)cancelThePWDPageView{
    [self.ShowPoPWDView removeFromSuperview];
    self.ShowPoPWDView=nil;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)showPWDView{
        UIView *mainView =[self mainWindow];
        [mainView addSubview:self.ShowPoPWDView];
        [self.ShowPoPWDView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    
}
@end
