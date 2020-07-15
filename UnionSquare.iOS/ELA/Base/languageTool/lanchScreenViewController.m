//
//  lanchScreenViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/2/22.
//

#import "lanchScreenViewController.h"

@interface lanchScreenViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lanchScreenImageView;

@end

@implementation lanchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lanchScreenImageView.image=[UIImage imageNamed:@"640_960"];
    // Do any additional setup after loading the view.
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
