//
//  HWMDIDAuthorizationHeadView.h
//  elastos wallet
//
//  Created by  on 2020/3/18.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDAuthorizationHeadView : UIView
@property(copy,nonatomic)NSDictionary *infoDic;
@property(strong,nonatomic)HWMDIDInfoModel *readModel;

@property(strong,nonatomic) NSString *nickNameString;
@end

NS_ASSUME_NONNULL_END
