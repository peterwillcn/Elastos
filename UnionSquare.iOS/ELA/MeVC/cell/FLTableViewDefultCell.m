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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
