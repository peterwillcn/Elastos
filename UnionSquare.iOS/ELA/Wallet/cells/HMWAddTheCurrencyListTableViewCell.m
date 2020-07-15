//
//  HMWAddTheCurrencyListTableViewCell.m
//  ELA
//
//  Created by  on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWAddTheCurrencyListTableViewCell.h"


@interface HMWAddTheCurrencyListTableViewCell ()
@property (weak, nonatomic) IBOutlet UISwitch *isAddSwitch;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;


@end

@implementation HMWAddTheCurrencyListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.isAddSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
    self.isAddSwitch.layer.borderWidth=2.f;
    self.isAddSwitch.layer.cornerRadius=15.f; self.isAddSwitch.layer.masksToBounds=YES;
    self.isAddSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
}
-(void)setModel:(AddTheCurrencyListModel *)model{
    _model=model;
    self.nickNameLabel.text=model.nameIcon;
    
    if ([model.nameIcon isEqualToString:@"ELA"]) {
        self.isAddSwitch.alpha=0.f;
        self.changeButton.alpha=0.f;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                
        [self.isAddSwitch setOn:model.isAdd animated:NO];
    });
   
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)isAddOrCloseEvent:(id)sender {
    
//    if ([self.delegate respondsToSelector:@selector(isOpenOrCloseWithIndex:)]) {
//        [self.delegate isOpenOrCloseWithIndex:self.index];
//    }
}
-(void)setIndex:(NSIndexPath *)index{
    _index=index;
    
}
- (IBAction)needChangedValue:(id)sender {
    if ([self.delegate respondsToSelector:@selector(isOpenOrCloseWithIndex:)]) {
        [self.delegate isOpenOrCloseWithIndex:self.index];
    }
}
@end
