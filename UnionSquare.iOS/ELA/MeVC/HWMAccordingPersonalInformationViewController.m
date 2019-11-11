//
//  HWMAccordingPersonalInformationViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/31.
//

#import "HWMAccordingPersonalInformationViewController.h"
#import "HWMDIDInfoTableViewCell.h"
static NSString *cellString=@"HWMDIDInfoTableViewCell";
@interface HWMAccordingPersonalInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation HWMAccordingPersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self defultWhite];
       [self setBackgroundImg:@""];
       self.title=NSLocalizedString(@"个人信息", nil);
    [self makeUI];
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
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // FLSugarModel *model = self.dataSouse[indexPath.row];
  HWMDIDInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
