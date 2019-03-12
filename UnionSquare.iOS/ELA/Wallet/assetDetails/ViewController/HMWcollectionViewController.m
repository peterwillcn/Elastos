//
//  HMWcollectionViewController.m
//  ELA
//
//  Created by 韩铭文 on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWcollectionViewController.h"
#import "SGQRCodeGenerateManager.h"
#import "HMWAddressListViewController.h"

@interface HMWcollectionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *CopyTheAddressButton;
@property (weak, nonatomic) IBOutlet UIButton *addressListButton;
@property (weak, nonatomic) IBOutlet UIImageView *QRViewImage;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *FirstaddressString;
@end

@implementation HMWcollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self defultWhite];
  [self setBackgroundImg:@"asset_bg"];
    
    self.title=NSLocalizedString(@"充值", nil);
     self.FirstaddressString=self.addrestStringArray[0];
    self.addressLabel.layer.cornerRadius=15.f;
    self.addressLabel.layer.masksToBounds=YES;
    self.addressLabel.text=self.FirstaddressString;
    [[HMWCommView share] makeBordersWithView:self.CopyTheAddressButton];
     [[HMWCommView share] makeBordersWithView:self.addressListButton];
       self.QRViewImage.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:self.FirstaddressString imageViewWidth:self.QRViewImage.mj_w];
    
    if (self.addrestStringArray.count==1) {
        self.addressListButton.alpha=0.f;
    }
    
    [self.CopyTheAddressButton setTitle:NSLocalizedString(@"复制收款地址", nil) forState:UIControlStateNormal];
    [self.addressListButton setTitle:NSLocalizedString(@"进入地址列表", nil) forState:UIControlStateNormal];
    
}
- (IBAction)CopyTheAddressEvent:(id)sender {
    
    [[FLTools share]copiedToTheClipboardWithString:self.FirstaddressString];
    
    
}
- (IBAction)addressListEvent:(id)sender {
    HMWAddressListViewController *addressListVC=[[HMWAddressListViewController alloc]init];
    addressListVC.addressListArray=self.addrestStringArray;
    [self.navigationController pushViewController:addressListVC animated:YES];
}

-(void)setAddrestStringArray:(NSArray *)addrestStringArray{
    _addrestStringArray=addrestStringArray;
    
   
    
    
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
