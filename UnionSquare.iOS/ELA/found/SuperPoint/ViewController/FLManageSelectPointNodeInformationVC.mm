//
//  HMWnodeInformationViewController.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "FLManageSelectPointNodeInformationVC.h"

#import "HMWtheCandidateListViewController.h"
#import "ELWalletManager.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "FLJoinVoteInfoModel.h"
#import "HMWsignUpForViewController.h"
#import "FLCoinPointInfoModel.h"
@interface FLManageSelectPointNodeInformationVC()<HMWToDeleteTheWalletPopViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *votesLabel;
@property (weak, nonatomic) IBOutlet UILabel *votesNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteOfBTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteOfBNumberLabel;


@property (weak, nonatomic) IBOutlet UILabel *leftLab1;

@property (weak, nonatomic) IBOutlet UILabel *leftLab2;
@property (weak, nonatomic) IBOutlet UILabel *leftLab3;

@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *updataTheCandidateListButton;
@property (weak, nonatomic) IBOutlet UIButton *lookAtTheCandidateListButton;



@property (weak, nonatomic) IBOutlet UILabel *OwnerPublickKeyLab;
@property (weak, nonatomic) IBOutlet UILabel *NodePublickKeyLab;
@property (weak, nonatomic) IBOutlet UILabel *NickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *URLLab;
@property (weak, nonatomic) IBOutlet UILabel *LocationLab;
@property (weak, nonatomic) IBOutlet UILabel *AddressLab;

@property(nonatomic,strong)FLJoinVoteInfoModel *model;

@property(strong,nonatomic)HMWToDeleteTheWalletPopView *toDeleteTheWalletPopV;

@end

@implementation FLManageSelectPointNodeInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title= NSLocalizedString(@"选举管理", nil) ;
    self.leftLab1.text =NSLocalizedString(@"节点名称", nil) ;
     self.leftLab2.text =NSLocalizedString(@"节点公钥", nil) ;
     self.leftLab3.text =NSLocalizedString(@"国家/地区", nil) ;
    self.votesLabel.text=NSLocalizedString(@"当前票数", nil);
    self.voteOfBTextLabel.text=NSLocalizedString(@"投票占比", nil);
    [self.lookAtTheCandidateListButton setTitle:NSLocalizedString(@"注销", nil) forState:UIControlStateNormal];
    [self.updataTheCandidateListButton setTitle:NSLocalizedString(@"更新信息", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.updataTheCandidateListButton];
    [[HMWCommView share]makeBordersWithView:self.lookAtTheCandidateListButton];
    
    [[HMWCommView share]makeBordersWithView:self.infoBGView];
    self.iconImageView.layer.cornerRadius=30.f;
    self.iconImageView.layer.borderWidth=1.f;
    self.iconImageView.layer.borderColor=RGBA(255, 255, 255, 0.8).CGColor;
    
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    
    nlohmann::json info = mainchainSubWallet->GetRegisteredProducerInfo();
    NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
    
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *infoDic = param[@"Info"];
    
    NSString *OwnerPublickKey = infoDic[@"OwnerPublicKey"];
    NSString *NodePublickKey  =infoDic[@"NodePublicKey"];

    NSString *URL             = infoDic[@"URL"];
    
    NSString *Location        =infoDic[@"Location"];
    NSString *NickName        = infoDic[@"NickName"];
    
    self.model = [[FLJoinVoteInfoModel alloc]init];
    self.model.nickName = NickName;
    self.model.url = URL;
    self.model.contryCode = Location;
    self.model.ipAddress = infoDic[@"IpAddress"];
    self.model.ownerPublickKey=OwnerPublickKey;
    
    [self getNetCoinPointArrayWithPubKey:OwnerPublickKey];
    
    
    self.OwnerPublickKeyLab.text = NickName;
    self.NodePublickKeyLab.text  = NodePublickKey;
    self.NodePublickKeyLab.numberOfLines=0;
    self.URLLab.text = URL;
    self.LocationLab.text = [[FLTools share]contryNameTransLateByCode:Location.integerValue];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[FLTools share] getImageViewURLWithURL:self.model.url]] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
    
}
-(void)getNetCoinPointArrayWithPubKey:(NSString *)OwnerPublickKey{

    
    [HttpUrl NetPOSTHost:Http_IP url:@"/api/dposnoderpc/check/listproducer" header:@{} body:@{@"moreInfo":@"1"} showHUD:NO WithSuccessBlock:^(id data) {
        NSDictionary *param = data[@"data"];
        NSArray *dataSource= [NSArray modelArrayWithClass:FLCoinPointInfoModel.class json:param[@"result"][@"producers"]];
        for (FLCoinPointInfoModel *model in dataSource) {
            if ([model.ownerpublickey isEqualToString:OwnerPublickKey]) {
                self.votesNumberLabel.text=[NSString stringWithFormat:@"%@", model.votes];
    self.voteOfBNumberLabel.text=[NSString stringWithFormat:@"%.5lf %@" ,[model.voterate doubleValue]*100,@"%"];
                break;
            }
            
        }

//        self.votingListV.lab1.text = [NSString stringWithFormat:@"%.3f %@" ,[param[@"result"][@"totalvoterate"] floatValue]*100,@"%"];
        // self.votingListV.lab2.text = [param[@"result"][@"totalvotes"]stringValue ];
//        self.votingListV.lab3.text = param[@"result"][@"totalvotes"];
       
    } WithFailBlock:^(id data) {
        
    }];
}
- (IBAction)copyURLEvent:(id)sender {
    
    [UIPasteboard generalPasteboard].string = self.URLLab.text;
    [[FLTools share]showErrorInfo:NSLocalizedString(@"已复制到粘贴板", nil)];
}

- (IBAction)lookAtTheCandidateListEvent:(id)sender {
    
    UIView *maView=[self mainWindow];
    [maView addSubview:self.toDeleteTheWalletPopV];
    [self.toDeleteTheWalletPopV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(maView);
    }];
    
}
-(HMWToDeleteTheWalletPopView *)toDeleteTheWalletPopV{
    if (!_toDeleteTheWalletPopV) {
        _toDeleteTheWalletPopV =[[HMWToDeleteTheWalletPopView alloc]init];
        _toDeleteTheWalletPopV.delegate=self;
        _toDeleteTheWalletPopV.deleteType=deleteSelectVote;
    }
    
    return _toDeleteTheWalletPopV;
}
- (IBAction)updateTheCandidateListEvent:(id)sender {
    HMWsignUpForViewController  *vc = [[HMWsignUpForViewController alloc]init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    
    ELWalletManager *manager = [ELWalletManager share];
    NSString *walletId =  manager.currentWallet.masterWalletID;
    BOOL ret = [manager CancelProducer:walletId Pwd:pwd];
    if (ret) {
    
        [self.navigationController popViewControllerAnimated: YES];
    }
    [self toCancelOrCloseDelegate];
}
-(void)toCancelOrCloseDelegate{
    
    [self.toDeleteTheWalletPopV removeFromSuperview];
    self.toDeleteTheWalletPopV=nil;
}
@end
