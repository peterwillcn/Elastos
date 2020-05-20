//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import "ELACRBaseViewController.h"
#import "ELAUtils.h"
#import "UIViewController+FLVCExt.h"
#import "FLTools.h"
#import "ELANetworkManager.h"

@interface ELACRBaseViewController ()

@end

@implementation ELACRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UITableView appearance].estimatedRowHeight = 0;
    [UITableView appearance].estimatedSectionHeaderHeight = 0;
    [UITableView appearance].estimatedSectionFooterHeight = 0;
    
    // Do any additional setup after loading the view.
    [self defultWhite];
    UIImageView *bg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self CAGradientColorFrome:ELARGB(83, 136, 136) withToColor:ELARGB(16, 47, 58) withView:bg];
  //  [self.view addSubview:bg];
    [self.view insertSubview:bg atIndex:0];
  //  [self setBackgroundImg:@""];
    
}


- (void)goBack
{
    AFHTTPSessionManager *manager = [ELANetworkManager getManager];
    if (manager.tasks.count > 0)
    {
        [manager.operationQueue cancelAllOperations];
    }
    [self hideLoadingView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLoadingView
{
    [[FLTools share] showLoadingView];
}
- (void)hideLoadingView
{
    [[FLTools share] hideLoadingView];
}
- (void)showErrorInfo:(NSString *)errorString
{
    [[FLTools share]showErrorInfo:errorString];
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
