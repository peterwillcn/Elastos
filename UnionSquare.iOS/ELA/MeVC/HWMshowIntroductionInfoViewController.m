//
//  HWMshowIntroductionInfoViewController.m
//  elastos wallet
//
//  Created by  on 2019/11/8.
//

#import "HWMshowIntroductionInfoViewController.h"
#import "HWMAddPersonalProfileViewController.h"

@interface HWMshowIntroductionInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *IntroductionInfoTextView;

@end

@implementation HWMshowIntroductionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
        [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"个人简介", nil);
    self.IntroductionInfoTextView.text=self.model.introduction;
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(EditProfile)];
    // Do any additional setup after loading the view from its nib.
}
-(void)EditProfile{
    HWMAddPersonalProfileViewController *HWMAddPersonalProfileVC=[[HWMAddPersonalProfileViewController alloc]init];
              HWMAddPersonalProfileVC.model=self.model;
              HWMAddPersonalProfileVC.isEidet=YES;
    HWMAddPersonalProfileVC.walletID=self.walletID;
              [self.navigationController pushViewController:HWMAddPersonalProfileVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}

@end
