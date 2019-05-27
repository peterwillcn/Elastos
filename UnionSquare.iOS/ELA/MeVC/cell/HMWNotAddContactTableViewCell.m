//
//  HMWNotAddContactTableViewCell.m
//  ELA
//

#import "HMWNotAddContactTableViewCell.h"


@interface HMWNotAddContactTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (weak, nonatomic) IBOutlet UILabel *addShowInfoLabel;

@end

@implementation HMWNotAddContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[HMWCommView share]makeBordersWithView:self.BGView];
    self.addShowInfoLabel.text=NSLocalizedString(@"您尚未添加联系人", nil);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
