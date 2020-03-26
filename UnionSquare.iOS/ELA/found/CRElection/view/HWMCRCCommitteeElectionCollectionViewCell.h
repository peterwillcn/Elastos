//
//  HWMCRCCommitteeElectionCollectionViewCell.h
//  elastos wallet
//
//  Created by  on 2019/9/3.
//

#import <UIKit/UIKit.h>
#import "HWMCRListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMCRCCommitteeElectionCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)HWMCRListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *SelectedImageView;


/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isEdiet;
@end

NS_ASSUME_NONNULL_END
