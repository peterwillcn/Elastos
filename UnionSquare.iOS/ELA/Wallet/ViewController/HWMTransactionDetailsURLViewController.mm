//
//  HWMTransactionDetailsURLViewController.m
//  elastos wallet
//
//  Created by  on 2019/2/15.
//

#import "HWMTransactionDetailsURLViewController.h"
#import <WebKit/WebKit.h>

@interface HWMTransactionDetailsURLViewController ()<WKUIDelegate>

@end

@implementation HWMTransactionDetailsURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"交易详情", nil);
    WKWebView *webWiew =[[WKWebView alloc]initWithFrame:self.view.frame];
    
    //xxl uiveiw
    //webWiew.delegate=self;
    webWiew.UIDelegate = self;
    
    webWiew.backgroundColor=[UIColor clearColor];
//    目前用的是这个url  https://blockchain-regtest.elastos.org/tx/91e295adeb572334f4c15bd2f3b743a9e56ac7488af09a0eb815e70e4ae3ad2d
//    https://blockchain.elastos.org/tx/56d5ec82443405f4629600187e37975322204dff9f86984df952fa310d5981b6
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",transUrl,self.urlString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.view addSubview:webWiew];
    
    [webWiew loadRequest:request];
    
}
- (void)didFinishNavigation:(WKWebView *)theWebView
{
    CGSize contentSize = theWebView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    theWebView.scrollView.minimumZoomScale = rw;
    theWebView.scrollView.maximumZoomScale = rw;
    theWebView.scrollView.zoomScale = rw;
    NSString *meta = [NSString stringWithFormat:@"var meta = document.createElement('meta');meta.content='width=device-width,initial-scale=1.0,minimum-scale=.5,maximum-scale=3';meta.name='viewport';document.getElementsByTagName('head')[0].appendChild(meta);"];
    
    //[theWebView stringByEvaluatingJavaScriptFromString:meta];
    [theWebView evaluateJavaScript:meta completionHandler:nil];
}


-(void)setUrlString:(NSString *)urlString{
    _urlString=urlString;
}
@end
