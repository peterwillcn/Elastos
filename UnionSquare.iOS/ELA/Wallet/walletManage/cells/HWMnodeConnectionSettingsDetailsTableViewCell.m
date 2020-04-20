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


#import "HWMnodeConnectionSettingsDetailsTableViewCell.h"

@interface HWMnodeConnectionSettingsDetailsTableViewCell()
@end

@implementation HWMnodeConnectionSettingsDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.connSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
    self.connSwitch.layer.borderWidth=2.f;
    self.connSwitch.layer.cornerRadius=15.f; self.connSwitch.layer.masksToBounds=YES;
    self.connSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)receivedOrAutomatic:(id)sender {
    if (self.index) {
        NSString *isOpen=@"0";
        if (self.connSwitch.on) {
            isOpen=@"1";
        }
        
        switch (self.index.row) {
            case 0:
                [[FLTools share]setMMseeagPRead:isOpen];
                break;
            case 1:
                [[FLTools share]setMseeagPush:isOpen];
                break;
                
            default:
                break;
        }
        return;
    }
    if (self.receivedOrAutomaticBlock) {
        self.receivedOrAutomaticBlock(self.connSwitch.on);
    }
}
-(void)setIndex:(NSIndexPath *)index{
    switch (index.row) {
        case 0:
            self.connSwitch.on=[[FLTools share]MseeagPRead:@""];
            
            break;
        case 1:
            self.connSwitch.on=[[FLTools share]readMseeagPush:@""];
            break;
            
        default:
            break;
    }
    _index=index;
}
@end
