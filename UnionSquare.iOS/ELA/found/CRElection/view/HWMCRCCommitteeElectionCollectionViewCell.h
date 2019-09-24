//
//  HWMCRCCommitteeElectionCollectionViewCell.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/9/3.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMCRCCommitteeElectionCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)FLCoinPointInfoModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *SelectedImageView;

/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isEdiet;
@end

NS_ASSUME_NONNULL_END
