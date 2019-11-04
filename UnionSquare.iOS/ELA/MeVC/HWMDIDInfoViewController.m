//
//  HWMDIDInfoViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/30.
//

#import "HWMDIDInfoViewController.h"
#import "HWMDIDInfoTableViewCell.h"
#import "HWMTheEditorDIDInfoViewController.h"
#import "HWMConfidentialInformationViewController.h"


static NSString *cellString=@"HWMDIDInfoTableViewCell";
@interface HWMDIDInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *DIDInfoTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *theEditorButton;
@property (weak, nonatomic) IBOutlet UIButton *ConfidentialInformationButton;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation HWMDIDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
          [self setBackgroundImg:@""];
    [[HMWCommView share]makeBordersWithView:self.theEditorButton];
    [[HMWCommView share]makeBordersWithView:self.ConfidentialInformationButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"del_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(deleteDIDEvent)];
}
-(void)deleteDIDEvent{
    
}
- (IBAction)theEditorEvent:(id)sender {
    HWMTheEditorDIDInfoViewController *TheEditorDIDInfoVC=[[HWMTheEditorDIDInfoViewController alloc]init];
    [self.navigationController pushViewController:TheEditorDIDInfoVC animated:YES];
}
- (IBAction)ConfidentialInformationEvent:(id)sender {
    HWMConfidentialInformationViewController *ConfidentialInformationVC=[[HWMConfidentialInformationViewController alloc]init];
    [self.navigationController pushViewController:ConfidentialInformationVC animated:YES];
}
-(void)makeUI{
     [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
        
           self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
         self.table.rowHeight = 55;
           self.table.delegate =self;
           self.table.dataSource =self;
        self.table.backgroundColor=[UIColor clearColor];

        
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

@end
