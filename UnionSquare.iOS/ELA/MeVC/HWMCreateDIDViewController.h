//
//  HWMCreateDIDViewController.h
//  elastos wallet
//
//  Created by  on 2019/10/21.
//

#import <UIKit/UIKit.h>

typedef void(^walletIDBlock)(NSString*didString);
 
NS_ASSUME_NONNULL_BEGIN

@interface HWMCreateDIDViewController : UIViewController
@property(copy,nonatomic)void(^walletIDBlock)(NSString*didString);
@end

NS_ASSUME_NONNULL_END
