//
//  HMWAssetDetailsTableViewCell.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assetDetailsModel.h"
//NS_ASSUME_NONNULL_BEGIN

@interface HMWAssetDetailsTableViewCell : UITableViewCell
/*
 *
 */
@property(strong,nonatomic)assetDetailsModel *model;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *niceNameString;
@end

//NS_ASSUME_NONNULL_END
