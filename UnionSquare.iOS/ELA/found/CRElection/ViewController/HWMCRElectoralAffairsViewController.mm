//
//  HWMCRElectoralAffairsViewController.m
//  elastos wallet
//
//  Created by  on 2019/8/28.
//

#import "HWMCRElectoralAffairsViewController.h"
#import "nodeInformationDetailsView.h"

@interface HWMCRElectoralAffairsViewController ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *JoinTheCandidateListButton;
@property (weak, nonatomic) IBOutlet UIButton *LooKTheCandidateListButton;
/*
 *
 */
@property(strong,nonatomic)nodeInformationDetailsView *nodeInformationDetailsV;
@end

@implementation HWMCRElectoralAffairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
   self.title=NSLocalizedString(@"节点信息", nil);
    [self.BGView addSubview:self.nodeInformationDetailsV];
    [self.nodeInformationDetailsV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(15);
            make.bottom.equalTo(self.BGView);
        make.left.equalTo(self.BGView.mas_left).offset(15);
        make.right.equalTo(self.BGView.mas_right).offset(-15);
    }];
}
-(nodeInformationDetailsView *)nodeInformationDetailsV{
    if (!_nodeInformationDetailsV) {
        _nodeInformationDetailsV =[[nodeInformationDetailsView alloc]init];
//        _nodeInformationDetailsV.model=self.model;
        _nodeInformationDetailsV.type=CRCoinPointInfType;
        [_nodeInformationDetailsV.copURLButton addTarget:self action:@selector(copyURLEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nodeInformationDetailsV;
}
- (IBAction)JoinTheCandidateListEvent:(id)sender {
}
- (IBAction)LooKTheCandidateListEvent:(id)sender {
}
- (IBAction)copyURLEvent:(id)sender {
//    [UIPasteboard generalPasteboard].string = self.model.url;
}

@end
