//
//  HMWtheWalletListTableViewCell.h
//  ELA
//
//  Created by  on 2018/12/28.
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
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *typeString;

@end

NS_ASSUME_NONNULL_END
