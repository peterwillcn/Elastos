//
//  HMWcollectionViewController.m
//  ELA
//
//  Created by  on 2018/12/26.
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
  [self setBackgroundImg:@""];
    
    

    
    self.title=NSLocalizedString(@"收款", nil);
    self.FirstaddressString=self.iconAddress;
    self.addressLabel.layer.cornerRadius=15.f;
    self.addressLabel.layer.masksToBounds=YES;
    self.addressLabel.text=self.FirstaddressString;
    [[HMWCommView share] makeBordersWithView:self.CopyTheAddressButton];
     [[HMWCommView share] makeBordersWithView:self.addressListButton];
    NSDictionary *qrDic=[[FLTools share] CreateQrCodeImage:self.FirstaddressString WithType:@"4" withSubWalletIdChain:self.iconName];
    NSString *qrString=[[FLTools share] returnJSONStringWithDictionary:qrDic];
       self.QRViewImage.image = [[FLTools share] imageWithSize:300.f andColorWithRed:3 Green:3 Blue:5 andQRString:qrString];
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
-(void)setIconName:(NSString *)iconName{
    _iconName=iconName;
    
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
