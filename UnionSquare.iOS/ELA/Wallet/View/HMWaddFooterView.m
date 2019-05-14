//
//  HMWaddFooterView.m
//  ELA
//
//  Created by 韩铭文 on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWaddFooterView.h"


@interface HMWaddFooterView ()

@end
@implementation HMWaddFooterView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWaddFooterView" owner:nil options:nil].firstObject;
        self.backgroundColor=[UIColor clearColor];
    }
    
    return self;
    
    
}
- (IBAction)addTheAsset:(id)sender {
    
    if (self.delegate) {
        [self.delegate addTheAssetEvent];
    }
    
}
@end
