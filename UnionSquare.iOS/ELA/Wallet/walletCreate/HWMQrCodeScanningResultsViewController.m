//
//  HWMQrCodeScanningResultsViewController.m
//  elastos wallet
//
//  Created by  on 2019/8/26.
//

#import "HWMQrCodeScanningResultsViewController.h"

@interface HWMQrCodeScanningResultsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *CopyTheResultButton;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@end

@implementation HWMQrCodeScanningResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"扫描结果", nil);
    if (self.resultString) {
        self.resultTextView.text=self.resultString;
    }
    [[HMWCommView share]makeBordersWithView:self.resultTextView];
    [[HMWCommView share]makeBordersWithView:self.CopyTheResultButton];
}
- (IBAction)CopyTheResultEvent:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.resultTextView.text;
    [[FLTools share]showErrorInfo:NSLocalizedString(@"复制成功", nil)];
}
-(void)setResultString:(NSString *)resultString{
    _resultString=resultString;
}
@end
