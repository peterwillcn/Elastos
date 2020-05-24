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


#import "HWMCommentPerioDetailsHeadView.h"
#import "YYKit.h"
#import <YYKit/NSAttributedString+YYText.h>
@interface HWMCommentPerioDetailsHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *showOrHiddenButton;

@end

@implementation HWMCommentPerioDetailsHeadView

-(instancetype)init{
    self=[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMCommentPerioDetailsHeadView" owner:nil options:nil].firstObject;
        self.typeInfoLabel.text=NSLocalizedString(@"提案信息", nil);
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow"] forState:UIControlStateNormal];
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow_fold"] forState:UIControlStateSelected];
    }
    return self;
}
- (IBAction)showOrHiddenEvent:(id)sender {
    self.showOrHiddenButton.selected=!self.showOrHiddenButton.isSelected;
    if ([self.delegate respondsToSelector:@selector(closeCommentPerioDetailsOrOpen:)]) {
        [self.delegate closeCommentPerioDetailsOrOpen:self.showOrHiddenButton.isSelected];
    }
}

-(void)setModel:(HWMBillListModel *)model{
    self.titleLabel.text=model.title;
    self.stateLabel.text=model.status;
    self.timeLabel.text=model.baseInfoString;
    if (self.needMakeLine) {
        [self makeLine];
    }
//    if ([[self labletextNumberLine] intValue]>3) {
//        NSLog(@"需要超过三行");
//    }
    _model=model;
}
-(void)makeLine{
    NSUInteger length = [self.titleLabel.text length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)  range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, length)];
    [self.titleLabel setAttributedText:attri];
    
}
- (void)addSeeMoreButtonInLabel:(YYLabel *)label {
 
    label.attributedText = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:@{NSFontAttributeName :self.titleLabel.font}];

    NSString *moreString = @" 展开";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"... %@", moreString]];

    
 
    [text setTextHighlightRange:NSMakeRange(text.length-2,2)
                          color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                backgroundColor:[UIColor redColor]
                      tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//                      [weakSelf setFrame:YES];
                      }];
    text.font =self.titleLabel.font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
//    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.f alignment:YYTextVerticalAlignmentTop];
//
//    label.truncationToken = truncationToken;
}
-(NSNumber*)labletextNumberLine{
    NSNumber *count  = @((self.model.cellHeight) / self.titleLabel.font.lineHeight);
    return count;
    
}
@end
