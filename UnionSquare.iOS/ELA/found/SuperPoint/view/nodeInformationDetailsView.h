//
//  nodeInformationDetailsView.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/6/24.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface nodeInformationDetailsView : UIView
@property(nonatomic,strong)FLCoinPointInfoModel *model;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *countryRegionLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton
*copURLButton;
@end

NS_ASSUME_NONNULL_END
