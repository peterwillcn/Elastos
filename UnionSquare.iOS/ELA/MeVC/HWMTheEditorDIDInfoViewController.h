//
//  HWMTheEditorDIDInfoViewController.h
//  elastos wallet
//
//  Created by  on 2019/10/31.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWMTheEditorDIDInfoViewController : UIViewController
@property(strong,nonatomic)HWMDIDInfoModel *model;
@property(copy,nonatomic)NSString *PubKeyString;
@property (nonatomic, strong)FLWallet *currentWallet;

@end

NS_ASSUME_NONNULL_END
