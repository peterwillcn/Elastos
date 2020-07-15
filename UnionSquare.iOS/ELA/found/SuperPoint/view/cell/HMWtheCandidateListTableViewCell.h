//
//  HMWtheCandidateListTableViewCell.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol carCellDelegat <NSObject>

-(void)selecet:(FLCoinPointInfoModel*)model action:(NSInteger)action; //1加2减;

@end

@interface HMWtheCandidateListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *contryName;
@property (weak, nonatomic) IBOutlet UILabel *indexLab;
@property (weak, nonatomic) IBOutlet UILabel *percentLab;
@property (weak, nonatomic) IBOutlet UIButton *isSelectBtn;

@property(nonatomic,strong)FLCoinPointInfoModel *model;
@property(nonatomic,weak)id<carCellDelegat> delegate;

@end

NS_ASSUME_NONNULL_END
