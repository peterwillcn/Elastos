//
//  HWMaddSignThePursefootView.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/2.
//

#import "HWMaddSignThePursefootView.h"

@interface HWMaddSignThePursefootView ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmCreateButton;

@end

@implementation HWMaddSignThePursefootView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMaddSignThePursefootView" owner:nil options:nil].firstObject;
        [[HMWCommView share]makeBordersWithView:self.confirmCreateButton];
    }
    
    return self;
    
    
}
- (IBAction)addButtonAction:(id)sender {
}
- (IBAction)confirmCreateAction:(id)sender {
}

@end
