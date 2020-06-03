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

#import "ELAImpeachView.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"

@interface ELAImpeachView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *otherTitleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *subLine;
@property (nonatomic, strong) UIView *otherLine;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *otherTextField;

@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *othUnitLabel;

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
    
    _bgButton = [[UIButton alloc] init];
    _bgButton.backgroundColor = [UIColor clearColor];
    [_bgButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_contentView addSubview:_bgButton];
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self setBg:ELARGB(83, 136, 136) withToColor:ELARGB(16, 47, 58) withView:bgImgView];
    [_contentView addSubview:bgImgView];
    
    _showView = [[UIView alloc] init];
    [_contentView addSubview:_showView];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = ELARGB(29, 29, 29);
    [_showView addSubview:_bgView];
    
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setImage:ImageNamed(@"window_54_close") forState:(UIControlStateNormal)];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    _closeButton.contentMode = UIViewContentModeScaleAspectFit;
    [_showView addSubview:_closeButton];
//
    _sureButton = [[UIButton alloc] init];
    [_sureButton setTitle:ELALocalizedString(@"下一步") forState:UIControlStateNormal];
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
    _titleLabel.text = ELALocalizedString(@"弹劾");
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = PingFangRegular(17);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:_titleLabel];
    
    _subTitleLabel = [[UILabel alloc] init];
    _subTitleLabel.text = ELALocalizedString(@"弹劾票数");
    _subTitleLabel.numberOfLines = 0;
    _subTitleLabel.font = PingFangRegular(15);
    _subTitleLabel.textColor = [UIColor whiteColor];
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:_subTitleLabel];
    
    _otherTitleLabel = [[UILabel alloc] init];
    _otherTitleLabel.text = ELALocalizedString(@"手续费");
    _otherTitleLabel.numberOfLines = 0;
    _otherTitleLabel.font = PingFangRegular(15);
    _otherTitleLabel.textColor = [UIColor whiteColor];
    _otherTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:_otherTitleLabel];
    
    _unitLabel = [[UILabel alloc] init];
    _unitLabel.text = ELALocalizedString(@"ELA");
    _unitLabel.numberOfLines = 0;
    _unitLabel.font = PingFangRegular(17);
    _unitLabel.textColor = [UIColor whiteColor];
    _unitLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:_unitLabel];
    
    _othUnitLabel = [[UILabel alloc] init];
    _othUnitLabel.text = ELALocalizedString(@"ELA");
    _othUnitLabel.numberOfLines = 0;
    _othUnitLabel.font = PingFangRegular(15);
    _othUnitLabel.textColor = [UIColor whiteColor];
    _othUnitLabel.textAlignment = NSTextAlignmentCenter;
    [_showView addSubview:_othUnitLabel];
    
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor clearColor]; // 设置背景颜色
    _textField.textColor = [UIColor whiteColor]; // 设置文字的颜色
    _textField.clearsOnBeginEditing = YES;       // 当第二次输入的时候，清空上一次的内容
    _textField.font = PingFangRegular(15);// 设置字体的大小
    _textField.textAlignment = NSTextAlignmentRight;// 设置文字的对其方式
    _textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _textField.returnKeyType = UIReturnKeyDone;
//    _textField.secureTextEntry = YES;
    _textField.delegate = self;
    [self makeTextFieldPlaceHoTextColorWithTextField:_textField withTxt:@"XXL"];
    [_showView addSubview:_textField];
    
    _otherTextField = [[UITextField alloc] init];
    _otherTextField.backgroundColor = [UIColor clearColor]; // 设置背景颜色
    _otherTextField.textColor = [UIColor whiteColor]; // 设置文字的颜色
    _otherTextField.clearsOnBeginEditing = YES;       // 当第二次输入的时候，清空上一次的内容
    _otherTextField.font = PingFangRegular(15);// 设置字体的大小
    _otherTextField.textAlignment = NSTextAlignmentRight;// 设置文字的对其方式
    _otherTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _otherTextField.enabled = NO;
    //    _textField.secureTextEntry = YES;
    //    _textField.delegate = self;
//    [self makeTextFieldPlaceHoTextColorWithTextField:_textField withTxt:@"XXL"];
    _otherTextField.text = ELAFEE;
    [_showView addSubview:_otherTextField];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = ELARGB(149, 159, 171);//[UIColor whiteColor];
    [_showView addSubview:_line];
    
    _subLine = [[UIView alloc] init];
    _subLine.backgroundColor = ELARGB(149, 159, 171);//[UIColor whiteColor];
    [_showView addSubview:_subLine];
          
    _otherLine = [[UIView alloc] init];
    _otherLine.backgroundColor = ELARGB(149, 159, 171);//[UIColor whiteColor];
    [_showView addSubview:_otherLine];
    
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
    
    [_subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showView).offset(15);
        
        make.top.equalTo(_line.mas_bottom).offset(20);
    }];
    
    [_unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_showView).offset(-15);
        make.centerY.equalTo(_subTitleLabel).offset(0);
    }];
    
    [_othUnitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_showView).offset(-15);
        make.centerY.equalTo(_otherTitleLabel).offset(0);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_unitLabel.mas_left).offset(-5);
        make.width.equalTo(@(300));
        make.centerY.equalTo(_subTitleLabel);
        make.height.equalTo(@(30));
    }];
    
    [_otherTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_othUnitLabel.mas_left).offset(-5);
        make.width.equalTo(@(300));
        make.centerY.equalTo(_otherTitleLabel);
    }];
    
    [_subLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_subTitleLabel.mas_left);
        make.top.equalTo(_subTitleLabel.mas_bottom).offset(20);
        make.right.equalTo(_showView);
        make.height.equalTo(@(0.5));
    }];
    
    [_otherTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(_showView).offset(15);
          make.top.equalTo(_subLine.mas_bottom).offset(20);
      }];
    
    [_otherLine mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(_otherTitleLabel.mas_left);
           make.top.equalTo(_otherTitleLabel.mas_bottom).offset(20);
           make.right.equalTo(_showView);
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

- (void)setAmount:(NSString *)amount
{
    _amount = amount;
    [self makeTextFieldPlaceHoTextColorWithTextField:_textField withTxt:_amount];
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
- (void)setType:(int)type
{
    _type = type;
    if(_type == 1)//提取质押金
    {
        _textField.enabled = NO;
        _textField.text = _amount;
        _titleLabel.text =  ELALocalizedString(@"质押金");
        _subTitleLabel.text = ELALocalizedString(@"质押金");
        _otherTextField.text = _fee;
        
    }
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
   // [[UIApplication sharedApplication].keyWindow addSubview:view];
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
