//
//  sideChainInfoModel.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/3/6.
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
@end

NS_ASSUME_NONNULL_END
