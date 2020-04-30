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

        
#import "HWMIPListTableViewCell.h"

@interface HWMIPListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *IPStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *portStringLabel;

@end

@implementation HWMIPListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)deleIPEvent:(id)sender {
    if (self.delegate) {
        [self.delegate delegIP:self.IPStringLabel.text delePort:self.portStringLabel.text withIndex:self.index];
    }
}
-(void)setDic:(NSDictionary *)dic{
    self.IPStringLabel.text=dic[@"ip"];
    self.portStringLabel.text=dic[@"port"];
}
- (void)setIndex:(NSIndexPath *)index{
    _index=index;
}
@end
