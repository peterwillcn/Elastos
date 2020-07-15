//
//  HWMaddSignThePursefootView.m
//  elastos wallet
//
//  Created by  on 2019/7/2.
//

#import "HWMaddSignThePursefootView.h"

@implementation HWMaddSignThePursefootView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMaddSignThePursefootView" owner:nil options:nil].firstObject;
        self.userInteractionEnabled=YES;
        self.addButton.userInteractionEnabled=YES;
        self.confirmCreateButton.userInteractionEnabled=YES;
        [[HMWCommView share]makeBordersWithView:self.confirmCreateButton];
    }
    
    return self;
    
    
}


@end
