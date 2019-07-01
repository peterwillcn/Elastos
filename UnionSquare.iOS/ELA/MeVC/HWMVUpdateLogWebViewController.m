//
//  HWMVUpdateLogWebViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/1.
//

#import "HWMVUpdateLogWebViewController.h"
#import "DAConfig.h"
@interface HWMVUpdateLogWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *WebView;

@end

@implementation HWMVUpdateLogWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self defultWhite];

    NSString *languageString=[DAConfig userLanguage];
    NSURLRequest *reuURL=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://download.elastos.org/app/release-notes/ela-wallet/index.html??langua=%@",languageString]]];
    [self.WebView loadRequest:reuURL];
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
