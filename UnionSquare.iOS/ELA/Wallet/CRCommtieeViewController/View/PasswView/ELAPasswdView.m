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


#import "ELAPasswdView.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"

@interface ELAPasswdView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *othLine;

@property (nonatomic, strong) UITextField *textField;



@end

@implementation ELAPasswdView

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
    
    _bgButton = [[UIButton alloc] init];
    _bgButton.backgroundColor = [UIColor clearColor];
    [_bgButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_contentView addSubview:_bgButton];
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self setBg:ELARGB(83, 136, 136) withToColor:ELARGB(16, 47, 58) withView:bgImgView];
    bgImgView.alpha = 0.5;
    [_contentView addSubview:bgImgView];
    
    _showView = [[UIView alloc] init];
    [_contentView addSubview:_showView];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = ELARGB(29, 29, 29);
    [_showView addSubview:_bgView];
    
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setImage:ImageNamed(@"window_750_back") forState:(UIControlStateNormal)];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    _closeButton.contentMode = UIViewContentModeScaleAspectFit;
    [_showView addSubview:_closeButton];
//
    _sureButton = [[UIButton alloc] init];
    [_sureButton setTitle:ELALocalizedString(@"确定") forState:UIControlStateNormal];
    _sureButton.titleLabel.font = PingFangRegular(15);
    [_sureButton setBackgroundColor:ELARGB(54, 54, 54)];
    _sureButton.layer.cornerRadius = 5;
    _sureButton.layer.masksToBounds = YES;
    _sureButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _sureButton.layer.borderWidth = 1;
    [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_showView addSubview:_sureButton];
//
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = ELALocalizedString(@"输入密码");
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = PingFangRegular(17);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:_titleLabel];
    

    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor clearColor]; // 设置背景颜色
    _textField.textColor = [UIColor whiteColor]; // 设置文字的颜色
    _textField.clearsOnBeginEditing = YES;       // 当第二次输入的时候，清空上一次的内容
    _textField.font = PingFangRegular(15);// 设置字体的大小
    _textField.textAlignment = NSTextAlignmentLeft;// 设置文字的对其方式
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.secureTextEntry = YES;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    [self makeTextFieldPlaceHoTextColorWithTextField:_textField withTxt:NSLocalizedString(@"请输入钱包密码", nil)];
    [_showView addSubview:_textField];
 
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = ELARGB(149, 159, 171);//[UIColor whiteColor];
    [_showView addSubview:_line];
    
    _othLine = [[UIView alloc] init];
    _othLine.backgroundColor = ELARGB(149, 159, 171);//[UIColor whiteColor];
    [_showView addSubview:_othLine];
  
    [self setViewFrame];
}

- (void)setViewFrame
{

    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(0));
        make.top.bottom.equalTo(@(0));
    }];
    
    [_bgButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(0));
        make.top.bottom.equalTo(@(0));
    }];
    
    [_showView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.left.right.equalTo(@(0));
        make.height.equalTo(@(340));
        make.bottom.equalTo(@(0));
    }];
    
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_showView);
        make.left.right.equalTo(_showView);
        make.height.equalTo(_showView);
        make.bottom.equalTo(_showView);
    }];
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_showView);
        make.top.equalTo(_showView).offset(20);
    }];
    
    [_closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showView).offset(10);
        make.centerY.equalTo(_titleLabel).offset(0);
        make.width.equalTo(@(34));
        make.height.equalTo(@(34));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.right.equalTo(_showView);
        make.height.equalTo(@(0.5));
    }];
    
  
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showView).offset(15);
        make.right.equalTo(_showView).offset(-15);
        make.top.equalTo(_line.mas_bottom).offset(20);
        make.height.equalTo(@(30));
    }];
 
    [_othLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showView).offset(15);
        make.top.equalTo(_textField.mas_bottom).offset(20);
        make.right.equalTo(_showView).offset(-15);
        make.height.equalTo(@(0.5));
    }];
    
    [_sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_showView);
        make.bottom.equalTo(_showView).offset(-40);
        make.left.equalTo(_showView).offset(70);
        make.right.equalTo(_showView).offset(-70);
        make.height.equalTo(@(40));
    }];
}

- (void)makeTextFieldPlaceHoTextColorWithTextField:(UITextField *)textf withTxt:(NSString *)pText
{
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:pText attributes:@{NSForegroundColorAttributeName : RGBA(255, 255, 255, 0.5)}];
    textf.attributedPlaceholder = placeholderString;
}

- (void)setBg:(UIColor*)fclolr withToColor:(UIColor*)tcolor withView:(UIView*)view{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, view.width, view.height);
    gl.colors = @[(__bridge id)fclolr.CGColor,(__bridge id)tcolor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer addSublayer:gl];

}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = ELALocalizedString(title);
  //  _title = title;
    [self setViewFrame];
}
- (void)showAlertView:(UIView *)_view
{
    UIView *view = self;
    [_view addSubview:view];
}
- (void)hideAlertView
{
    UIView *view = self;
    [view removeFromSuperview];
}

- (void)sureButtonAction:(id)sender
{
    if(_valueBlock)
    {
        _valueBlock(_textField.text);
    }
}

- (void)closeButtonAction:(id)sender
{
    [self hideAlertView];
}

- (void)bgButtonAction:(id)sender
{
    if(_textField.isFirstResponder)
    {
        [_textField resignFirstResponder];
    }
}
- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    [_sureButton setTitle:ELALocalizedString(_buttonTitle) forState:UIControlStateNormal];
}
#pragma mark - delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];

    return YES;

}
@end

