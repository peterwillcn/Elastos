//
//  sideChainInfoModel.h
//  elastos wallet
//
//  Created by  on 2019/3/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface sideChainInfoModel : NSObject

/*
 *<# #>
 */
@property(copy,nonatomic)NSString * ID;

//walletID text,sideChainName text,sideChainNameTime text
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *walletID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *sideChainName;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *sideChainNameTime;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *thePercentageCurr;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *thePercentageMax;

@end

NS_ASSUME_NONNULL_END
