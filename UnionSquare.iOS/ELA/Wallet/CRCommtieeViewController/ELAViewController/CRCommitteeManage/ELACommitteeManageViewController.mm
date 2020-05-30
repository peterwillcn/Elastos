//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import "ELACommitteeManageViewController.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"
#import "ELAPledgeView.h"
#import "HWMCRRegisteredViewController.h"
#import "ELWalletManager.h"
#import "HMWFMDBManager.h"
#import "ELANetworkManager.h"

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
    if(_type == 2)
    {
//        FLWallet *wallet = [ELWalletManager share].currentWallet;
//        NSArray *localStore  = [[NSMutableArray alloc]initWithArray: [[HMWFMDBManager sharedManagerType:CRListType] allSelectCRWithWallID:wallet.masterWalletID]];
//
//            for (int j=0; j<localStore.count; j++)
//            {
//                HWMCRListModel *dataModel = localStore[j];
////                ret =  [dataModel.did isEqualToString:_infoModel.did];
////                if (ret)
////                {
////
////                    curentmodel=model;
////                }
//            }
    
            
//        FLWallet *wallet = [ELWalletManager share].currentWallet;
//        HWMCRRegisteredViewController *vc = [[ HWMCRRegisteredViewController alloc]init];
////        vc.CRmodel=self.CRModel;
//        vc.isUpdate=YES;
//        vc.currentWallet = wallet;
//        [self.navigationController pushViewController:vc animated:YES];
    }
//    _pledgeView = [[ELAPledgeView alloc] init];
//    //_pledgeView.title = ELALocalizedString(@"11");
//    [_pledgeView showAlertView];
//    _pledgeView.block = ^{
//
//
//    };
//    [_pledgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(@(0));
//        make.width.equalTo(@(ScreenWidth));
//        make.height.equalTo(@(ScreenHeight));
//        make.top.bottom.equalTo(@(0));
//    }];
}

#pragma mark - view
- (void)creatView
{
  
    UIView *infoView = [[UIView alloc] init];
    infoView.layer.borderColor = [UIColor whiteColor].CGColor;
    infoView.layer.borderWidth = 1;
    infoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoView];

    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 360)];
    [self setBg:ELARGBA(28, 47, 47, 0.75) withToColor:ELARGBA(17, 32, 34, 0.75) withView:bgView];
    [infoView addSubview:bgView];


    UIImageView *headImageView = [[UIImageView alloc] init];
    
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_infoModel.avatar] placeholderImage:ImageNamed(@"point_information_img")];
    
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 40;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 0.5;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [infoView addSubview:headImageView];
//
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = _infoModel.didName;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(16);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    [infoView addSubview:titleLabel];


    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = @"";
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

    if(_type == 1)
    {
        NSString *des = @"本轮竞选已经结束，很遗憾您此次未能当选。感谢您的参与，祝您好运！";
        NSString *text = ELALocalizedString(des);
        subLabel.text = text;
        updateInfoButton.hidden = YES;
        [button setTitle:ELALocalizedString(@"提取质押金") forState:(UIControlStateNormal)];
    }
    else if(_type == 2)
    {
        NSString *des = @"每位CR委员须运行一个默认当选的DPoS超级节点，享有该节点产生的所有收益，并有义务保证节点正常运行。";
        NSString *text = ELALocalizedString(des);
        subLabel.text = text;
    }
    else if(_type == 3)
    {
        double douValue = [_infoModel.depositAmount doubleValue];
        NSString *des = ELALocalizedString(@"上届CR委员会任期已满，所有委员自动卸任离职。根据您的世界履职情况及CRC委员节点的运行情况，您的竞选押金返还额度为");
        NSString *string = [NSString stringWithFormat:@"%@%0.4fELA", des, douValue / ELAUnitConversion];
        subLabel.text = string;
        updateInfoButton.hidden = YES;
        [button setTitle:ELALocalizedString(@"提取质押金") forState:(UIControlStateNormal)];
    }
    else if(_type == 4)
    {
        double douValue = [_infoModel.depositAmount doubleValue];
        NSString *des = ELALocalizedString(@"上届CR委员会任期已满，所有委员自动卸任离职。根据您的世界履职情况及CRC委员节点的运行情况，您的竞选押金返还额度为");
        NSString *string = [NSString stringWithFormat:@"%@%0.4fELA", des, douValue / ELAUnitConversion];
        NSString *text = string;
        subLabel.text = text;
        updateInfoButton.hidden = YES;
        [button setTitle:ELALocalizedString(@"提取质押金") forState:(UIControlStateNormal)];
    }
    else if(_type == 5)
    {
        double douValue = [_infoModel.depositAmount doubleValue];
        NSString *des = ELALocalizedString(@"由于对您的弹劾已通过。您的委员职务已被免职。根据您的世界履职情况及CRC委员节点的运行情况，您的竞选押金返还额度为");
        NSString *string = [NSString stringWithFormat:@"%@%0.4fELA", des, douValue / ELAUnitConversion];
        NSString *text = string;
        subLabel.text = text;
        updateInfoButton.hidden = YES;
        [button setTitle:ELALocalizedString(@"提取质押金") forState:(UIControlStateNormal)];
    }
    else if(_type == 6)
    {
        double douValue = [_infoModel.depositAmount doubleValue];
        NSString *des = ELALocalizedString(@"上届CR委员会因故解散，所有委员自动去职。根据您时机履职情况及CRC委员节点的运行情况，您的竞选押金返回金额为");
        NSString *string = [NSString stringWithFormat:@"%@%0.4fELA", des, douValue / ELAUnitConversion];
        NSString *text = string;
        subLabel.text = text;
        updateInfoButton.hidden = YES;
        [button setTitle:ELALocalizedString(@"提取质押金") forState:(UIControlStateNormal)];
    }
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(@(NavigitionBarHeight + 15));
        make.height.equalTo(@(360));
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
        make.width.height.equalTo(@(80));

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
