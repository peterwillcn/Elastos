//
//  HMWnodeInformationViewController.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWnodeInformationViewController.h"

#import "HMWtheCandidateListViewController.h"
#import "FLNotePointDBManager.h"
@interface HMWnodeInformationViewController ()
//@property (weak, nonatomic) IBOutlet UIView *infoBGView;
//
//@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
//@property (weak, nonatomic) IBOutlet UILabel *nodePubKeyLab;
//@property (weak, nonatomic) IBOutlet UILabel *ticketNumbLab;
//@property (weak, nonatomic) IBOutlet UILabel *ticketRateLab;
//@property (weak, nonatomic) IBOutlet UILabel *contryCodeLab;
//@property (weak, nonatomic) IBOutlet UILabel *urlLab;
//
//@property (weak, nonatomic) IBOutlet UILabel *tagNickNameLab;
//@property (weak, nonatomic) IBOutlet UILabel *tagNodePubKeyLab;
//@property (weak, nonatomic) IBOutlet UILabel *tagTicketNumbLab;
//@property (weak, nonatomic) IBOutlet UILabel *tagTicketRateLab;
//@property (weak, nonatomic) IBOutlet UILabel *tagContryCodeLab;
//@property (weak, nonatomic) IBOutlet UILabel *tagUrlLab;
//
//
//@property (weak, nonatomic)IBOutlet UIImageView *iconImageView;
//@property (weak, nonatomic) IBOutlet UIButton *joinTheCandidateListButton;
//@property (weak, nonatomic) IBOutlet UIButton *lookAtTheCandidateListButton;

@property(nonatomic,assign)BOOL hasModel;
/*
 *
 */
@property(strong,nonatomic)UIImageView *siconImageView;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *nodeNameTextLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *nodeNameLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *nodeAddressTextLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *nodeAddressLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *currantVotesTextLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *currantVotesLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *votePercentageTextLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *votePercentageLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *countryRegionTextLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *countryRegionLabel;
@property(strong,nonatomic)UILabel *URLTextLabel;
@property(strong,nonatomic)UILabel *URLLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton
*copURLButton;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton *joinTheCandidateListButton;
/*
 *<# #>
 */
@property(copy,nonatomic)UIButton *lookAtTheCandidateListButton;

@end

         
         
