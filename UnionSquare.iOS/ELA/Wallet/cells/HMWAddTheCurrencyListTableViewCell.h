//
//  HMWAddTheCurrencyListTableViewCell.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/28.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTheCurrencyListModel.h"
NS_ASSUME_NONNULL_BEGIN




@protocol HMWAddTheCurrencyListTableViewCellDelegate <NSObject>

-(void)isOpenOrCloseWithIndex:(NSIndexPath*)index;

@end

@interface HMWAddTheCurrencyListTableViewCell : UITableViewCell



/*
 *<# #>
 */
@property(strong,nonatomic)AddTheCurrencyListModel*model;


/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWAddTheCurrencyListTableViewCellDelegate> delegate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSIndexPath *index;

@end

NS_ASSUME_NONNULL_END
