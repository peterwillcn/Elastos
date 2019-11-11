//
//  HWMDIDListViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/28.
//

#import "HWMDIDListViewController.h"
#import "HWMDIDListAbnormalTableViewCell.h"
#import "HWMCreateDIDViewController.h"
#import "HWMDIDListNormalTableViewCell.h"
static NSString *AbnormalCellString=@"HWMDIDListAbnormalTableViewCell";
static NSString *normalCellString=@"HWMDIDListNormalTableViewCell";

@interface HWMDIDListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *HasBeenReleasedButton;
@property (weak, nonatomic) IBOutlet UIButton *theDraftButton;
@property (weak, nonatomic) IBOutlet UIView *HasBeenReleaseView;
@property (weak, nonatomic) IBOutlet UIView *theDraftView;
@property (weak, nonatomic) IBOutlet UITableView *table;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *releDIDdataSorse;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *theDraftDIDdataSorse;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isRel;

@end

@implementation HWMDIDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"DID", nil);
    self.isRel=YES;
    [self makeUI];
    [self.HasBeenReleasedButton setTitle:NSLocalizedString(@"已发布", nil) forState:UIControlStateNormal];
    [self.theDraftButton setTitle:NSLocalizedString(@"草稿", nil) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_did_add"] style:UIBarButtonItemStyleDone target:self action:@selector(creatDIDEvent)];
    [self selectHasBeenReleased];
}
-(void)makeUI{
    [self.table registerNib:[UINib nibWithNibName:normalCellString bundle:nil] forCellReuseIdentifier:normalCellString];
        [self.table registerNib:[UINib nibWithNibName:AbnormalCellString bundle:nil] forCellReuseIdentifier:AbnormalCellString];
       self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
       self.table.delegate =self;
       self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isRel) {
    HWMDIDListNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    }else{
    HWMDIDListAbnormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AbnormalCellString];
    cell.timeLeftConOff.constant=0;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    }
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isRel) {
        return 100 ;
      }else{
       return 70;
      }
}
-(void)creatDIDEvent{
    HWMCreateDIDViewController *CreateDIDVC=[[HWMCreateDIDViewController alloc]init];
    [self.navigationController pushViewController:CreateDIDVC animated:YES];
}
- (IBAction)HasBeenReleasedAndChangeTheDrafteEvent:(id)sender {
    if (sender==self.theDraftButton) {
        [self selectTheDraftView];
    }else if (sender==self.HasBeenReleasedButton){
        [self selectHasBeenReleased];
    }
}
-(void)selectHasBeenReleased{
        [self.HasBeenReleasedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.HasBeenReleaseView.alpha=1.f;
        [self.theDraftButton setTitleColor:RGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
    self.theDraftView.alpha=0.f;
    self.isRel=YES;
    [self.table reloadData];
}
-(void)selectTheDraftView{
      [self.HasBeenReleasedButton setTitleColor:RGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
    self.HasBeenReleaseView.alpha=0.f;
        [self.theDraftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theDraftView.alpha=1.f;
    self.isRel=NO;
    [self.table reloadData];
    
}
@end
