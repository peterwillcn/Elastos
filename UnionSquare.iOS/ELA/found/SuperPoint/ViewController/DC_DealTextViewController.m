//
//  DC_DealTextViewController.m
//  DC_DFH5.0_iPhone
//
//  Created by hardyhe on 15-6-10.
//  Copyright (c) 2015年 Gaody. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "DC_DealTextViewController.h"

//xxl change for UIWebVew to WKWebView
@interface DC_DealTextViewController ()<WKUIDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)WKWebView *webView;
/*
 *<# #>
 */
@property(strong,nonatomic)UIScrollView *mainScrollView;

@end

@implementation DC_DealTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    [self setUpSubviews];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"协议";
    [self setBackgroundImg:@""];

    [self loadDataSource];
    // Do any additional setup after loading the view.
}
-(void)loadDataSource{
    NSURL *url = [NSURL URLWithString:self.html_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

-(WKWebView *)webView{
    if (!_webView) {
        
        _webView =[[WKWebView alloc]initWithFrame:self.view.frame];
        _webView.backgroundColor=[UIColor whiteColor];
        
        
//        _webView.delegate = self;
//        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
//        _webView.scalesPageToFit = YES;
        
        // UI代理
        _webView.UIDelegate = self;
        
        
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _webView;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self defultBack];


}

@end
