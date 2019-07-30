//
//  HWMVUpdateLogWebViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/1.
//

#import "HWMVUpdateLogWebViewController.h"
#import "DAConfig.h"
@interface HWMVUpdateLogWebViewController ()<UIWebViewDelegate>


@end

@implementation HWMVUpdateLogWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self blackBackImageDefultWhite];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.webView.delegate=self;
    NSString *languageString=[DAConfig userLanguage];
    if ([languageString containsString:@"zh"]) {
        languageString=@"ch";
    }
    NSString *urlString=[NSString stringWithFormat:@"https://download.elastos.org/app/release-notes/ela-wallet/index.html?langua=%@",languageString];
    NSURLRequest *reuURL=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:reuURL];
   
 
}
- (IBAction)backVC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    frame.size.height = height;
    [webView setFrame:frame];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}
@end
