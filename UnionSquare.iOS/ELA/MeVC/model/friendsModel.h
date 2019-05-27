//
//  friendsModel.h
//  elastos wallet
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface friendsModel : NSObject
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *ID;

/*
 *<# #>
 */
@property(copy,nonatomic)NSString *nameString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *address;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *mobilePhoneNo;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *email;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *note;
@end

NS_ASSUME_NONNULL_END
