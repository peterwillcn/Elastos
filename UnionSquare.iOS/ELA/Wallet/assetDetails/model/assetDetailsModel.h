//
//  assetDetailsModel.h
//  elastos wallet
//
//  Created by  on 2019/1/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface assetDetailsModel : NSObject
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *TxHash;
/*
 *Direction
 */
@property(copy,nonatomic)NSString *Direction;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *ConfirmStatus;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *Amount;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *Confirmed;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *Timestamp;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *Status;
/*
 *<# #>
 */
@property(copy,nonatomic)NSDictionary *Inputs;

/*
 *<# #>
 */
@property(copy,nonatomic)NSString *Fee;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *Remark;
/*
 *<# #>
 */
@property(copy,nonatomic)NSDictionary *Outputs;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *Type;

@property(copy,nonatomic)NSString *Height;
@property(copy,nonatomic)NSString *Address;
@property(copy,nonatomic)NSString *Memo;


@end

NS_ASSUME_NONNULL_END
