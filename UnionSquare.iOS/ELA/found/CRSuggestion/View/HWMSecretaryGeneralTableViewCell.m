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


#import "HWMSecretaryGeneralTableViewCell.h"
#import "YYKit.h"
@interface HWMSecretaryGeneralTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *identity;
@property (weak, nonatomic) IBOutlet UIImageView *billHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *billNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *billContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *billTime;
@property (weak, nonatomic) IBOutlet UILabel *contLabel;
@property (weak, nonatomic) IBOutlet UILabel *staLabel;

@end


@implementation HWMSecretaryGeneralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.identity.layer.cornerRadius=2.f;
    self.identity.layer.borderWidth=0.5f;
    self.identity.layer.borderColor=RGBA(255, 255, 255, 0.5).CGColor;
    self.identity.layer.masksToBounds=YES;
    self.identity.text=NSLocalizedString(@" 秘书长 ", nil);
    self.billHeadImageView.layer.cornerRadius=9.f;
    self.billHeadImageView.layer.masksToBounds=YES;
    [self.contLabel sizeToFit];
    [self.billContentLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setPerformModel:(HWMVoteResultModel *)performModel{
    _performModel=performModel;
    CGRect fream=[self frame];
    [self.billHeadImageView sd_setImageWithURL:[NSURL URLWithString:performModel.avatar]];
    self.billNickNameLabel.text=performModel.didName;
    self.billContentLabel.text=performModel.content;
    self.billTime.text=performModel.createdAt;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:performModel.commentModel.avatar]];
    self.nickNameLabel.text=performModel.commentModel.createdBy;
    self.contLabel.text=performModel.commentModel.commentContent;
    self.timeLabel.text=performModel.commentModel.createdAt;
    self.staLabel.text=[[FLTools share]StageOfProcessing:performModel.stage];
    
    CGFloat billHeight=[self labelHeightWithLabel:self.billContentLabel WithMar:30];
    CGFloat contHeight=[self labelHeightWithLabel:self.contLabel WithMar:40];
    fream.size.height=billHeight+contHeight+90;
    
    [self setColorString];
    
}


-(void)setColorString{
//     跟踪审核意见
//    [赞同: 'APPROVED',
//    反对: 'REJECTED']
    NSString *opinionString;
    UIColor *bgC;
    if ([self.performModel.commentModel.opinion isEqualToString:@"APPROVED"]) {
        opinionString=NSLocalizedString(@"通过",nil);
        bgC=RGB(53, 176, 143);
    }else{
         opinionString=NSLocalizedString(@"否决",nil);
         bgC=RGB(176, 65, 53);
        
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",opinionString,self.performModel.commentModel.commentContent]];
    text.font = [UIFont boldSystemFontOfSize:10];
    text.color = [UIColor whiteColor];
    [text addAttribute:NSBackgroundColorAttributeName value:bgC
                 range:NSMakeRange(0, opinionString.length)];
  self.contLabel.attributedText = text;
}

-(CGFloat)labelHeightWithLabel:(UILabel*)label WithMar:(CGFloat)mar{
    CGSize constraintSize;
        constraintSize.width = AppWidth - mar;
        constraintSize.height = MAXFLOAT;
      CGSize sizeFrame = [self.billContentLabel.text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return sizeFrame.height;
}
@end
