//
//  HWMCrCommitteeInformationHeaderView.h
//  elastos wallet
//
//  Created by  on 2020/3/26.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
#import "HWMCRListModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^block)(void);
@interface HWMCrCommitteeInformationHeaderView : UIView
@property(copy,nonatomic)void(^block)(void);
@property(strong,nonatomic)HWMDIDInfoModel *model;

@property(nonatomic,strong)HWMCRListModel *CRmodel;
@end

NS_ASSUME_NONNULL_END
