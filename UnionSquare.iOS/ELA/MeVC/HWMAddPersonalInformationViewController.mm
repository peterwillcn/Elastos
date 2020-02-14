//
//  HWMAddPersonalInformationViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/25.
//

#import "HWMAddPersonalInformationViewController.h"
#import "HWMCreateDIDListTableViewCell.h"
#import "HWMTheAreaCodeAndPhonenumberTableViewCell.h"
#import "HWMAddPersonalProfileViewController.h"
#import "HWMDIDDataListView.h"
#import "HMWSelectCountriesOrRegionsViewController.h"
#import "HMWFMDBManager.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "ELWalletManager.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "HMWAddTheCurrencyListViewController.h"
#import "HMWpwdPopupView.h"
#import "HWMDIDInfoListView.h"

static NSString *cellString=@"HWMCreateDIDListTableViewCell";
static NSString *cellCodeAndPhonenumberString=@"HWMTheAreaCodeAndPhonenumberTableViewCell";

@interface HWMAddPersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource,HWMDIDDataListViewDelegate, HMWSelectCountriesOrRegionsViewControllerDelegate,HWMDIDInfoListViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textInfoLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton *skipButton;
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *dataSorse;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDDataListView *DIDDataListV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWToDeleteTheWalletPopView *openIDChainView;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWpwdPopupView*ShowPoPWDView;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray*defMArray;
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray*allInfoListArray;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray*showInfoListAarry;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDInfoListView*showAllInfoView;

@end

