//
//  HWMCrCommitteeInformationHeaderView.m
//  elastos wallet
//
//  Created by  on 2020/3/26.
//

#import "HWMCrCommitteeInformationHeaderView.h"
#import "NSImage+WebCache.h"

@interface HWMCrCommitteeInformationHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *headIcomImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *didStringLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookInfoButton;

@end

@implementation HWMCrCommitteeInformationHeaderView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMCrCommitteeInformationHeaderView" owner:nil options:nil].firstObject;
        self.lookInfoButton.alpha=0.f;
        self.didStringLabel.lineBreakMode=NSLineBreakByTruncatingMiddle;
    }
    return self;
    
    
}

- (IBAction)lookInfoEvent:(id)sender {
    if (self.block) {
        self.block();
    }
}
- (IBAction)copyDIDStringEvent:(id)sender {
    
    if (self.didStringLabel.text.length>0&&self.CRmodel.cid.length>0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"已复制到剪切板。", nil)];
        [[FLTools share]copiedToTheClipboardWithString:self.didStringLabel.text];
          }
}
- (void)setCRmodel:(HWMCRListModel *)CRmodel{
    _CRmodel=CRmodel;
    if (CRmodel.cid.length>0) {
        self.didStringLabel.text=[NSString stringWithFormat:@"did:elastos:%@",CRmodel.cid];
        self.lookInfoButton.alpha=1.f;
    }else{
        self.didStringLabel.text=NSLocalizedString(@"[未激活]", nil);
    }
    [self.headIcomImageView sd_setImageWithURL:[NSURL URLWithString:CRmodel.iconImageUrl] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
    self.nickNameLable.text=CRmodel.nickname;
    
    
}
@end
