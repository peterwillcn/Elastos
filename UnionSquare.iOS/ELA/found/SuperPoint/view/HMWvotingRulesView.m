//
//  HMWvotingRulesView.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWvotingRulesView.h"


@interface HMWvotingRulesView ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@end
@implementation HMWvotingRulesView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWvotingRulesView" owner:nil options:nil].firstObject;
        self.layer.cornerRadius=3.f;
        self.layer.masksToBounds=YES;
        self.lab1.text = NSLocalizedString(@"投票规则", nil);
        self.labInfo.text = NSLocalizedString(@"参与ELA超级节点投票，需锁仓ELA。投票不消耗ELA数量；\n\n每次投票最多可选择 30 个超级节点，撤销或更改再次投票生效有", nil);
    }

    return self;
    
    
}
- (IBAction)closeViewEvent:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(closeViewDele)]) {
        [self.delegate closeViewDele];
    }
}

@end
