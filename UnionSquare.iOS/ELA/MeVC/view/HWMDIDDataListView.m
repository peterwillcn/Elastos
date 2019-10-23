//
//  HWMDIDDataListView.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/22.
//

#import "HWMDIDDataListView.h"

@interface HWMDIDDataListView ()
@property (weak, nonatomic) IBOutlet UILabel *selectDataTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *makeSureTextLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPickerView;

@end


@implementation HWMDIDDataListView

-(instancetype)init{
    self =[super init];
    if (self) {

        self =[[NSBundle mainBundle]loadNibNamed:@"HWMDIDDataListView" owner:nil options:nil].firstObject;
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ancelThePage)];
        [self addGestureRecognizer:tag];
        self.dataPickerView.backgroundColor=[UIColor clearColor];
        [self.dataPickerView setValue:[UIColor whiteColor] forKey:@"textColor"];
    }
    return self;
}
-(void)ancelThePage{
    
    
}
- (IBAction)makeSureEvent:(id)sender {
}
@end
