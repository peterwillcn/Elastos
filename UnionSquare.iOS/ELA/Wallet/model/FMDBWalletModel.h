//
//  FMDBWalletModel.h
//  elastos wallet
//
//  Created by  on 2019/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
   SingleSign=0,
    SingleSignReadonly=1,
    HowSign=2,
    HowSignReadonly=3
} walletSignType;

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
/*
 *
 */
@property(assign,nonatomic)walletSignType TypeW;
/*
 *
 */
@property(copy,nonatomic)NSString *didString;

@end

NS_ASSUME_NONNULL_END
