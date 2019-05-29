//
//  FLCopyPrivateKeyView.m
//  FLWALLET
//
//  Created by  on 2018/5/18.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLCopyPrivateKeyView.h"

@implementation FLCopyPrivateKeyView
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.contentView setBackgroundColor:nil boldColor:nil corner:8];
    [self.textView setBackgroundColor:nil boldColor:defultTextThemeColor corner:8];
}
- (IBAction)removeIt:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)copy:(id)sender {
    [UIPasteboard generalPasteboard].string = self.textView.text;
    [[FLTools share]showErrorInfo:NSLocalizedString(@"私钥已复制成功", nil)];
    [self removeFromSuperview];

}

@end
