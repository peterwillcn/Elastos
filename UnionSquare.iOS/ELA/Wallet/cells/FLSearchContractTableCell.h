//
//  FLSearchContractTableCell.h
//  FLWALLET
//
//  Created by  on 2018/6/28.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAllKindBi.h"

@interface FLSearchContractTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UILabel *addrLab;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;

@property (nonatomic, strong)FLAllKindBi *data;

@end
