//
//  HMWVotingListTypeCrossCollectionViewCell.h
//  elastos wallet
//
//  Created by  on 2019/6/17.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
#import "HWMCRListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMWVotingListTypeCrossCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)FLCoinPointInfoModel *model;
@property(nonatomic,strong)HWMCRListModel *CRModel;
@end

NS_ASSUME_NONNULL_END
