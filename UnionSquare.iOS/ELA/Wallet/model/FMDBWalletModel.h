//
//  FMDBWalletModel.h
//  elastos wallet
//
//  Created by  on 2019/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBWalletModel : NSObject
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *walletID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *walletAddress;
@property(copy,nonatomic)NSString *walletName;
@property(copy,nonatomic)NSString *balanceString;
/*
 *
 */
@property(copy,nonatomic)NSString *sideChainInformation;
@end

NS_ASSUME_NONNULL_END
