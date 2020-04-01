//
//  HWMAddPersonalInformationViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/25.
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
#import "HWMDIDManager.h"
#import "HMWSendSuccessPopuView.h"
#import "HMWpwdPopupView.h"
UINib *_cellCreateDIDListNib;
UINib *_cellCodeAndPhonenumberNib;
static NSString *cellString=@"HWMCreateDIDListTableViewCell";
static NSString *cellCodeAndPhonenumberString=@"HWMTheAreaCodeAndPhonenumberTableViewCell";

@interface HWMAddPersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource,HWMDIDDataListViewDelegate, HMWSelectCountriesOrRegionsViewControllerDelegate,HWMDIDInfoListViewDelegate,HWMCreateDIDListTableViewCellDelegate,UITextFieldDelegate,HWMTheAreaCodeAndPhonenumberTableViewCellDelegate,HMWpwdPopupViewDelegate>
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
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView*sendSuccessPopuV;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWpwdPopupView*pwdPopupV;

@end

@implementation HWMAddPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
    [self makeUI];
    if (self.isEidet||self.whereFrome) {
        self.title=NSLocalizedString(@"编辑个人信息", nil);
        self.textInfoLabel.alpha=0.f;
        self.infoHeight.constant=0.f;
        [self.skipButton setTitle:NSLocalizedString(@"保存", nil) forState: UIControlStateNormal];
        [self updaeDataArray];
    }else{
        self.title=NSLocalizedString(@"添加个人信息", nil);
        
    }
}
-(void)updaeDataArray{
    [self.defMArray removeAllObjects];
    [self.showInfoListAarry removeAllObjects];
    NSString *indexString;
    if (self.model.nickname.length>0) {
        indexString=self.allInfoListArray[0][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"0"];
    }
    if (self.model.gender.length>0) {
        indexString=self.allInfoListArray[1][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"1"];
    }
    if (self.model.birthday.length>0) {
        indexString=self.allInfoListArray[2][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"2"];
    }
    if (self.model.avatar.length>0) {
        indexString=self.allInfoListArray[3][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"3"];
    }
    if (self.model.email.length>0) {
        indexString=self.allInfoListArray[4][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"4"];
    }
    if (self.model.phone.length>0) {
        indexString=self.allInfoListArray[5][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"4"];
    }
    if (self.model.nation.length>0) {
        indexString=self.allInfoListArray[6][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"6"];
    }
    if (self.model.introduction.length>0) {
        indexString=self.allInfoListArray[7][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"7"];
    }
    if (self.model.homePage.length>0) {
        indexString=self.allInfoListArray[8][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"8"];
    }
    if (self.model.facebook.length>0) {
        indexString=self.allInfoListArray[9][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"9"];
    }
    if (self.model.twitter.length>0) {
        indexString=self.allInfoListArray[10][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"10"];
    }
    if (self.model.weibo.length>0) {
        indexString=self.allInfoListArray[11][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"11"];
    }
    if (self.model.wechat.length>0) {
        indexString=self.allInfoListArray[12][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"12"];
    }
    if (self.model.googleAccount.length>0) {
        indexString=self.allInfoListArray[13][@"index"];
        [self.defMArray addObject:indexString];
    }else{
        [self.showInfoListAarry addObject:@"13"];
    }
    
    [self.table reloadData];
}