@implementation HMWnodeInformationViewController
- (void)viewDidLoad {
   [super viewDidLoad];
    NSLog(@"viewDidLoad");
  [self defultWhite];
    [self setBackgroundImg:@"tab_bg"];
     self.title=NSLocalizedString(@"节点信息", nil) ;
    [self makeUI];
    

   

    
    
}
-(UIButton *)lookAtTheCandidateListButton{
    if (!_lookAtTheCandidateListButton) {
        _lookAtTheCandidateListButton =[[UIButton alloc]init];
        [_lookAtTheCandidateListButton setTitle:NSLocalizedString(@"查看候选列表", nil) forState:UIControlStateNormal];
        [_lookAtTheCandidateListButton setImage:[UIImage imageNamed:@"found_vote_look_over"] forState:UIControlStateNormal];
       _lookAtTheCandidateListButton.titleLabel.font =[UIFont systemFontOfSize:14];
        [[HMWCommView share]makeBordersWithView:_lookAtTheCandidateListButton];
        [_lookAtTheCandidateListButton addTarget:self action:@selector(lookAtTheCandidateListEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookAtTheCandidateListButton;
}
-(UIButton *)joinTheCandidateListButton{
    if (!_joinTheCandidateListButton) {
        _joinTheCandidateListButton =[[UIButton alloc]init];
       
        [_joinTheCandidateListButton setImage:[UIImage imageNamed:@"found_vote_add"] forState:UIControlStateNormal];
        _joinTheCandidateListButton.titleLabel.font =[UIFont systemFontOfSize:14];
         [[HMWCommView share]makeBordersWithView:_joinTheCandidateListButton];
        [_joinTheCandidateListButton addTarget:self action:@selector(joinTheCandidateListEvent:) forControlEvents:UIControlEventTouchUpInside];
           BOOL ret = [[FLNotePointDBManager defult]hasModel:self.model];
            self.hasModel = ret;
            if (ret) {
                [self.joinTheCandidateListButton setTitle:NSLocalizedString(@"移出候选列表", nil) forState:UIControlStateNormal];
            }else{
                 [_joinTheCandidateListButton setTitle:NSLocalizedString(@"加入候选列表", nil)  forState:UIControlStateNormal];
            }
        
            if (self.model.active==0) {
                self.joinTheCandidateListButton.enabled = NO;
            }else{
                self.joinTheCandidateListButton.enabled = YES;
            }
        
    }
    return _joinTheCandidateListButton;
}
-(UIButton *)copURLButton{
    if (!_copURLButton) {
        _copURLButton =[[UIButton alloc]init];
        [_copURLButton setImage:[UIImage imageNamed:@"asset_transfer_copyW"] forState:UIControlStateNormal];
        [_copURLButton addTarget:self action:@selector(copyURLEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copURLButton;
}
-(UIImageView *)siconImageView{
    if (!_siconImageView) {
        _siconImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 56, 30)];
        _siconImageView.layer.cornerRadius  =1.f;
        _siconImageView.layer.borderWidth   =1.f;
        _siconImageView.layer.borderColor   =RGBA(255, 255, 255, 0.8).CGColor;
        _siconImageView.image=[UIImage imageNamed:@"found_vote_initial"];
    }
    return _siconImageView;
}
-(void)makeUI{
    UIView *BGView =[[UIView alloc]init];
    BGView.backgroundColor=RGBA(0, 0, 0, 0.5);
    [self.view addSubview:BGView];
    [[HMWCommView share]makeBordersWithView:BGView];
    [BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).mas_equalTo(74);
        make.left.equalTo(self.view.mas_left).mas_offset(15);
        make.right.equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(@385);
    }];
    [BGView addSubview:self.siconImageView];
    [self.siconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(BGView.mas_top).mas_offset(36);
        make.size.mas_equalTo(CGSizeMake(55, 30));
        
    }];
    self.nodeNameTextLabel=[self labeWithTextColor:RGBA(255, 255, 255, 0.5) withText:NSLocalizedString(@"节点名称", nil) withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
    [BGView addSubview:self.nodeNameTextLabel];
    [self.nodeNameTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView.mas_left).offset(15);
        make.top.equalTo(self.siconImageView.mas_bottom).offset(40);
  make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
self.nodeNameLabel=[self labeWithTextColor:[UIColor whiteColor] withText:self.model.nickname withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    [BGView addSubview:self.nodeNameLabel];
    [self.nodeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BGView.mas_right).offset(-15);
        make.top.equalTo(self.siconImageView.mas_bottom).offset(40);
        make.height.mas_equalTo(@15);
        make.left.equalTo(self.nodeNameTextLabel.mas_right).offset(10);
    }];
self.nodeAddressTextLabel=[self labeWithTextColor:RGBA(255, 255, 255, 0.5) withText:NSLocalizedString(@"所有人公钥", nil) withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
    [BGView addSubview:self.nodeAddressTextLabel];
    [self.nodeAddressTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView.mas_left).offset(15);
        make.top.equalTo( self.nodeNameTextLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    self.nodeAddressLabel=[self labeWithTextColor:[UIColor whiteColor] withText:self.model.ownerpublickey withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    [BGView addSubview:self.nodeAddressLabel];
    [self.nodeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BGView.mas_right).offset(-15);
        make.centerY.equalTo(self.nodeAddressTextLabel.mas_centerY);
        make.height.mas_equalTo(@60);
        make.left.equalTo(self.nodeAddressTextLabel.mas_right).offset(10);
    }];

    self.currantVotesTextLabel=[self labeWithTextColor:RGBA(255, 255, 255, 0.5) withText:NSLocalizedString(@"当前票数", nil) withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
    [BGView addSubview:self.currantVotesTextLabel];
    [self.currantVotesTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView.mas_left).offset(15);
        make.top.equalTo( self.nodeAddressTextLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
    self.currantVotesLabel=[self labeWithTextColor:[UIColor whiteColor] withText:[NSString stringWithFormat:@"%ld %@",(long)[self.model.votes integerValue],NSLocalizedString(@"票", nil)] withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    [BGView addSubview:self.currantVotesLabel];
    [self.currantVotesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BGView.mas_right).offset(-15);
        make.centerY.equalTo(self.self.currantVotesTextLabel.mas_centerY);
        make.height.mas_equalTo(@30);
        make.left.equalTo(self.currantVotesTextLabel.mas_right).offset(10);
    }];

    
    self.votePercentageTextLabel=[self labeWithTextColor:RGBA(255, 255, 255, 0.5) withText:NSLocalizedString(@"投票占比", nil) withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
    [BGView addSubview:self.votePercentageTextLabel];
    [self.votePercentageTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView.mas_left).offset(15);
        make.top.equalTo( self.currantVotesTextLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(160, 15));
    }];
    self.votePercentageLabel=[self labeWithTextColor:[UIColor whiteColor] withText:[NSString stringWithFormat:@"%.5lf %@",self.model.voterate.doubleValue*100,@"%"] withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    [BGView addSubview:self.votePercentageLabel];
    [self.votePercentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BGView.mas_right).offset(-15);
        make.centerY.equalTo(self.votePercentageTextLabel.mas_centerY);
        make.height.mas_equalTo(@30);
        make.left.equalTo(self.votePercentageTextLabel.mas_right).offset(10);
    }];

    self.countryRegionTextLabel=[self labeWithTextColor:RGBA(255, 255, 255, 0.5) withText:NSLocalizedString(@"国家/地区", nil) withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
    [BGView addSubview:self.countryRegionTextLabel];
    [self.countryRegionTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView.mas_left).offset(15);
        make.top.equalTo( self.votePercentageTextLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(160, 15));
    }];
    self.countryRegionLabel=[self labeWithTextColor:[UIColor whiteColor] withText:@"--" withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    [BGView addSubview:self.countryRegionLabel];
    [self.countryRegionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BGView.mas_right).offset(-15);
        make.centerY.equalTo(self.countryRegionTextLabel.mas_centerY);
        make.height.mas_equalTo(@30);
        make.left.equalTo(self.countryRegionTextLabel.mas_right).offset(10);
    }];
    self.URLTextLabel=[self labeWithTextColor:RGBA(255, 255, 255, 0.5) withText:@"URL" withTextFont:14 withTextAlignment:NSTextAlignmentLeft];
    [BGView addSubview:self.URLTextLabel];
    [self.URLTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView.mas_left).offset(15);
        make.top.equalTo( self.countryRegionTextLabel.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    self.URLLabel=[self labeWithTextColor:RGB(40, 147, 232) withText:self.model.url withTextFont:14 withTextAlignment:NSTextAlignmentRight];
    [BGView addSubview:self.URLLabel];
    [self.URLLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BGView.mas_right).offset(-55);
        make.centerY.equalTo(self.URLTextLabel.mas_centerY);
        make.height.mas_equalTo(@30);
        make.left.equalTo(self.URLTextLabel.mas_right).offset(5);
    }];
    
    
    [BGView addSubview:self.copURLButton];
    [self.copURLButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BGView.mas_right).offset(-10);
        make.centerY.equalTo(self.URLTextLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    [self.view addSubview:self.lookAtTheCandidateListButton];
    [self.lookAtTheCandidateListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(63);
        make.right.equalTo(self.view.mas_right).offset(-63);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.height.mas_equalTo(@40);
        
    }];
    [self.view addSubview:self.joinTheCandidateListButton];
    [self.joinTheCandidateListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(63);
        make.right.equalTo(self.view.mas_right).offset(-63);
        make.bottom.equalTo(self.lookAtTheCandidateListButton.mas_top).offset(-20);
        make.height.mas_equalTo(@40);
        
    }];
  
    dispatch_group_t group =  dispatch_group_create();
 __block NSString *URL;
    __block NSString *countries;
    if (self.model.iconImageUrl.length>0) {
        URL=self.model.iconImageUrl;
    }
    if (self.model.url.length>0&&self.model.iconImageUrl.length==0) {
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        URL=[[FLTools share] getImageViewURLWithURL:self.model.url];
    });
        
    }
   
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      countries=[[FLTools share]contryNameTransLateByCode:  self.model.location.integerValue];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.countryRegionLabel.text=countries;
        if (URL.length>0&&self.model.url.length>0) {
           [self.siconImageView sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
        }
    });

}
-(void)upInfo{
    
//       self.tagNickNameLab.text  =NSLocalizedString(@"节点名称", nil);
//       self.tagNodePubKeyLab.text=NSLocalizedString(@"所有人公钥", nil);
//       self.tagTicketNumbLab.text=NSLocalizedString(@"当前票数", nil);
//       self.tagTicketRateLab.text=NSLocalizedString(@"投票占比", nil);
//       self.tagContryCodeLab.text=NSLocalizedString(@"国家/地区", nil);
//        self.nickNameLab.text   = self.model.nickname;
//        self.nodePubKeyLab.text = self.model.ownerpublickey;
//        self.urlLab.text        = self.model.url;
//        self.ticketNumbLab.text = [NSString stringWithFormat:@"%ld %@",(long)[self.model.votes integerValue],NSLocalizedString(@"票", nil)];
//        self.ticketRateLab.text = [NSString stringWithFormat:@"%.5lf %@",self.model.voterate.doubleValue*100,@"%"] ;
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
//        if (self.model.url.length>0) {
//                [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[[FLTools share] getImageViewURLWithURL:self.model.url]] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
//        }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.contryCodeLab.text =  [[FLTools share]contryNameTransLateByCode:  self.model.location.integerValue];
//    });

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
-(UILabel*)labeWithTextColor:(UIColor*)color withText:(NSString*)text withTextFont:(CGFloat)font withTextAlignment:(NSTextAlignment)TextA{
    UILabel *labe =[[UILabel alloc]init];
    labe.text=text;
    labe.textAlignment=TextA;
    labe.font=[UIFont systemFontOfSize:font];
    labe.numberOfLines=0;
    labe.textColor=color;
    return labe;
}
@end
