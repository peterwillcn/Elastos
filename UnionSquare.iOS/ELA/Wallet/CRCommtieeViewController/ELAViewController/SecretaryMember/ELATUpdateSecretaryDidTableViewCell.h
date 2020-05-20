//
//  ELATUpdateSecretaryDidTableViewCell.h
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/13.
//  Copyright © 2020 64. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELATUpdateSecretaryDidModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^CheckedBlock)(NSInteger index);

@interface ELATUpdateSecretaryDidTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) ELATUpdateSecretaryDidModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