-(NSMutableArray *)defMArray{
    if (!_defMArray) {
        _defMArray=[NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"7",@"8",@"9",@"12"]];
    }
    return _defMArray;
}
-(NSMutableArray *)showInfoListAarry{
    if (!_showInfoListAarry) {
        _showInfoListAarry=[NSMutableArray arrayWithArray:@[@"0",@"5",@"6",@"10",@"11",@"13"]];
    }
    return _showInfoListAarry;
}
-(HWMDIDInfoListView *)showAllInfoView{
    if (!_showAllInfoView) {
        _showAllInfoView=[[HWMDIDInfoListView alloc]init];
        _showAllInfoView.delegate=self;
    }
    return _showAllInfoView;
}
-(NSArray *)allInfoListArray{
    if (!_allInfoListArray) {
        _allInfoListArray
        =@[@{@"text":NSLocalizedString(@"昵称", nil),@"index":@"0",@"type":@"1"},@{@"text":NSLocalizedString(@"性别",nil),@"index":@"1",@"type":@"2"},@{@"text":NSLocalizedString(@"出生日期",nil),@"index":@"2",@"type":@"2"},@{@"text":NSLocalizedString(@"头像地址",nil),@"index":@"3",@"type":@"1"},@{@"text":NSLocalizedString(@"邮箱",nil),@"index":@"4",@"type":@"1"},@{@"text":NSLocalizedString(@"手机号", nil) ,@"index":@"5",@"type":@"3"},@{@"text":NSLocalizedString(@"国家/地区", nil),@"index":@"6",@"type":@"2"},@{@"text":NSLocalizedString(@"个人简介",nil),@"index":@"7",@"type":@"4"},@{@"text":NSLocalizedString(@"个人主页",nil),@"index":@"8",@"type":@"1"},@{@"text":NSLocalizedString(@"Facebook账号",nil),@"index":@"9",@"type":@"1"},@{@"text":NSLocalizedString(@"Twitter账号",nil),@"index":@"10",@"type":@"1"},@{@"text":NSLocalizedString(@"微博账号",nul),@"index":@"11",@"type":@"1"},@{@"text":NSLocalizedString(@"微信账号",null),@"index":@"12",@"type":@"1"},@{@"text":NSLocalizedString(@"Google账号",null),@"index":@"13",@"type":@"1"}];
    }
    return _allInfoListArray;
    
}
-(void)makeUI{
    [[HMWCommView share]makeBordersWithView:self.nextButton];
    
    _cellCreateDIDListNib=[UINib nibWithNibName:cellString bundle:nil];
    _cellCodeAndPhonenumberNib=[UINib nibWithNibName:cellCodeAndPhonenumberString bundle:nil];
    [self.table registerNib:_cellCreateDIDListNib forCellReuseIdentifier:cellString];
    [self.table registerNib:_cellCodeAndPhonenumberNib forCellReuseIdentifier:cellCodeAndPhonenumberString];
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
    [self.view endEditing:YES];
    UIView *manView=[self mainWindow];
    [manView addSubview:self.pwdPopupV];
    [self.pwdPopupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexString=self.defMArray[indexPath.row];
    NSDictionary *infDic=self.allInfoListArray[[indexString integerValue]];
    NSString *titleString=infDic[@"text"];
    NSString *typeString=infDic[@"type"];
    if([typeString isEqualToString:@"3"]) {
        HWMTheAreaCodeAndPhonenumberTableViewCell *cell=[_cellCodeAndPhonenumberNib instantiateWithOwner:nil options:nil][0]; cell.MobilePhoneTextField.placeholder=NSLocalizedString(@"请输入手机号", nil);
        cell.MobilePhoneTextField.text=self.model.phone;
        cell.MobilePhoneTextField.tag=10001;
        cell.dic=infDic;
        cell.delegate=self;
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.MobilePhoneTextField withTxt:NSLocalizedString(@"请输入手机号", nil)];
        cell.theArNumberTextField.placeholder=NSLocalizedString(@"请输入区号", nil);
        cell.theArNumberTextField.tag=10002;
        if (self.model.phoneCode.length>0) {
            cell.theArNumberTextField.text=self.model.phoneCode;
        }
        cell.theArNumberTextField.delegate=self;
        cell.MobilePhoneTextField.delegate=self;
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField: cell.theArNumberTextField withTxt:NSLocalizedString(@"请输入区号", nil)];
        return cell;}
    HWMCreateDIDListTableViewCell *cell =
    [_cellCreateDIDListNib instantiateWithOwner:nil options:nil][0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.arrowImageView.alpha=1.f;
    cell.index=indexString;
    cell.delegate=self;
    if ([typeString isEqualToString:@"2"]) {
        cell.infoLabel.alpha=1.f;
        cell.infoLabel.text=[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"请选择", nil),titleString];
        cell.intPutTextField.alpha=0.f;
        if ([indexString integerValue]==1&&self.model.gender.length>0) {
            cell.infoLabel.text=[[FLTools share]genderStringWithType:self.model.gender];
        }else if ([indexString integerValue]==2&&self.model.birthday.length>0){
            cell.infoLabel.text=[[FLTools share]TimeFormatConversionBirthday: self.model.birthday];
        }else if ([indexString integerValue]==6&&self.model.nation.length>0){
            cell.infoLabel.text=[[FLTools share]contryNameTransLateByCode:[self.model.nation integerValue]];
        }
        
    }else if([typeString isEqualToString:@"4"]){
        cell.infoLabel.alpha=1.f;
        cell.infoLabel.text=[NSString stringWithFormat:@"%@",titleString];
        cell.intPutTextField.alpha=0.f;
//        if (self.model.introduction.length>0) {
            cell.LimitThatLabel.alpha=1.f;
            cell.LimitThatLabel.text=NSLocalizedString(@"  正文内容限制字符…  ", nil);
//        }else{
//            cell.LimitThatLabel.alpha=0.f;
//        }
        
    }else if([typeString isEqualToString:@"1"]){
        cell.infoLabel.alpha=0.f;
        cell.intPutTextField.alpha=1.f;
        NSString *placeString=[NSString stringWithFormat:@"%@%@",NSLocalizedString(@"请输入", nil),titleString];
        cell.intPutTextField.placeholder=placeString;
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.intPutTextField withTxt:placeString];
        cell.intPutTextField.tag=100+[indexString integerValue];
        cell.intPutTextField.delegate=self;
        if ([titleString isEqualToString:NSLocalizedString(@"邮箱", nil)]) {
            if (self.model.email.length>0) {
                cell.intPutTextField.text=self.model.email;
            }
            
        }else if ([titleString isEqualToString:NSLocalizedString(@"个人主页", nil)]) {
            if (self.model.homePage.length>0) {
                cell.intPutTextField.text=self.model.homePage;
            }
            
        }else if ([titleString isEqualToString:NSLocalizedString(@"Facebook账号", nil)]) {
            if (self.model.facebook.length>0) {
                cell.intPutTextField.text=self.model.facebook;
            }
            
        }else if([titleString isEqualToString:NSLocalizedString(@"昵称", nil)]){
            if (self.model.nickname.length>0) {
                cell.intPutTextField.text=self.model.nickname;
            }
        }else if ([titleString isEqualToString:NSLocalizedString(@"头像地址", nil)]){
            if (self.model.avatar.length>0) {
                cell.intPutTextField.text=self.model.avatar;
            }
        }else if ([titleString isEqualToString:NSLocalizedString(@"Twitter账号", nil)]){
            if (self.model.twitter.length>0) {
                cell.intPutTextField.text=self.model.twitter;
            }
        }else if ([titleString isEqualToString:NSLocalizedString(@"微博账号", nil)]){
            if (self.model.weibo.length>0) {
                cell.intPutTextField.text=self.model.weibo;
            }
            
        }else if ([titleString isEqualToString:NSLocalizedString(@"Google账号", nil)]){
            if (self.model.googleAccount.length>0) {
                cell.intPutTextField.text=self.model.googleAccount;
                
            }
            
        }
        
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
    [self.view endEditing:YES];
    
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
    }else if ([indeString isEqualToString:@"7"]){
        HWMAddPersonalProfileViewController *AddPersonalProfileVC=[[HWMAddPersonalProfileViewController alloc]init];
        AddPersonalProfileVC.model=self.model;
        AddPersonalProfileVC.isEidet=NO;
        __weak __typeof__ (self) weakSelf = self;
        AddPersonalProfileVC.block = ^(HWMDIDInfoModel * _Nonnull model) {
            weakSelf.model=model;
        };
        [self.navigationController pushViewController:AddPersonalProfileVC animated:YES];
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (IBAction)nextAndSkipEvent:(id)sender {
    NSMutableArray  *nextArr=[[NSMutableArray alloc]init];
    self.showInfoListAarry=[self bubblingSort:self.showInfoListAarry];
    
    
    for (NSString *index in self.showInfoListAarry) {
        [nextArr addObject:self.allInfoListArray[[index intValue]]];
    }
    
    UIView *mainView =[self mainWindow];
    self.showAllInfoView.dataSourceArray=nextArr;
    [mainView addSubview:self.showAllInfoView];
    [self.showAllInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(mainView);
    }];
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
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
    self.model.gender=[NSString stringWithFormat:@"%lu",((unsigned long)genderType+1)];
    [self.table reloadData];
    [self cancelDataListView];
}
-(void)selectDataWithYY:(NSString *)yy withMM:(NSString *)mm wihMMWithInt:(NSInteger)mInt wtihDD:(NSString *)dd{
    self.model.birthday=[[FLTools share]timeSwitchTimestamp:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",yy,mm,dd]];
    [self.table reloadData];
    [self cancelDataListView];
}
-(void)selectTheCountryAreasModel:(NSDictionary*)modelDic{
    
    self.model.nation= modelDic[@"mobileCode"];
    
    [self.table reloadData];
    
    
}
-(void)setIsEidet:(Boolean)isEidet{
    _isEidet=isEidet;
}
-(void)addInfoWithIndex:(NSString *)index{
    NSString *indeString=[NSString stringWithFormat:@"%@",index];
    if (![self.defMArray containsObject:indeString]) {
        [self.defMArray addObject:indeString];
    }
    
    
    
    [self.showInfoListAarry removeObject:indeString];
}
- (void)closeView{
    [self.showAllInfoView removeFromSuperview];
    self.defMArray=[self bubblingSort:self.defMArray];
    [self.table reloadData];
}
-(void)deleteWithIndex:(NSString*_Nullable)index{
    NSString *indeString=[NSString stringWithFormat:@"%@",index];
    if ([self.defMArray containsObject:indeString]) {
        [self.defMArray removeObject:indeString];
    }
    if (![self.showInfoListAarry containsObject:indeString]) {
        [self.showInfoListAarry addObject:indeString];
    }
    switch ([index intValue]) {
        case 0://"昵称"
            self.model.nickname=@"";
            break;
        case 1:
            self.model.gender=@"";
            break;
        case 2:
            self.model.birthday=@"";
            break;
        case 3:
            self.model.avatar=@"";
            break;
        case 4:
            self.model.email=@"";
            break;
        case 5:
            self.model.phoneCode=@"";
            self.model.phone=@"";
            break;
        case 6:
            self.model.nation=@"";
            break;
        case 7:
            self.model.introduction=@"";
            break;
        case 8:
            self.model.homePage=@"";
            break;
        case 9:
            self.model.facebook=@"";
            break;
        case 10:
            self.model.twitter=@"";
            break;
        case 11:
            self.model.weibo=@"";
            break;
        case 12:
            self.model.wechat=@"";
            break;
        case 13:
            self.model.googleAccount=@"";
            break;
        default:
            break;
    }
    
    
    
    [self.table reloadData];
}
-(void)delegateViewWithDic:(NSDictionary *)dic{
    if ([self.defMArray containsObject:@"5"]) {
        [self.defMArray removeObject:@"5"];
    }
    if (![self.showInfoListAarry containsObject:@"5"]) {
        [self.showInfoListAarry addObject:@"5"];
    }
    self.model.phone=@"";
    self.model.phoneCode=@"";
    [self.table reloadData];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger tag=textField.tag;
    switch (tag) {
        case 100://"昵称"
            self.model.nickname=textField.text;
            break;
        case 103:
            self.model.avatar=textField.text;
            break;
        case 104:
            self.model.email=textField.text;
            break;
        case 108:
            self.model.homePage=textField.text;
            break;
        case 109:
            self.model.facebook=textField.text;
            break;
        case 110:
            self.model.twitter=textField.text;
            break;
        case 111:
            self.model.weibo=textField.text;
            break;
        case 112:
            self.model.wechat=textField.text;
            break;
        case 113:
            self.model.googleAccount=textField.text;
            break;
        case 10001:
            self.model.phone=textField.text;
            break;
        case 10002:
            self.model.phoneCode=textField.text;
            break;
        default:
            break;
    }
    
}
- (NSMutableArray*)bubblingSort:(NSMutableArray *)sourceArr{
    
    for (int i = 0; i < sourceArr.count - 1; i++) {
        for (int j = 0; j < sourceArr.count - i - 1; j++) {
            if ([sourceArr[j] intValue] > [sourceArr[j + 1] intValue]) {
                [self swap:sourceArr numI:j numJ:j + 1];
            }
        }
    }
    return sourceArr;
}
- (void)swap:(NSMutableArray *)sourceArr numI:(int)i numJ:(int)j{
    NSNumber *temp;
    temp = sourceArr[i];
    sourceArr[i] = sourceArr[j];
    sourceArr[j] = temp;
}

-(void)showSendSuccessViewWithType:(NSInteger)type{
    self.sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    switch (type) {
        case 0:
        {
            self.sendSuccessPopuV.type=sendDealType;
            break;
            
        }
        case 1:{
            self.sendSuccessPopuV.type=saveSuccessType;
            break;
        }
            
        default:
            break;
    }
    
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV=nil;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}
-(void)makeSureWithPWD:(NSString*)pwd{
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,pwd] callbackId:self.currentWallet.masterWalletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
    NSString *  privatekeyString=[[ELWalletManager share]ExportxPrivateKey:mommand];
    if (privatekeyString.length==0) {
        return;
    }
    NSString *didString=[[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.model.did WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID];
    if (didString.length==0) {
        return;
    }
    self.currentWallet.didString=didString;
    if (self.isEidet) {
        BOOL isSucess=[[HWMDIDManager shareDIDManager ]saveDIDCredentialWithDIDModel: self.model];
        if (isSucess) {
            [self hiddenPWDView];
            [self showSendSuccessViewWithType:1];
        }else{
            [[FLTools share]showErrorInfo:@"保存失败"];
        }
    }else{
        BOOL isSucess=[[HWMDIDManager shareDIDManager ]updateInfoWithInfo: self.model];
        [[HWMDIDManager shareDIDManager ]saveDIDCredentialWithDIDModel: self.model];
        if (isSucess) {
            [self hiddenPWDView];
            [self showSendSuccessViewWithType:0];
            FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
            model.walletID=self.currentWallet.masterWalletID;
            model.walletName=self.currentWallet.walletName;
            model.walletAddress=self.currentWallet.walletAddress;
            model.didString=self.currentWallet.didString;
            [[HMWFMDBManager sharedManagerType:walletType]updateRecordWallet:model];
            __weak __typeof__ (self) weakSelf = self;
            if (self.successBlock) {
                weakSelf.successBlock(self.currentWallet.didString);
                [weakSelf.navigationController popViewControllerAnimated:NO];
            }
        }else{
            [[FLTools share]showErrorInfo:@"发布失败"];
        }
    }
    
    
    
}
-(HMWpwdPopupView *)pwdPopupV{
    if (!_pwdPopupV) {
        _pwdPopupV=[[HMWpwdPopupView alloc]init];
        _pwdPopupV.delegate=self;
    }
    return _pwdPopupV;
}
-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    
}
-(void)hiddenSendSuccessPopuV{
    [self.sendSuccessPopuV removeFromSuperview];
    self.sendSuccessPopuV=nil;
    
    
}
-(void)hiddenPWDView{
    [self.pwdPopupV removeFromSuperview];
    self.pwdPopupV=nil;
    
    
}
-(void)cancelThePWDPageView{
    [self hiddenPWDView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
}
@end
