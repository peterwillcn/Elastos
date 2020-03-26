//
//  FLTableViewDefultCell.m
//  FLWALLET
//


#import "FLTableViewDefultCell.h"


@interface FLTableViewDefultCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation FLTableViewDefultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeBordersWithView:self.bgView];
    self.pwdSwitch.layer.borderColor=[UIColor whiteColor].CGColor;
    self.pwdSwitch.layer.borderWidth=2.f;
     self.pwdSwitch.layer.cornerRadius=15.f; self.pwdSwitch.layer.masksToBounds=YES;
     self.pwdSwitch.transform=CGAffineTransformMakeScale(0.75, 0.75);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
