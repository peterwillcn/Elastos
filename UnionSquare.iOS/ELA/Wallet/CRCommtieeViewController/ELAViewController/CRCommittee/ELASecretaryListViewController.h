//
//  ELASecretaryListViewController.h
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/12.
//  Copyright © 2020 64. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELACouncilAndSecretariatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELASecretaryListViewController : UIViewController


@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) ELACouncilAndSecretariatModel *infoModel;

- (void)creatViewWithInitFrame:(CGRect)frame;
- (void)reloadTableView;
@end

NS_ASSUME_NONNULL_END
