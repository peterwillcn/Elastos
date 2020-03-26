//
//  HWMDIDAuthorizationTableViewCell.h
//  elastos wallet
//
//  Created by  on 2020/3/18.
//

#import <UIKit/UIKit.h>


typedef void(^selectBlock)(NSDictionary* _Nullable dic);

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDAuthorizationTableViewCell : UITableViewCell
@property (nullable,copy) void(^selectBlock)(NSDictionary* _Nullable dic);
@property(strong,nonatomic)NSMutableDictionary *dic;

@end

NS_ASSUME_NONNULL_END
