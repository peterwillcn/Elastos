//
//  HWMTheEditorDIDInfoViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/31.
//

#import "HWMTheEditorDIDInfoViewController.h"

@interface HWMTheEditorDIDInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *DIDTextInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDataLabel;
@property (weak, nonatomic) IBOutlet UIButton *updatesButton;

@end

@implementation HWMTheEditorDIDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
            [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"编辑DID", nil);
    [self.updatesButton setTitle:NSLocalizedString(@"更新发布", nil) forState:UIControlStateNormal];
}
- (IBAction)changeTimeDataInfoEvent:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)updatesEvent:(id)sender {
[self.view endEditing:YES];
}

-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
    self.nickNameLabel.text=model.didName;
    self.publicKeyLabel.text=model.PubKeyString;
    self.DIDLabel.text=[NSString stringWithFormat:@"did:ela:%@",model.did];
    self.timeDataLabel.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"有效期至", nil),[[FLTools share]YMDCommunityTimeConversionTimeFromTimesTamp:self.model.issuanceDate]];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
