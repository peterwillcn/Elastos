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


#import "HWMCommitteeMembersToVoteTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface HWMCommitteeMembersToVoteTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNamelLabel;
@property (weak, nonatomic) IBOutlet UILabel *contenInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@end

@implementation HWMCommitteeMembersToVoteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLable.alpha=0.f;
    [[HMWCommView share]makeBordersWithView:self.headImageView withCRRound:10.f];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setModel:(HWMVoteResultModel *)model{
    NSLog(@"%@---%@----%@",model.avatar,model.votedBy,model.reason);
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.nickNamelLabel.text=model.votedBy;
    self.contenInfoLabel.text=model.reason;
    
}
@end
