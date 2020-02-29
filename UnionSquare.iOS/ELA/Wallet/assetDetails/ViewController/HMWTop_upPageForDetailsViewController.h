//
//  HMWTop_upPageForDetailsViewController.h
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assetsListModel.h"
typedef NS_ENUM(NSInteger, Top_upPageForDetailsType) {
    sideChainTop_upType,
   mainChainWithdrawalType
    
};


NS_ASSUME_NONNULL_BEGIN

@interface HMWTop_upPageForDetailsViewController : UIViewController

/*
 *<# #>
 */
@property(assign,nonatomic)Top_upPageForDetailsType type;
/*
 *<# #>
 */
@property(strong,nonatomic)NSIndexPath *selectIndex;
/*
 *<# #>
 */
@property(strong,nonatomic)assetsListModel *selectmModel;
/*
 *<# #>
 */
@property(strong,nonatomic)assetsListModel *fromModel;

/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *currentWallet;


/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *addressArray;
/*
 *主链提现  子链地址
 */
@property(copy,nonatomic)NSString *substringAddress;

@end

NS_ASSUME_NONNULL_END
