//
//  HWMVUpdateLogWebViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/1.
//

#import "HWMVUpdateLogWebViewController.h"
#import "DAConfig.h"
@interface HWMVUpdateLogWebViewController ()<UIWebViewDelegate>

/*
 *<# #>
 */
@property(strong,nonatomic)UIWebView *webView ;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton *backButton;
@end

@implementation HWMVUpdateLogWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self blackBackImageDefultWhite];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
//    UIView *main=[self mainWindow];
    [self.view addSubview:self.webView];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    
        
    }];
    [self.webView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.webView.mas_left).offset(10);
    make.top.equalTo(self.webView.mas_top).offset(15);
    make.size.mas_equalTo(CGSizeMake(34, 62));
    }];
    NSString *languageString=[DAConfig userLanguage];
    if ([languageString containsString:@"zh"]) {
        languageString=@"ch";
    }
    NSString *urlString=[NSString stringWithFormat:@"https://download.elastos.org/app/release-notes/ela-wallet/index.html?langua=%@",languageString];
    NSURLRequest *reuURL=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:reuURL];
   
 
}
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton =[[UIButton alloc]init];
        [_backButton addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backButton;
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView =[[UIWebView alloc]initWithFrame:self.view.frame];
        _webView.backgroundColor=[UIColor clearColor];
        _webView.delegate=self;
        _webView.userInteractionEnabled=YES;
        
    }
    return   _webView;
}
- (void)backVC{
    
    [self.navigationController popViewControllerAnimated:YES];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
  
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{

//CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    CGRect frame =self.view.frame;
//    frame.size.height = height;
//    [webView setFrame:frame];

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}
@end
