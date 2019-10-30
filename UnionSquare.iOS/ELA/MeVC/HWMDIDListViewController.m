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

@end

@implementation HWMDIDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
       [self setBackgroundImg:@""];
    self.title=@"DID";
    [self.HasBeenReleasedButton setTitle:NSLocalizedString(@"已发布", nil) forState:UIControlStateNormal];
    [self.HasBeenReleasedButton setTitle:NSLocalizedString(@"已发布", nil) forState:UIControlStateSelected];
    
    [self.HasBeenReleasedButton setTitleColor:RGB(83, 136, 136) forState:UIControlStateNormal];
    [self.HasBeenReleasedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.theDraftButton setTitle:NSLocalizedString(@"草稿", nil) forState:UIControlStateNormal];
    [self.theDraftButton setTitle:NSLocalizedString(@"草稿", nil) forState:UIControlStateSelected];
    [self.theDraftButton setTitleColor:RGB(83, 136, 136) forState:UIControlStateNormal];
    [self.theDraftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.title=NSLocalizedString(@"DID", nil);
    [self setHasBeenReleasedButton:self.HasBeenReleasedButton];

self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_did_add"] style:UIBarButtonItemStyleDone target:self action:@selector(creatDIDEvent)];
}
-(void)makeUI{

    
  
    [self.table registerNib:[UINib nibWithNibName:normalCellString bundle:nil] forCellReuseIdentifier:normalCellString];
        [self.table registerNib:[UINib nibWithNibName:AbnormalCellString bundle:nil] forCellReuseIdentifier:normalCellString];
       self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.table.rowHeight = 55;
       self.table.delegate =self;
       self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];

    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // FLSugarModel *model = self.dataSouse[indexPath.row];
   HWMDIDListAbnormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AbnormalCellString];
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

-(void)creatDIDEvent{
    HWMCreateDIDViewController *CreateDIDVC=[[HWMCreateDIDViewController alloc]init];
    [self.navigationController pushViewController:CreateDIDVC animated:YES];
}
- (IBAction)HasBeenReleasedAndChangeTheDrafteEvent:(id)sender {
    
    if (sender==self.theDraftButton) {
        if (self.theDraftButton.isSelected==NO) {
            self.HasBeenReleasedButton.selected=NO; self.theDraftButton.selected=YES;
            self.theDraftView.alpha=1.f;
            self.HasBeenReleaseView.alpha=0.f;
        }
        
    }else if (sender==self.HasBeenReleasedButton){
        if (self.HasBeenReleasedButton.isSelected==NO) {
            self.HasBeenReleasedButton.selected=YES; self.theDraftButton.selected=NO;
            self.theDraftView.alpha=0.f;
            self.HasBeenReleaseView.alpha=1.f;
            
        }
        
    }
    
}

@end
