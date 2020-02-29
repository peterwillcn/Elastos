//
//  nodeInformationDetailsView.h
//  elastos wallet
//
//  Created by  on 2019/6/24.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
#import "HWMCRListModel.h"
typedef enum : NSUInteger {
    CRCoinPointInfType,
    nodeCoinPointInfType
} CoinPointInfType;
@interface nodeInformationDetailsView : UIView
@property(nonatomic,strong)FLCoinPointInfoModel *model;
@property(nonatomic,strong)HWMCRListModel *CRmodel;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *countryRegionLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton
*copURLButton;
/*
 *<# #>
 */
@property(assign,nonatomic)CoinPointInfType type;
@end

