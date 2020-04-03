//
//  FLTableViewDefultCell.h
//  FLWALLET
//

#import <UIKit/UIKit.h>

@interface FLTableViewDefultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *subImag;
@property (weak, nonatomic) IBOutlet UISwitch *pwdSwitch;
@property (weak, nonatomic) IBOutlet UILabel *stastuLabel;

@end
