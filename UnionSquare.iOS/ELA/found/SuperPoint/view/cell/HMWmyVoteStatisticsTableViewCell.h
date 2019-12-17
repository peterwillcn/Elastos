//
//  HMWmyVoteStatisticsTableViewCell.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMWmyVoteStatisticsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftwidthCon;

@end

NS_ASSUME_NONNULL_END
