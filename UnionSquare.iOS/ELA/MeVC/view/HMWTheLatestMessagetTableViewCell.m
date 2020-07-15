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


#import "HMWTheLatestMessagetTableViewCell.h"

@interface HMWTheLatestMessagetTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *showInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *walletName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *messC;
@property (weak, nonatomic) IBOutlet UIView *spView;

@end

@implementation HMWTheLatestMessagetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showInfoLabel.text=NSLocalizedString(@"以上为最新消息", nil);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(HWMMessageCenterModel *)model{
    if (model.walletName.length==0) {
       self.spView.alpha=0.f;
        return;
    }
    self.walletName.text=model.walletName;
    self.time.text=model.timeString;
    self.messC.text=[NSString stringWithFormat:@"[%@] %@",[[FLTools share] EnquiryForDetailsWithTransactiontype:[model.MessageType intValue] withChainName:model.chainID],NSLocalizedString(model.MessageC, nil)];
    _model=model;
}
@end
