//
//  ELACommitteeManageViewController.m
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/12.
//  Copyright © 2020 64. All rights reserved.
//

#import "ELACommitteeManageViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"
#import "ELAPledgeView.h"

@interface ELACommitteeManageViewController ()

@property (nonatomic, strong) ELAPledgeView *pledgeView;

@end

@implementation ELACommitteeManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatView];
}

- (void)setBg:(UIColor*)fclolr withToColor:(UIColor*)tcolor withView:(UIView*)view{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, view.width, view.height);
    gl.colors = @[(__bridge id)fclolr.CGColor,(__bridge id)tcolor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer addSublayer:gl];

}
#pragma mark - Action

- (void)updateDIDButtonAction:(id)sender
{
    
}

- (void)updateInfoButtonAction:(id)sender
{
    _pledgeView = [[ELAPledgeView alloc] init];
    //_pledgeView.title = ELALocalizedString(@"11");
    [_pledgeView showAlertView];
    _pledgeView.block = ^{
    
        
    };
    [_pledgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(0));
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(ScreenHeight));
        make.top.bottom.equalTo(@(0));
    }];
}

#pragma mark - view
- (void)creatView
{
  
    UIView *infoView = [[UIView alloc] init];
    infoView.layer.borderColor = [UIColor whiteColor].CGColor;
    infoView.layer.borderWidth = 1;
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];

    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 400)];
    [self setBg:ELARGBA(28, 47, 47, 0.75) withToColor:ELARGBA(17, 32, 34, 0.75) withView:bgView];
    [infoView addSubview:bgView];


    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = ImageNamed(@"point_information_img");
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 30;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 0.5;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [infoView addSubview:headImageView];
//
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(@"委员名称");
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(16);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:titleLabel];


    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = @"委员说明内容委员说明内容委员说明内容委员说明内容委员说明内容委员说明内容委员说明内容委员说明内容委员说明内容";
    subLabel.textColor = [UIColor whiteColor];
    subLabel.font = PingFangRegular(14);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.numberOfLines = 0;
    [infoView addSubview:subLabel];
    
    UIButton *updateInfoButton = [[UIButton alloc] init];
    updateInfoButton.layer.masksToBounds = YES;
    //    button.layer.cornerRadius = 5;
    updateInfoButton.layer.borderColor = [UIColor whiteColor].CGColor;
    updateInfoButton.layer.borderWidth = 1;
    updateInfoButton.backgroundColor = ELARGB(45, 69, 76);
    updateInfoButton.titleLabel.textColor = [UIColor whiteColor];
    updateInfoButton.titleLabel.font = PingFangRegular(14);
    [updateInfoButton setTitle:ELALocalizedString(@"更新委员信息") forState:(UIControlStateNormal)];
    [updateInfoButton addTarget:self action:@selector(updateInfoButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:updateInfoButton];
    
    UIButton *button = [[UIButton alloc] init];
    button.layer.masksToBounds = YES;
//    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1;
    button.backgroundColor = ELARGB(45, 69, 76);
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = PingFangRegular(14);
    [button setTitle:ELALocalizedString(@"更新DID信息") forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(updateDIDButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
   // [button addTarget:self action:@selector(manageButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];

    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(@(NavigitionBarHeight + 15));
        make.height.equalTo(@(400));
    }];
//
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(infoView);
    }];
//
//
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(infoView);
        make.top.equalTo(infoView).offset(40);
        make.width.height.equalTo(@(60));

    }];
//
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headImageView);
        make.top.equalTo(headImageView.mas_bottom).offset(15);
    }];

    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoView).offset(15);
        make.right.equalTo(infoView).offset(-15);
        make.top.equalTo(titleLabel.mas_bottom).offset(85);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(250));
        make.height.equalTo(@(40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-BottomHeight - 20);
    }];
    
    [updateInfoButton mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.equalTo(self.view);
           make.width.equalTo(@(250));
           make.height.equalTo(@(40));
           make.bottom.equalTo(button.mas_top).offset(-20);
       }];
}

@end
