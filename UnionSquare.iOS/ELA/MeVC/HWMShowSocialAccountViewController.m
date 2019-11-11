//
//  HWMShowSocialAccountViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/11/8.
//

#import "HWMShowSocialAccountViewController.h"
#import "HWMAddSocialAccountViewController.h"

@interface HWMShowSocialAccountViewController ()

@end

@implementation HWMShowSocialAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=NSLocalizedString(@"社交账号", nil);
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(EditSocialAccount)];
}
-(void)EditSocialAccount{
    HWMAddSocialAccountViewController *AddSocialAccountVC=[[HWMAddSocialAccountViewController alloc]init];
    [self.navigationController pushViewController:AddSocialAccountVC animated:YES];
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
