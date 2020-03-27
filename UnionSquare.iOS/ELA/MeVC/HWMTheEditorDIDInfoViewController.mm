//
//  HWMTheEditorDIDInfoViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/31.
//

#import "HWMTheEditorDIDInfoViewController.h"
#import "HWMDIDDataListView.h"
#import "HWMDIDManager.h"
#import "HMWpwdPopupView.h"
#import "HMWSendSuccessPopuView.h"
#import "ELWalletManager.h"
@interface HWMTheEditorDIDInfoViewController ()<HWMDIDDataListViewDelegate,HMWpwdPopupViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *DIDTextInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDataLabel;
@property (weak, nonatomic) IBOutlet UIButton *updatesButton;
@property(strong,nonatomic)HMWpwdPopupView *ShowPoPWDView;
@property(strong,nonatomic)HWMDIDDataListView *dataListView;
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;

@end

@implementation HWMTheEditorDIDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
            [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"编辑DID", nil);
    [self.updatesButton setTitle:NSLocalizedString(@"更新发布", nil) forState:UIControlStateNormal];
    
    self.nickNameLabel.text=self.model.didName;
       self.publicKeyLabel.text=self.PubKeyString;
       self.DIDLabel.text=[NSString stringWithFormat:@"did:ela:%@",self.model.did];
       self.timeDataLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"有效期至", nil),[[FLTools share]YMDCommunityTimeConversionTimeFromTimesTamp:self.model.editTime]];
}
- (IBAction)changeTimeDataInfoEvent:(id)sender {
    UIView *mainView =  [self mainWindow];
    [mainView addSubview:self.dataListView];
    [self.dataListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
    [self.view endEditing:YES];
}
- (IBAction)updatesEvent:(id)sender {
[self.view endEditing:YES];
    [self showPWDView];
}
-(HMWpwdPopupView *)ShowPoPWDView{
    if (!_ShowPoPWDView) {
        _ShowPoPWDView =[[HMWpwdPopupView alloc]init];
        _ShowPoPWDView.delegate=self;
    }
    return _ShowPoPWDView;
}
-(HWMDIDDataListView *)dataListView{
    if (!_dataListView) {
        _dataListView =[[HWMDIDDataListView alloc]init];
        _dataListView.delegate=self;
        _dataListView.ListViewType=DIDDataType;
    }
    return _dataListView;
}

-(void)cancelDataListView{
    [self.dataListView removeFromSuperview];
    self.dataListView=nil;
}

-(void)selectDataWithYY:(NSString*_Nullable)yy withMM:(NSString*_Nullable)mm wihMMWithInt:(NSInteger)mInt wtihDD:(NSString*_Nullable)dd{
   
       self.model.editTime=[[FLTools share]timeSwitchTimestamp:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",yy,mm,dd]];
    self.timeDataLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"有效期至", nil),[[FLTools share]YMDCommunityTimeConversionTimeFromTimesTamp:self.model.editTime]];
       [self cancelDataListView];

}
-(void)setModel:(HWMDIDInfoModel *)model{
    if (model==nil) {
        model =[[HWMDIDInfoModel alloc]init];
    }
    _model=model;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
-(void)makeSureWithPWD:(NSString*)pwd{
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,pwd] callbackId:self.currentWallet.masterWalletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
            NSString *  privatekeyString=[[ELWalletManager share]ExportxPrivateKey:mommand];
       if (privatekeyString.length==0) {
           return;
       }
    
    [[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.model.did WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID];
    if ([[HWMDIDManager shareDIDManager]updateInfoWithInfo:self.model]) {
        [self showSendSuccessView];
       }else{
           [[FLTools share]showErrorInfo:@"失败"];
       }
    [self.ShowPoPWDView removeFromSuperview];
      self.ShowPoPWDView=nil;
}
-(void)cancelThePWDPageView{
    [self.ShowPoPWDView removeFromSuperview];
    self.ShowPoPWDView=nil;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)showPWDView{
        UIView *mainView =[self mainWindow];
        [mainView addSubview:self.ShowPoPWDView];
        [self.ShowPoPWDView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    
}
-(void)showSendSuccessView{
   self.sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV=nil;
        [self.navigationController popViewControllerAnimated:YES];
    });
   
}
@end
