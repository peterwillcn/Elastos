//
//  DrawBackVoteMoneyVC.h
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/2/15.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
#import "HWMCRListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawBackVoteMoneyVC : UIViewController
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *CRTypeString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *nodeName;
@property(strong,nonatomic)FLCoinPointInfoModel *nodeModel;
@property(strong,nonatomic)HWMCRListModel *CRModel;

@end

NS_ASSUME_NONNULL_END
