//
//  HWMHWMDIDShowInfoViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2020/2/14.
//

#import "HWMHWMDIDShowInfoViewController.h"
#import "HWMDIDInfoShowTableViewCell.h"
#import "HWMAddPersonalInformationViewController.h"
static NSString *cellString =@"HWMDIDInfoShowTableViewCell";
@interface HWMHWMDIDShowInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property(strong,nonatomic)UIButton *skipButton;
@end

@implementation HWMHWMDIDShowInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"个人信息",nil);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
    [self makeUI];
}
-(void)makeUI{
//    [[HMWCommView share]makeBordersWithView:self.nextButton];
    [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.rowHeight = 55;
    self.table.delegate =self;
    self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
}
-(UIButton *)skipButton{
    if (!_skipButton) {
        _skipButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//        [_skipButton setTitle:NSLocalizedString(@"发布", nil) forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_skipButton addTarget:self action:@selector(skipVCEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}
-(void)skipVCEvent{
    HWMAddPersonalInformationViewController *HWMAddPersonalInformationVC=[[HWMAddPersonalInformationViewController alloc]init];
    HWMAddPersonalInformationVC.isEidet=YES;
    [self.navigationController pushViewController:HWMAddPersonalInformationVC animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWMDIDInfoShowTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
@end
