//
//  HWMSignStatusModel.h
//  elastos wallet
//
//  Created by  on 2019/9/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMSignStatusModel : NSObject
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *data;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *M;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *N;

/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isSignCom;
///*
// *<# #>
// */
@property(assign,nonatomic)BOOL isHowSign;
///*
// *<# #>
// */
@property(assign,nonatomic)NSUInteger Signers;

@end

NS_ASSUME_NONNULL_END
