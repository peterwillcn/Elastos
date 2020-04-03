//
//  FLtradeResultView.m
//  FLWALLET
//
//  Created by  on 2018/5/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLtradeResultView.h"

@implementation FLtradeResultView

- (IBAction)copyURL:(id)sender {
    
    if (self.tradeNumbLab.text.length>0) {
        [UIPasteboard generalPasteboard].string = self.tradeNumbLab.text;
        [[FLTools share]showErrorInfo:NSLocalizedString(@"已复制到剪贴板", nil)];
    }
}

@end
