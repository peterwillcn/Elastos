//
//  HWMaddSignThePurseView.m
//  elastos wallet
//
//  Created by  on 2019/7/2.
//

#import "HWMaddSignThePurseView.h"


@interface HWMaddSignThePurseView ()

@end
@implementation HWMaddSignThePurseView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMaddSignThePurseView" owner:nil options:nil].firstObject;
        self.addPurseButton.layer.borderColor=RGBA(255, 255, 255, 0.5).CGColor;
        self.addPurseButton.layer.borderWidth=0.5;
        self.addPurseButton.layer.masksToBounds=YES;
        
        
    }
    
    return self;
    
    
}
@end
