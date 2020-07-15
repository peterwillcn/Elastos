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
#import "ELATUpdateSecretaryDidTableViewCell.h"
#import "ELAUtils.h"
#import "Masonry.h"
#import "UIView+Ext.h"

@interface CheckBox : UIButton
@property (nonatomic, assign) BOOL isChecked;

@end
@implementation CheckBox

- (id)init
{
    self = [super init];
    if(self)
    {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self setImage:ImageNamed(@"authorization_empty") forState:(UIControlStateNormal)];
        [self setImage:ImageNamed(@"authorization_selected") forState:(UIControlStateSelected)];
    }
    return self;
}
- (void)setIsChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
    
    [self setSelected:_isChecked];
    
}

@end

@interface ELATUpdateSecretaryDidTableViewCell ()

@property (nonatomic, strong) CheckBox *checkBox;

@end
@implementation ELATUpdateSecretaryDidTableViewCell

- (void)dealloc
{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"ELATUpdateSecretaryDidTableViewCell";
    
    ELATUpdateSecretaryDidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[ELATUpdateSecretaryDidTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:infoView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = ELALocalizedString(@"");
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = PingFangRegular(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    [infoView addSubview:titleLabel];
    
    CheckBox *checkBox = [[CheckBox alloc] init];
    //checkBox.tag = self.tag;
    [checkBox addTarget:self action:@selector(checkBoxAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [infoView addSubview:checkBox];
    _titleLabel = titleLabel;
    _infoView = infoView;
    _checkBox = checkBox;
    
}

- (void)setIndex:(NSInteger)index
{
    _checkBox.tag = index;
    if(_checkBox.tag == 0)
    {
        [_checkBox setImage:ImageNamed(@"authorization_empty") forState:(UIControlStateNormal)];
        [_checkBox setImage:ImageNamed(@"authorization_locked") forState:(UIControlStateSelected)];
    }
    else
    {
        [_checkBox setImage:ImageNamed(@"authorization_empty") forState:(UIControlStateNormal)];
        [_checkBox setImage:ImageNamed(@"authorization_selected") forState:(UIControlStateSelected)];
    }
    _index = index;
}
//- (void)setTitle:(NSString *)title
//{
//    _title = title;
//    _titleLabel.text = ELALocalizedString(_title);
//    [self setCellFrame];
//}
//- (void)setIsChecked:(BOOL)isChecked
//{
//    _isChecked = isChecked;
//    _checkBox.isChecked = _isChecked;
//    [self setCellFrame];
//}

- (void)setCellFrame
{
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.contentView);
           make.right.equalTo(self.contentView);
           make.top.equalTo(self.contentView);
           make.height.equalTo(self.contentView);
           make.bottom.equalTo(self.contentView).offset(0);
       }];
       
       
       [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(_infoView).offset(15);
           make.right.equalTo(_checkBox.mas_left).offset(0);
           make.centerY.equalTo(_infoView);
           make.top.equalTo(_infoView).offset(10);
           make.bottom.equalTo(_infoView).offset(-10);
       }];
       
       [_checkBox mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(_infoView).offset(0);
           make.centerY.equalTo(_infoView);
           make.width.height.equalTo(@(68));
       }];
}

- (void)setModel:(ELATUpdateSecretaryDidModel *)model
{
    [self setCellFrame];
    _model = model;
    _titleLabel.text = _model.title;
    _checkBox.isChecked = _model.isChecked;
}
#pragma mark -

- (void)checkBoxAction:(id)sender
{
    CheckBox *checkBox = sender;
    if(checkBox.tag == 0)
    {
        return;
    }
    _model.isChecked = !checkBox.isChecked;
    checkBox.isChecked = _model.isChecked;
    
}
@end
