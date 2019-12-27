//
//  HWMConfidentialInformationViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/31.
//

#import "HWMConfidentialInformationViewController.h"
#import "HWMDIDListNormalTableViewCell.h"
static NSString *normalCellString=@"HWMDIDListNormalTableViewCell";
@interface HWMConfidentialInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
@property (weak, nonatomic) IBOutlet UIButton *TheImportButton;

@property(copy,nonatomic)NSArray *dataArray;
@end

@implementation HWMConfidentialInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"凭证信息", nil);
    [self.TheImportButton setTitle:NSLocalizedString(@"导入", nil) forState:UIControlStateNormal];
    [self.exportButton setTitle:NSLocalizedString(@"导出", nil) forState:UIControlStateNormal];
    
    
    [self makeUI];
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray =@[@"个人信息",@"个人简介",@"社交账号"];
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
    HWMDIDListNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (IBAction)exportEvent:(id)sender {
}
- (IBAction)TheImportEvent:(id)sender {
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}
@end
