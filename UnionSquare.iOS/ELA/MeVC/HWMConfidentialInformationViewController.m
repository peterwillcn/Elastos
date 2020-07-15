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
#import "HWExportCertificateMViewController.h"
static NSString *normalCellString=@"HWMDIDListAbnormalTableViewCell";
@interface HWMConfidentialInformationViewController ()<UITableViewDelegate,UITableViewDataSource,    HWMTheImportDocumentsViewControllerDelegate>
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
    [self makeUI];
}
-(NSArray *)dataArray{
    if (!_dataArray) {
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
    HWMDIDListAbnormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.hasSave=self.hasRead;
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
        HWMAddPersonalInformationVC.currentWallet=self.currentWallet;
        HWMAddPersonalInformationVC.model=[[HWMDIDManager shareDIDManager]readDIDCredential];
        [self.navigationController pushViewController:HWMAddPersonalInformationVC animated:YES];
    }else{
        HWMAddPersonalInformationViewController *PersonalInformationVC=[[HWMAddPersonalInformationViewController alloc]init];
        PersonalInformationVC.model=self.model;
        PersonalInformationVC.whereFrome=YES;
        PersonalInformationVC.noAleart=YES;
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
    if (self.hasRead) {
        HWExportCertificateMViewController *WExportCertificateMVC=[[HWExportCertificateMViewController alloc]init];
        WExportCertificateMVC.currentWallet=self.currentWallet;
        WExportCertificateMVC.model=self.model;
        [self.navigationController pushViewController:WExportCertificateMVC animated:YES];
    }else{
        [[FLTools share]showErrorInfo:@"暂无"];
        
    }
}
- (IBAction)TheImportEvent:(id)sender {
    HWMTheImportDocumentsViewController *TheImportDocumentsVC=[[HWMTheImportDocumentsViewController alloc]init];
    TheImportDocumentsVC.currentWallet=self.currentWallet;
    TheImportDocumentsVC.delegate=self;
    [self.navigationController pushViewController:TheImportDocumentsVC animated:YES];
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}
-(void)needUpLoadDataSource{
    HWMDIDInfoModel *readModel=[[HWMDIDManager shareDIDManager]readDIDCredential];
    
    if ([readModel.did isEqualToString:self.model.did]) {
        self.hasRead=YES;
        self.model=readModel;
        if ([self needSave]) {
            self.hasRead=YES;
        }else{
            self.hasRead=NO;
        }
    }else{
        self.hasRead=NO;
    }
    [self.table reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self needUpLoadDataSource];
}
-(BOOL)needSave{
    if(self.model.nickname.length>0||self.model.gender.length>0||self.model.avatar.length>0||self.model.email.length>0||self.model.phone.length>0||self.model.phoneCode.length>0||self.model.nation.length>0||self.model.introduction.length>0||self.model.homePage.length>0||self.model.wechat.length>0||self.model.twitter.length>0||self.model.weibo.length>0||self.model.facebook.length>0||self.model.googleAccount.length>0||self.model.birthday.length>0) {
        return YES;
    }
    return NO;
}
@end
