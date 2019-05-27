//
//  HMWSideChainAndTheContactTableViewCell.h
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, sideChainAndTheContactType) {
    sideChainType,
    theContactType
};

@interface HMWSideChainAndTheContactTableViewCell : UITableViewCell
/*
 *<# #>
 */
@property(assign,nonatomic)sideChainAndTheContactType type;

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIView *BGView;

@property (weak, nonatomic) IBOutlet UILabel *iChinaLabel;
@end

NS_ASSUME_NONNULL_END
