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


#import "WYResyncChainDataTableViewCell.h"

@interface WYResyncChainDataTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *walletName;
@property (weak, nonatomic) IBOutlet UIButton *selectStatus;

@end

@implementation WYResyncChainDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[HMWCommView share] makeBordersWithView:self.bgView withCRRound:5.f];
    [self.selectStatus setImage:[UIImage imageNamed:@"asset_option_unchecked"] forState:UIControlStateNormal];
    [self.selectStatus setImage:[UIImage imageNamed:@"asset_option_checked"] forState:UIControlStateSelected];
}

- (IBAction)buttonPressedEvent:(id)sender {
    self.selectStatus.selected = !self.selectStatus.selected;
    if ([self.delegate respondsToSelector:@selector(selectStatus:withIndex:)]) {
        [self.delegate selectStatus:self.selectStatus.selected withIndex:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AddTheCurrencyListModel *)model {
    _model = model;
    self.walletName.text = model.nameIcon;
    self.selectStatus.selected = model.isAdd;
}

@end
