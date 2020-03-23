//
//  HWMConfidentialInformationViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/31.
//

#import "HWMConfidentialInformationViewController.h"
#import "HWMDIDListAbnormalTableViewCell.h"
#import "HWMAccordingPersonalInformationViewController.h"
#import "HWMAddPersonalInformationViewController.h"
#import "HWMShowSocialAccountViewController.h"
#import "HWMshowIntroductionInfoViewController.h"
#import "HWMDIDManager.h"
#import "HWMDIDInfoModel.h"
#import "HWMHWMDIDShowInfoViewController.h"
#import "HWMTheImportDocumentsViewController.h"
static NSString *normalCellString=@"HWMDIDListAbnormalTableViewCell";
@interface HWMConfidentialInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
@property (weak, nonatomic) IBOutlet UIButton *TheImportButton;
//@property(strong,nonatomic)HWMDIDInfoModel *didModel;
@property(copy,nonatomic)NSArray *dataArray;
@property(assign,nonatomic)BOOL hasRead;
@end

@implementation HWMConfidentialInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"凭证信息", nil);
    [self.TheImportButton setTitle:NSLocalizedString(@"导入", nil) forState:UIControlStateNormal];
    [self.exportButton setTitle:NSLocalizedString(@"导出", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.TheImportButton];
    [[HMWCommView share]makeBordersWithView:self.exportButton];
    HWMDIDInfoModel *readModel=[[HWMDIDManager shareDIDManager]readDIDCredential];
    if ([readModel.did isEqualToString:self.model.did]) {
        self.hasRead=YES;
         self.model=readModel;
    }
   
    [self makeUI];
}
-(NSArray *)dataArray{
    if (!_dataArray) {
//        _dataArray =@[@"个人信息",@"个人简介",@"社交账号"];
                _dataArray =@[@"个人信息"];
    }
    return _dataArray;
}
-(void)makeUI{

    
  
    [self.table registerNib:[UINib nibWithNibName:normalCellString bundle:nil] forCellReuseIdentifier:normalCellString];
        [self.table registerNib:[UINib nibWithNibName:normalCellString bundle:nil] forCellReuseIdentifier:normalCellString];
       self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.table.rowHeight = 70;
       self.table.delegate =self;
       self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];

    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // FLSugarModel *model = self.dataSouse[indexPath.row];
   HWMDIDListAbnormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.model;
    cell.titleString=self.dataArray[indexPath.section];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return self.dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (self.hasRead) {
      HWMHWMDIDShowInfoViewController *HWMAddPersonalInformationVC=[[HWMHWMDIDShowInfoViewController alloc]init];
     //    HWMAddPersonalInformationVC.title=NSLocalizedString(@"编辑个人信息", nil);
       HWMAddPersonalInformationVC.model=self.model;
       [self.navigationController pushViewController:HWMAddPersonalInformationVC animated:YES];
    }else{
        HWMAddPersonalInformationViewController *PersonalInformationVC=[[HWMAddPersonalInformationViewController alloc]init];
        PersonalInformationVC.model=self.model;
        PersonalInformationVC.isEidet=YES;
        PersonalInformationVC.currentWallet=self.currentWallet;
        [self.navigationController pushViewController:PersonalInformationVC animated:YES];
        
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (IBAction)exportEvent:(id)sender {
    
}
- (IBAction)TheImportEvent:(id)sender {
    
    HWMTheImportDocumentsViewController *TheImportDocumentsVC=[[HWMTheImportDocumentsViewController alloc]init];
    TheImportDocumentsVC.currentWallet=self.currentWallet;
    [self.navigationController pushViewController:TheImportDocumentsVC animated:YES];
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}
@end
