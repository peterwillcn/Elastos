//
//  ELAImpeachView.m
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/14.
//  Copyright © 2020 64. All rights reserved.
//

#import "ELAImpeachView.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"

@interface ELAImpeachView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ELAImpeachView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initView];
    }
    return self;
}
- (void)initView
{
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self setBg:ELARGB(83, 136, 136) withToColor:ELARGB(16, 47, 58) withView:bgImgView];
    [_contentView addSubview:bgImgView];
    
    _showView = [[UIView alloc] init];
    [self addSubview:_showView];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = ELARGB(29, 29, 29);
    [_showView addSubview:_bgView];
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setImage:ImageNamed(@"window_54_close") forState:(UIControlStateNormal)];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_showView addSubview:_closeButton];
    
    _sureButton = [[UIButton alloc] init];
    [_sureButton setTitle:ELALocalizedString(@"提取质押金") forState:UIControlStateNormal];
    _sureButton.titleLabel.font = PingFangRegular(15);
    [_sureButton setBackgroundColor:ELARGB(65, 118, 117)];
    _sureButton.layer.cornerRadius = 5;
    _sureButton.layer.masksToBounds = YES;
    [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_showView addSubview:_sureButton];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = ELALocalizedString(@"上届CR委员会任期已满，所有委员自动卸任离职。");
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = PingFangRegular(15);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:_titleLabel];
    [self setViewFrame];
}

- (void)setBg:(UIColor*)fclolr withToColor:(UIColor*)tcolor withView:(UIView*)view{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, view.width, view.height);
    gl.colors = @[(__bridge id)fclolr.CGColor,(__bridge id)tcolor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer addSublayer:gl];

}

- (void)setViewFrame
{

    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(0));
        make.top.bottom.equalTo(@(0));
    }];
    
    [_showView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_contentView);
        make.width.equalTo(@(285));
        make.height.equalTo(@(170));
    }];
    
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_contentView);
        make.width.equalTo(@(285));
        make.height.equalTo(@(170));
    }];
    
    [_closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_showView).offset(-10);
        make.top.equalTo(_showView).offset(10);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showView).offset(50);
        make.right.equalTo(_showView).offset(-50);
        make.top.equalTo(_closeButton.mas_bottom).offset(20);
    }];
    
    [_sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_titleLabel);
        make.bottom.equalTo(_showView).offset(-20);
        make.width.equalTo(@(190));
        make.height.equalTo(@(40));
    }];
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = ELALocalizedString(title);
  //  _title = title;
    [self setViewFrame];
}
- (void)showAlertView
{
    UIView *view = self;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
- (void)hideAlertView
{
    UIView *view = self;
    [view removeFromSuperview];
}

- (void)sureButtonAction:(id)sender
{
//    if(_block)
//    {
//        _block();
//    }
    [self hideAlertView];
}

- (void)closeButtonAction:(id)sender
{
    [self hideAlertView];
}

@end
