//
//  assetsListModel.h
//  elastos wallet
//
//  Created by  on 2019/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface assetsListModel : NSObject
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *iconName;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *iconBlance;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *updateTime;
/*
 *<# #>
 */
@property(assign,nonatomic)double thePercentageCurr;
@property(assign,nonatomic)double thePercentageMax;
@property(assign,nonatomic)CGFloat thePercentFl;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *status;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *IP;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *ConnectionSpeed;
@end

NS_ASSUME_NONNULL_END
