//
//  HWMAccordingPersonalInformationViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/31.
//

#import "HWMAccordingPersonalInformationViewController.h"
#import "HWMDIDInfoTableViewCell.h"
#import "HWMAddPersonalInformationViewController.h"
static NSString *cellString=@"HWMDIDInfoTableViewCell";
@interface HWMAccordingPersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(copy,nonatomic)NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;


@end

@implementation HWMAccordingPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self defultWhite];
       [self setBackgroundImg:@""];
       self.title=NSLocalizedString(@"个人信息", nil);
  self.dataSource =@[NSLocalizedString(@"姓名", @""),NSLocalizedString(@"昵称", @""),NSLocalizedString(@"性别", @""),NSLocalizedString(@"出生日期", @""),NSLocalizedString(@"邮箱", @""),NSLocalizedString(@"手机号", @""),NSLocalizedString(@"国家/地区", @"")];
    [self makeUI];
    if (self.model.iconUrlString.length>0) {
        [self.IconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.iconUrlString]placeholderImage:[UIImage imageNamed:@"mine_did_default_avator"]];
    }
    [self.table reloadData];

}
-(void)makeUI{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(EditPersonalInformation)];
 [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    
       self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.table.rowHeight = 55;
       self.table.delegate =self;
       self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
    
}

-(void)EditPersonalInformation{
    HWMAddPersonalInformationViewController *HWMAddPersonalInformationVC=[[HWMAddPersonalInformationViewController alloc]init];
//    HWMAddPersonalInformationVC.title=NSLocalizedString(@"编辑个人信息", nil);
    HWMAddPersonalInformationVC.isEidet=YES;
    HWMAddPersonalInformationVC.model=self.model;
    [self.navigationController pushViewController:HWMAddPersonalInformationVC animated:YES];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // FLSugarModel *model = self.dataSouse[indexPath.row];
  HWMDIDInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.leftTextLabel.text=self.dataSource[indexPath.row];
    cell.arrImageView.alpha=0.f;
    switch (indexPath.row) {
        case 0:
        {
            if (self.model.nameString.length>0) {
                cell.infoLabel.text=self.model.nameString;
            }
        }
        break;
        case 1:
               {
                   if (self.model.nickNameString.length>0) {
                       cell.infoLabel.text=self.model.nickNameString;
                   }
               }
                   break;
            case 2:
               {
                   if (self.model.genderString.length>0) {
                       cell.infoLabel.text=[[FLTools share]genderStringWithType:self.model.genderString];
                   }
               }
                   break;
            case 3:
               {
                   if (self.model.DateBirthString.length>0) {
//                       cell.infoLabel.text=[FLTools share]YMDCommunityTimeConversToAllFromTimesTamp:<#(NSString *)#>
                   }
               }
                   break;
            case 4:
               {
                   if (self.model.emailString.length>0) {
                       cell.infoLabel.text=self.model.emailString;
                   }
               }
                   break;
            case 5:
               {
                   if (self.model.MobilePhoneNoString.length>0) {
                       cell.infoLabel.text=[NSString stringWithFormat:@"+%@ %@",self.model.areMobilePhoneNoString,self.model.MobilePhoneNoString];
                   }
               }
                   break;
            case 6:
               {
                   if (self.model.countriesString.length>0) {
                       cell.infoLabel.text=[[FLTools share]contryNameTransLateByCode:[self.model.countriesString intValue]];
                   }
               }
                   break;
            
        default:
            break;
    }
    return cell;
}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
    
}

@end
