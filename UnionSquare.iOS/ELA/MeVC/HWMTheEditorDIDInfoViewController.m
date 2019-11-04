//
//  HWMTheEditorDIDInfoViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/31.
//

#import "HWMTheEditorDIDInfoViewController.h"

@interface HWMTheEditorDIDInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *DIDTextInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDataLabel;
@property (weak, nonatomic) IBOutlet UIButton *updatesButton;

@end

@implementation HWMTheEditorDIDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
            [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"编辑DID", nil);
    [self.updatesButton setTitle:NSLocalizedString(@"更新发布", nil) forState:UIControlStateNormal];
}
- (IBAction)changeTimeDataInfoEvent:(id)sender {
}
- (IBAction)updatesEvent:(id)sender {

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
