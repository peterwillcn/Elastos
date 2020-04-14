//
//  HWMDIDAuthorizationHeadView.m
//  elastos wallet
//
//  Created by  on 2020/3/18.
//

#import "HWMDIDAuthorizationHeadView.h"


@interface HWMDIDAuthorizationHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *didStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *showTextLabel;

@end


@implementation HWMDIDAuthorizationHeadView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMDIDAuthorizationHeadView" owner:nil options:nil].firstObject;
        self.backgroundColor=[UIColor clearColor];
        
        
        self.infoTextLabel.text=NSLocalizedString(@"申请使用您的DID信息（包括但不限于存储、展示等用途）：", nil);
        self.showTextLabel.text=NSLocalizedString(@"- DID基本信息", nil);
        
        
    }
    return self;
}
-(void)setInfoDic:(NSDictionary *)infoDic{
    NSString *iconString=infoDic[@"website"][@"logo"];
    
    if (iconString.length>0) {
        [[FLTools share]loadUrlSVGAndPNG:iconString WithSuccessBlock:^(id data) {
            if (data) {
                self.iconImageView.image=data;
            }else{
                self.iconImageView.image=[UIImage imageNamed:@"cyber_republic"];
            }
        }];
    }else{
        self.iconImageView.image=[UIImage imageNamed:@"cyber_republic"];
    }
    
    self.nickNameLabel.text=infoDic[@"website"][@"domain"];
    self.didStringLabel.text=infoDic[@"iss"];
    _infoDic=infoDic;
}
-(void)setReadModel:(HWMDIDInfoModel *)readModel{
    self.nickNameLabel.text=readModel.nickname;
    
    self.didStringLabel.text=readModel.did;
    if (readModel.avatar.length>0) {
        [[FLTools share]loadUrlSVGAndPNG:readModel.avatar WithSuccessBlock:^(id data) {
            if (data) {
                self.iconImageView.image=data;
            }else{
                self.iconImageView.image=[UIImage imageNamed:@"mine_did_default_avator"];
            }
        }];
    }else{
        self.iconImageView.image=[UIImage imageNamed:@"mine_did_default_avator"];
    }
    
}
- (IBAction)CpyeDIDStringEvent:(id)sender {
    if (self.didStringLabel.text.length>0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"已复制到剪切板。", nil)];
        [[FLTools share]copiedToTheClipboardWithString:self.didStringLabel.text];
    }
    
    
    
}
@end
