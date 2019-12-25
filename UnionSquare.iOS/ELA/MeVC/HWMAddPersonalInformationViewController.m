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

static NSString *cellString=@"HWMCreateDIDListTableViewCell";
static NSString *cellCodeAndPhonenumberString=@"HWMTheAreaCodeAndPhonenumberTableViewCell";

@interface HWMAddPersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource,HWMDIDDataListViewDelegate, HMWSelectCountriesOrRegionsViewControllerDelegate>
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

@end

@implementation HWMAddPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"添加个人信息", nil);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
    [self makeUI];
}
-(void)makeUI{
    self.dataSorse =@[NSLocalizedString(@"请输入姓名", nil),NSLocalizedString(@"请输入昵称", nil),NSLocalizedString(@"请选择性别", nil),NSLocalizedString(@"请选择出生日期",nil),
           NSLocalizedString(@"请输入头像url", nil),NSLocalizedString(@"请输入邮箱",nil),@[NSLocalizedString(@"请输入区号（如 86）",nil),NSLocalizedString(@"请输入手机号码",nil)],
           NSLocalizedString(@"请选择国家/地区", nil)];
    [self.nextButton setTitle:NSLocalizedString(@"下一步", nil) forState: UIControlStateNormal];
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
        [_skipButton setTitle:NSLocalizedString(@"跳过", nil) forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_skipButton addTarget:self action:@selector(skipVCEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}
-(void)skipVCEvent{
    HWMAddPersonalProfileViewController *AddPersonalProfileVC=[[HWMAddPersonalProfileViewController alloc]init];
    AddPersonalProfileVC.model=self.model;
    [self.navigationController pushViewController:AddPersonalProfileVC animated:YES];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==6) {
        HWMTheAreaCodeAndPhonenumberTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellCodeAndPhonenumberString];
        NSArray *arrCN=self.dataSorse[indexPath.row];
        cell.MobilePhoneTextField.placeholder=arrCN.lastObject;
        if (self.model.MobilePhoneNoString.length>0) {
            cell.MobilePhoneTextField.text=self.model.MobilePhoneNoString;
        }
        cell.MobilePhoneTextField.tag=10001;
                  [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.MobilePhoneTextField withTxt:arrCN.lastObject];
        cell.theArNumberTextField.placeholder=arrCN.firstObject;
        cell.theArNumberTextField.tag=10002;
        if (self.model.areMobilePhoneNoString.length>0) {
            cell.theArNumberTextField.text=self.model.areMobilePhoneNoString;
        }
        [cell.theArNumberTextField addTarget:self action:@selector(theArNumberChanged:) forControlEvents:UIControlEventValueChanged];
        [cell.MobilePhoneTextField addTarget:self action:@selector(MobilePhoneChanged:) forControlEvents:UIControlEventValueChanged];
         [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField: cell.theArNumberTextField withTxt:arrCN.firstObject];
        return cell;
    }
    HWMCreateDIDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *textString=self.dataSorse[indexPath.row];
    switch (indexPath.row) {
        case 2:{
            cell.arrowImageView.alpha=1.f;
            cell.intPutTextField.enabled=NO;
            if (self.model.genderString.length>0) {
                cell.intPutTextField.text= [[FLTools share]genderStringWithType:self.model.genderString];
            }else{
                 cell.intPutTextField.text=textString;
            }
            break;}
        case 3:{
            cell.arrowImageView.alpha=1.f;
            cell.intPutTextField.enabled=NO;
            if (self.model.DateBirthString.length>0) {
                 cell.intPutTextField.text= self.model.DateBirthString;
            }else{
                 cell.intPutTextField.text=textString;
            }
            break;
            
        }
            case 7:{
            cell.arrowImageView.alpha=1.f;
            if (self.model.countriesString.length>0) {
               cell.intPutTextField.text=[[FLTools share]contryNameTransLateByCode:[self.model.countriesString integerValue]];
            }else{
               cell.intPutTextField.text=textString;
            }
               cell.intPutTextField.enabled=NO;
            break;
            
        }
        default:
            cell.arrowImageView.alpha=0.f;
            cell.intPutTextField.placeholder=textString;
            [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.intPutTextField withTxt:textString];
            break;
    }
    cell.intPutTextField.tag=indexPath.row+100;
    [cell.intPutTextField addTarget:self action:@selector(intPutValueChanged:) forControlEvents:UIControlEventValueChanged];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSorse.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==2) {//性别
        self.DIDDataListV.ListViewType=genderType;
        UIView *mainView = [self mainWindow];
        [mainView addSubview:self.DIDDataListV];
        [self.DIDDataListV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }else if (indexPath.row==3){//出生
        self.DIDDataListV.ListViewType=birthdayType;
               UIView *mainView = [self mainWindow];
               [mainView addSubview:self.DIDDataListV];
               [self.DIDDataListV mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.right.top.bottom.equalTo(mainView);
               }];
    }else if (indexPath.row==7){
        HMWSelectCountriesOrRegionsViewController *SelectCountriesOrRegionsVC=[[HMWSelectCountriesOrRegionsViewController alloc]init];
        SelectCountriesOrRegionsVC.delegate=self;
        [self.navigationController pushViewController:SelectCountriesOrRegionsVC animated:YES];
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
- (IBAction)nextAndSkipEvent:(id)sender {
    [self skipVCEvent];
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

@end
