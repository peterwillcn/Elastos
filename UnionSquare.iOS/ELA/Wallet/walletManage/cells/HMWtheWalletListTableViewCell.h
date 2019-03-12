//
//  HMWtheWalletListTableViewCell.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDBWalletModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface HMWtheWalletListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *selectView;
/*
 *<# #>
 */
@property(strong,nonatomic)FMDBWalletModel *model;

@end

NS_ASSUME_NONNULL_END
