//
//  HMWnodeInformationViewController.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWnodeInformationViewController.h"

#import "HMWtheCandidateListViewController.h"
#import "FLNotePointDBManager.h"
@interface HMWnodeInformationViewController ()
@property (weak, nonatomic) IBOutlet UIView *infoBGView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *nodePubKeyLab;
@property (weak, nonatomic) IBOutlet UILabel *ticketNumbLab;
@property (weak, nonatomic) IBOutlet UILabel *ticketRateLab;
@property (weak, nonatomic) IBOutlet UILabel *contryCodeLab;
@property (weak, nonatomic) IBOutlet UILabel *urlLab;

@property (weak, nonatomic) IBOutlet UILabel *tagNickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *tagNodePubKeyLab;
@property (weak, nonatomic) IBOutlet UILabel *tagTicketNumbLab;
@property (weak, nonatomic) IBOutlet UILabel *tagTicketRateLab;
@property (weak, nonatomic) IBOutlet UILabel *tagContryCodeLab;
@property (weak, nonatomic) IBOutlet UILabel *tagUrlLab;


@property (weak, nonatomic)IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *joinTheCandidateListButton;
@property (weak, nonatomic) IBOutlet UIButton *lookAtTheCandidateListButton;

@property(nonatomic,assign)BOOL hasModel;


@end

         
         
@implementation HMWnodeInformationViewController
- (void)viewDidLoad {
   [super viewDidLoad];
  [self defultWhite];
    [self setBackgroundImg:@"tab_bg"];
     self.title=NSLocalizedString(@"节点信息", nil) ;
    [[HMWCommView share]makeBordersWithView:self.joinTheCandidateListButton];
    [[HMWCommView share]makeBordersWithView:self.lookAtTheCandidateListButton];
    [[HMWCommView share]makeBordersWithView:self.infoBGView];
    
    
    
    self.iconImageView.layer.cornerRadius  =30.f;
    self.iconImageView.layer.borderWidth   =1.f;
    self.iconImageView.layer.borderColor   =RGBA(255, 255, 255, 0.8).CGColor;
    
   self.tagNickNameLab.text  =NSLocalizedString(@"节点名称", nil);
   self.tagNodePubKeyLab.text=NSLocalizedString(@"所有人公钥", nil);
   self.tagTicketNumbLab.text=NSLocalizedString(@"当前票数", nil);
   self.tagTicketRateLab.text=NSLocalizedString(@"投票占比", nil);
   self.tagContryCodeLab.text=NSLocalizedString(@"国家/地区", nil);
    self.nickNameLab.text   = self.model.nickname;
    self.nodePubKeyLab.text = self.model.ownerpublickey;
    self.urlLab.text        = self.model.url;
    self.ticketNumbLab.text = self.model.votes;
    self.ticketRateLab.text = [NSString stringWithFormat:@"%.5lf %@",self.model.voterate.doubleValue*100,@"%"] ;
    self.contryCodeLab.text =  [[FLTools share]contryNameTransLateByCode:  self.model.location.integerValue];
    
    BOOL ret = [[FLNotePointDBManager defult]hasModel:self.model];
    self.hasModel = ret;
    
    [self.joinTheCandidateListButton setTitle:NSLocalizedString(@"加入候选列表", nil)  forState:UIControlStateNormal];
      [self.lookAtTheCandidateListButton setTitle:NSLocalizedString(@"查看候选列表", nil)  forState:UIControlStateNormal];
    if (ret) {
        [self.joinTheCandidateListButton setTitle:NSLocalizedString(@"移出候选列表", nil) forState:UIControlStateNormal];
    }
    
    if (self.model.active==0) {
        self.joinTheCandidateListButton.enabled = NO;
    }else{
        self.joinTheCandidateListButton.enabled = YES;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[FLTools share] getImageViewURLWithURL:self.model.url]] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
    
}
- (IBAction)copyURLEvent:(id)sender {
    [UIPasteboard generalPasteboard].string = self.model.url;
}
- (IBAction)lookAtTheCandidateListEvent:(id)sender {
  
    HMWtheCandidateListViewController *theCandidateListVC=[[HMWtheCandidateListViewController alloc]init];
    
    [self.navigationController pushViewController:theCandidateListVC animated:YES];
}
- (IBAction)joinTheCandidateListEvent:(id)sender {
    
    
    if (self.hasModel) {
        BOOL ret =  [[FLNotePointDBManager defult]delectRecord:self.model];
        if (ret) {
            [[FLTools share]showErrorInfo:NSLocalizedString(@"删除成功",nil)];

            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[FLTools share]showErrorInfo:NSLocalizedString(@"删除失败", nil)];
        }
    }else{
       
        
    BOOL ret =  [[FLNotePointDBManager defult]addRecord:self.model];
    if (ret) {
        [self.joinTheCandidateListButton setTitle:NSLocalizedString(@"移出候选列表", nil) forState:UIControlStateNormal];
        self.hasModel = YES;
        [[FLTools share]showErrorInfo:NSLocalizedString(@"添加成功",nil)];

    }else{
        [[FLTools share]showErrorInfo:NSLocalizedString(@"添加失败", nil)];
    }
    }
}
-(void)setModel:(FLCoinPointInfoModel *)model
{
    _model = model;
}

@end
