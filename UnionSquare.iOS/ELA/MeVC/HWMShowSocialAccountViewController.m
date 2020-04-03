//
//  HWMShowSocialAccountViewController.m
//  elastos wallet
//
//  Created by  on 2019/11/8.
//

#import "HWMShowSocialAccountViewController.h"
#import "HWMAddSocialAccountViewController.h"
#import "HWMShowSocialAccountTableViewCell.h"

static NSString *cellString=@"HWMShowSocialAccountTableViewCell";
@interface HWMShowSocialAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(copy,nonatomic)NSArray *dataArray;


@end

@implementation HWMShowSocialAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=NSLocalizedString(@"社交账号", nil);
      [self defultWhite];
    [self setBackgroundImg:@""];
      [self makeUI];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(EditSocialAccount)];
}
-(void)makeUI{
    self.table.delegate=self;
    self.table.dataSource=self;
    [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
}

-(void)EditSocialAccount{
    HWMAddSocialAccountViewController *AddSocialAccountVC=[[HWMAddSocialAccountViewController alloc]init];
    [self.navigationController pushViewController:AddSocialAccountVC animated:YES];
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HWMShowSocialAccountTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
@end
