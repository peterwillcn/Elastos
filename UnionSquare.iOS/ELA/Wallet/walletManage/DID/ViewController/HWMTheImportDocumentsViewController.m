//
//  HWMTheImportDocumentsViewController.m
//  elastos wallet
//
//  Created by  on 2020/2/14.
//

#import "HWMTheImportDocumentsViewController.h"

static NSString *cellString=@"";
@interface HWMTheImportDocumentsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UIButton*skipButton;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation HWMTheImportDocumentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
