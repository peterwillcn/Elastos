//
//  HWMallDocumentsListTableViewCell.h
//  elastos wallet
//
//  Created by  on 2020/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMallDocumentsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *flieNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *possibilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
