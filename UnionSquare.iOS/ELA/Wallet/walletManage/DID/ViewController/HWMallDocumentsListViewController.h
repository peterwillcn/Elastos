//
//  HWMallDocumentsListViewController.h
//  elastos wallet
//
//  Created by  on 2020/3/24.
//

#import <UIKit/UIKit.h>

typedef void(^block)(NSString *flieName);
NS_ASSUME_NONNULL_BEGIN

@interface HWMallDocumentsListViewController : UIViewController
@property (nonatomic, strong)FLWallet *currentWallet;

@property(copy,nonatomic) void(^block)(NSString*flieName);
@end

NS_ASSUME_NONNULL_END
