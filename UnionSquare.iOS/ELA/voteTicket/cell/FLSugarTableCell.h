//
//  FLSugarTableCell.h
//  FLWALLET
//
//  Created by  on 2018/7/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLSugarModel.h"


@interface FLSugarTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shadowIma;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *iconIamge;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *describLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong)FLSugarModel *model;
@end
