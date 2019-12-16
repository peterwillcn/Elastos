//
//  FLCoinPointInfoModel.h
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLCoinPointInfoModel : NSObject
@property(nonatomic,copy)  NSString    *ownerpublickey;
@property(nonatomic,copy)  NSString    *nodepublickey;
@property(nonatomic,copy)  NSString    *nickname;
@property(nonatomic,copy)  NSString    *url;
@property(nonatomic,copy)  NSString    *votes;
@property(nonatomic,copy)  NSString    *netaddress;
@property(nonatomic,copy)  NSString    *location;
@property(nonatomic,assign)NSInteger    active;
@property(nonatomic,assign)NSInteger   index;
@property(nonatomic,assign)NSInteger   hadVotedNumber;
@property(nonatomic,copy)  NSString    *voterate;
@property(nonatomic,copy)  NSString    *iconImageUrl;

@property(nonatomic,assign)BOOL isCellSelected;
@property(nonatomic,assign)BOOL isNewCellSelected;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *infoEN;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *infoZH;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *state;


@end

NS_ASSUME_NONNULL_END
