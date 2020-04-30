//
//  HWMQrCodeTransferAndAddBuddyViewController.m
//  elastos wallet
//
//  Created by  on 2019/8/26.
//

#import "HWMQrCodeTransferAndAddBuddyViewController.h"
#import "HMWtransferViewController.h"
#import "HMWaddContactViewController.h"

@interface HWMQrCodeTransferAndAddBuddyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UIButton *AddContactButton;
@property (weak, nonatomic) IBOutlet UIImageView *QRViewImage;
@property (weak, nonatomic) IBOutlet UILabel *addressTextLabel;
@end

@implementation HWMQrCodeTransferAndAddBuddyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=NSLocalizedString(@"扫码结果", nil);
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.addressLabel.layer.cornerRadius=15.f;
    self.addressLabel.layer.masksToBounds=YES;
    self.addressLabel.text=self.addressString;
    [[HMWCommView share] makeBordersWithView:self.transferButton];
    [[HMWCommView share] makeBordersWithView:self.AddContactButton];
    [self.transferButton setTitle:NSLocalizedString(@"转账", nil) forState:UIControlStateNormal];
    [self.AddContactButton setTitle:NSLocalizedString(@"添加联系人", nil) forState:UIControlStateNormal];
    self.addressTextLabel.text=[NSString stringWithFormat:@" %@    ",NSLocalizedString(@"已识别收款地址", nil)];
     self.QRViewImage.image =[[FLTools share] imageWithSize:1100.f andColorWithRed:3 Green:3 Blue:5 andQRString:self.addressString];
}
-(void)setAddressString:(NSString *)addressString{
    _addressString=addressString;
    
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
}
-(void)setAddressDic:(NSDictionary *)addressDic{
    _addressDic=addressDic;
}
- (IBAction)transferEvent:(id)sender {
    HMWtransferViewController *HMWtransferVC=[[HMWtransferViewController alloc]init];
    HMWtransferVC.currentWallet=self.currentWallet;
    assetsListModel *model=[[assetsListModel   alloc]init];
    model.iconName=self.addressDic[@"extra"][@"SubWallet"];
    HMWtransferVC.model=model;
    HMWtransferVC.toAddressString=self.addressString;
    [self.navigationController pushViewController:HMWtransferVC animated:NO];
}
- (IBAction)AddContactEvent:(id)sender{
    HMWaddContactViewController *addContactVC=[[ HMWaddContactViewController alloc]init];
    addContactVC.title=NSLocalizedString(@"添加联系人", nil);
    addContactVC.addressString=self.addressString;
    addContactVC.typeInfo=updateInfo;
    [self.navigationController pushViewController:addContactVC animated:YES];}



@end
