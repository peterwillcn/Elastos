//
//  HWExportCertificateMViewController.h
//  elastos wallet
//
//  Created by  on 2020/3/24.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWExportCertificateMViewController : UIViewController
@property(strong,nonatomic)HWMDIDInfoModel *model;
@property (nonatomic, strong)FLWallet *currentWallet;
@end

NS_ASSUME_NONNULL_END
