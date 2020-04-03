//
//  FLAssetManageTableCell.h
//  FLWALLET
//
//  Created by  on 2018/4/26.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAllKindBi.h"
@protocol FLAssetManageTableCellDelegate <NSObject>
-(void)swichChange:(UISwitch*)swich model:(FLAllKindBi*)model;

@end

@interface FLAssetManageTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (nonatomic, strong)FLAllKindBi *data;
@property (nonatomic, weak)id <FLAssetManageTableCellDelegate>delegate;
@end
