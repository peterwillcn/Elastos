//
//  HWMTheEditorDIDInfoViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/31.
//

#import "HWMTheEditorDIDInfoViewController.h"
#import "HWMDIDDataListView.h"
@interface HWMTheEditorDIDInfoViewController ()<HWMDIDDataListViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *DIDTextInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDataLabel;
@property (weak, nonatomic) IBOutlet UIButton *updatesButton;

@property(strong,nonatomic)HWMDIDDataListView *dataListView;
@end

@implementation HWMTheEditorDIDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
            [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"编辑DID", nil);
    [self.updatesButton setTitle:NSLocalizedString(@"更新发布", nil) forState:UIControlStateNormal];
    
    self.nickNameLabel.text=self.model.didName;
       self.publicKeyLabel.text=self.model.PubKeyString;
       self.DIDLabel.text=[NSString stringWithFormat:@"did:ela:%@",self.model.did];
       self.timeDataLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"有效期至", nil),[[FLTools share]YMDCommunityTimeConversionTimeFromTimesTamp:self.model.issuanceDate]];
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
   

       self.model.issuanceDate=[[FLTools share]timeSwitchTimestamp:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",yy,mm,dd]];
    self.timeDataLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"有效期至", nil),[[FLTools share]YMDCommunityTimeConversionTimeFromTimesTamp:self.model.issuanceDate]];
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
@end
