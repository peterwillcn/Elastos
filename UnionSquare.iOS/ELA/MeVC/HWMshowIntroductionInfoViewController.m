//
//  HWMshowIntroductionInfoViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/11/8.
//

#import "HWMshowIntroductionInfoViewController.h"
#import "HWMAddPersonalProfileViewController.h"

@interface HWMshowIntroductionInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *IntroductionInfoTextView;

@end

@implementation HWMshowIntroductionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=NSLocalizedString(@"个人简介", nil);
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(EditProfile)];
    // Do any additional setup after loading the view from its nib.
}
-(void)EditProfile{
    HWMAddPersonalProfileViewController *AddPersonalProfileVC=[[HWMAddPersonalProfileViewController alloc]init];
    [self.navigationController pushViewController:AddPersonalProfileVC animated:YES];
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
