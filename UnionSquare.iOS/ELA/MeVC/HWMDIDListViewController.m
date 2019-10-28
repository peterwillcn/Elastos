//
//  HWMDIDListViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/28.
//

#import "HWMDIDListViewController.h"

@interface HWMDIDListViewController ()
@property (weak, nonatomic) IBOutlet UIButton *HasBeenReleasedButton;
@property (weak, nonatomic) IBOutlet UIButton *theDraftButton;
@property (weak, nonatomic) IBOutlet UIView *HasBeenReleaseView;
@property (weak, nonatomic) IBOutlet UIView *theDraftView;

@end

@implementation HWMDIDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
       [self setBackgroundImg:@""];
       
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