@implementation HWMAddPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
   
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
    [self makeUI];
    if (self.isEidet) {
           self.title=NSLocalizedString(@"编辑个人信息", nil);
        self.skipButton.alpha=0.f;
        self.textInfoLabel.alpha=0.f;
              self.infoHeight.constant=0.f;
         [self.nextButton setTitle:NSLocalizedString(@"保存", nil) forState: UIControlStateNormal];
       }else{
            self.title=NSLocalizedString(@"添加个人信息", nil);
            [self.defMArray addObjectsFromArray:@[@"1",@"2",@"3",@"4",@"7",@"8",@"9",@"12"]];
           [self.showInfoListAarry addObjectsFromArray:@[@"0",@"5",@"6",@"10",@"11",@"13"]];
       }
}
-(HWMDIDInfoListView *)showAllInfoView{
    if (!_showAllInfoView) {
        _showAllInfoView=[[HWMDIDInfoListView alloc]init];
        _showAllInfoView.delegate=self;
    }
    return _showAllInfoView;
}
-(NSMutableArray *)showInfoListAarry{
    if (!_showInfoListAarry) {
        _showInfoListAarry =[[NSMutableArray alloc]init];
    }
    return _showInfoListAarry;
}
-(NSArray *)allInfoListArray{
    if (!_allInfoListArray) {
        _allInfoListArray =@[@{@"text":@"昵称",@"index":@"0",@"type":@"1"},@{@"text":@"性别",@"index":@"1",@"type":@"2"},@{@"text":@"出生日期",@"index":@"2",@"type":@"2"},@{@"text":@"头像地址",@"index":@"3",@"type":@"1"},@{@"text":@"邮箱",@"index":@"4",@"type":@"1"},@{@"text":@"手机号",@"index":@"5",@"type":@"3"},@{@"text":@"国家/地区",@"index":@"6",@"type":@"2"},@{@"text":@"个人简介",@"index":@"7",@"type":@"4"},@{@"text":@"个人主页",@"index":@"8",@"type":@"1"},@{@"text":@"Facebook账号",@"index":@"9",@"type":@"1"},@{@"text":@" Twitter账号",@"index":@"10",@"type":@"1"},@{@"text":@" 微博账号",@"index":@"11",@"type":@"1"},@{@"text":@" 微信账号",@"index":@"12",@"type":@"1"},@{@"text":@" Google账号",@"index":@"13",@"type":@"1"}];
    }
    return _allInfoListArray;
}
-(NSMutableArray *)defMArray{
    if (!_defMArray) {
        _defMArray=[[NSMutableArray alloc]init];
        
    }
    return _defMArray;
}
-(void)makeUI{
    [[HMWCommView share]makeBordersWithView:self.nextButton];
    [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    [self.table registerNib:[UINib nibWithNibName:cellCodeAndPhonenumberString bundle:nil] forCellReuseIdentifier:cellCodeAndPhonenumberString];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.rowHeight = 55;
    self.table.delegate =self;
    self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
}
-(UIButton *)skipButton{
    if (!_skipButton) {
        _skipButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_skipButton setTitle:NSLocalizedString(@"发布", nil) forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_skipButton addTarget:self action:@selector(skipVCEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}
-(void)skipVCEvent{
//    if (self.isEidet) {
//        if ([[HMWFMDBManager sharedManagerType:DIDInfoType]updateDIDInfo:self.model WithWalletID:self.model.walletID]) {
//            [[FLTools share]showErrorInfo:@"保存成功"];
//        }else{
//            [[FLTools share]showErrorInfo:@"保存失败"];
//        }
//
//    }else{
//        HWMAddPersonalProfileViewController *AddPersonalProfileVC=[[HWMAddPersonalProfileViewController alloc]init];
//           AddPersonalProfileVC.model=self.model;
//           [self.navigationController pushViewController:AddPersonalProfileVC animated:YES];
//    }
//
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexString=self.defMArray[indexPath.row];
    NSDictionary *infDic=self.allInfoListArray[[indexString integerValue]];
    NSString *titleString=infDic[@"test"];
    NSString *typeString=infDic[@"type"];
    
    if ([typeString isEqualToString:@"3"]) {
    HWMTheAreaCodeAndPhonenumberTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellCodeAndPhonenumberString]; cell.MobilePhoneTextField.placeholder=NSLocalizedString(@"请输入手机号", nil);
        cell.MobilePhoneTextField.text=self.model.MobilePhoneNoString;
        cell.MobilePhoneTextField.tag=10001;
      [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.MobilePhoneTextField withTxt:NSLocalizedString(@"请输入手机号", nil)];
        cell.theArNumberTextField.placeholder=NSLocalizedString(@"请输入区号", nil);
        cell.theArNumberTextField.tag=10002;
        if (self.model.areMobilePhoneNoString.length>0) {
        cell.theArNumberTextField.text=self.model.areMobilePhoneNoString;
                }
        [cell.theArNumberTextField addTarget:self action:@selector(theArNumberChanged:) forControlEvents:UIControlEventValueChanged];
        [cell.MobilePhoneTextField addTarget:self action:@selector(MobilePhoneChanged:) forControlEvents:UIControlEventValueChanged];
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField: cell.theArNumberTextField withTxt:NSLocalizedString(@"请输入区号", nil)];
                return cell;}
    
//    type//1
    HWMCreateDIDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([typeString isEqualToString:@"2"]) {
        cell.infoLabel.alpha=1.f;
        cell.infoLabel.text=[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"请选择", nil),titleString];
        cell.intPutTextField.alpha=0.f;
    }else if([typeString isEqualToString:@"1"]){
        cell.infoLabel.alpha=0.f;
        cell.intPutTextField.alpha=1.f;
        NSString *placeString=[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"请输入", nil),titleString];
                   cell.intPutTextField.placeholder=placeString;
          [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.intPutTextField withTxt:placeString];
          cell.intPutTextField.tag=100+[indexString integerValue];
            [cell.intPutTextField addTarget:self action:@selector(intPutValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
             


    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.defMArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indeString=self.defMArray[indexPath.row];
   
    
    if ([indeString isEqualToString:@"1"]) {//性别
        self.DIDDataListV.ListViewType=genderType;
        UIView *mainView = [self mainWindow];
        [mainView addSubview:self.DIDDataListV];
        [self.DIDDataListV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }else if ([indeString isEqualToString:@"2"]){//出生
        self.DIDDataListV.ListViewType=birthdayType;
               UIView *mainView = [self mainWindow];
               [mainView addSubview:self.DIDDataListV];
               [self.DIDDataListV mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.right.top.bottom.equalTo(mainView);
               }];
    }else if ([indeString isEqualToString:@"6"]){
        HMWSelectCountriesOrRegionsViewController *SelectCountriesOrRegionsVC=[[HMWSelectCountriesOrRegionsViewController alloc]init];
        SelectCountriesOrRegionsVC.delegate=self;
        [self.navigationController pushViewController:SelectCountriesOrRegionsVC animated:YES];
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (self.isEidet) {
        return [[UIView alloc]initWithFrame:CGRectZero];
//    }
//    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 50)];
//    headView.backgroundColor=[UIColor clearColor];
//    UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, AppWidth-30, 50)];
//    headLabel.text=NSLocalizedString(@"DID信息", nil);
//    headLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
//    headLabel.textColor=[UIColor whiteColor];
//    [headView addSubview:headLabel];
//    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (self.isEidet) {
        return 0.01;
//    }
//    return 50.f;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (IBAction)nextAndSkipEvent:(id)sender {
    UIView *mainView =[self mainWindow];
    [mainView addSubview:self.showAllInfoView];
    [self.showAllInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(mainView);
    }];
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}
-(void)theArNumberChanged:(UITextField*)textField{
    self.model.areMobilePhoneNoString=textField.text;
}
-(void)MobilePhoneChanged:(UITextField*)textField{
    self.model.MobilePhoneNoString=textField.text;
}
-(void)intPutValueChanged:(UITextField*)textField{
    NSInteger tag=textField.tag;
    switch (tag) {
        case 100:
            self.model.nameString=textField.text;
            break;
        case 101:
            self.model.nickNameString=textField.text;
            break;
        case 102:
            self.model.genderString=textField.text;
            break;
        case 103:
            self.model.DateBirthString=textField.text;
            break;
        case 104:
            self.model.iconUrlString=textField.text;
            break;
        case 105:
            self.model.emailString=textField.text;
            break;
        case 107:
            self.model.countriesString=textField.text;
            break;
        case 10001:
            self.model.MobilePhoneNoString=textField.text;
            break;
        case 10002:
            self.model.areMobilePhoneNoString=textField.text;
            break;
        default:
            break;
    }
}
-(HWMDIDDataListView *)DIDDataListV{
    if (!_DIDDataListV) {
        _DIDDataListV =[[HWMDIDDataListView alloc]init];
        _DIDDataListV.delegate=self;
        
    }
    return _DIDDataListV;
}
- (void)cancelDataListView {
    [self.DIDDataListV removeFromSuperview];
    self.DIDDataListV=nil;
}
-(void)selectGender:(NSUInteger)genderType{
    
    self.model.genderString=[NSString stringWithFormat:@"%lu",(unsigned long)genderType];
    [self.table reloadData];
}
-(void)selectDataWithYY:(NSString *)yy withMM:(NSString *)mm wihMMWithInt:(NSInteger)mInt wtihDD:(NSString *)dd{
    
    self.model.DateBirthString=[[FLTools share]timeSwitchTimestamp:[NSString stringWithFormat:@"%@-%@-%@",yy,mm,dd]];
        
         [self.table reloadData];
        [self cancelDataListView];
    
}

-(void)selectTheCountryAreasModel:(NSDictionary*)modelDic{
    
   self.model.countriesString = modelDic[@"mobileCode"];
    
   [self.table reloadData];
    
    
}
-(void)setIsEidet:(Boolean)isEidet{
    _isEidet=isEidet;
}
//-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
//    HMWAddTheCurrencyListViewController *AddTheCurrencyListVC=[[HMWAddTheCurrencyListViewController alloc]init];
//        AddTheCurrencyListVC.wallet=self.currentWallet;
//        AddTheCurrencyListVC.didType=@"didType";
//        AddTheCurrencyListVC.delegate=self;
//        [self.navigationController pushViewController:AddTheCurrencyListVC animated:YES];
//
//}
-(void)addInfoWithIndex:(NSString *)index{
    [self.defMArray addObject:self.allInfoListArray[[index integerValue]]];
    
}
- (void)closeView{
    [self.showAllInfoView removeFromSuperview];
    [self.table reloadData];
}

@end
