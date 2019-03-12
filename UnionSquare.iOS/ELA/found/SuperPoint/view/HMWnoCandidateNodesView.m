//
//  HMWnoCandidateNodesView.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWnoCandidateNodesView.h"

@implementation HMWnoCandidateNodesView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWnoCandidateNodesView" owner:nil options:nil].firstObject;
    }
    
    return self;
    
    
}

@end
