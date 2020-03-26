//
//  HWMDIDListAbnormalTableViewCell.h
//  elastos wallet
//
//  Created by  on 2019/10/30.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDListAbnormalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLeftConOff;
@property(strong,nonatomic)HWMDIDInfoModel *model;

@property(copy,nonatomic)NSString *titleString;
@end

NS_ASSUME_NONNULL_END
