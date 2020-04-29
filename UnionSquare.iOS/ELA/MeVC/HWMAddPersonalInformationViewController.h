//
//  HWMAddPersonalInformationViewController.h
//  elastos wallet
//
//  Created by  on 2019/10/25.
//

#import <UIKit/UIKit.h>
#import "HWMDIDInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^successBlock)(NSString*DIDString);

@interface HWMAddPersonalInformationViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)HWMDIDInfoModel *model;


/*
 *<# #>
 */
@property(assign,nonatomic)Boolean  isEidet;
/*
 *<# #>
 */
@property(assign,nonatomic)Boolean  whereFrome;
@property (nonatomic, strong)FLWallet *currentWallet;

@property(copy,nonatomic)void(^successBlock)(NSString*DIDString);
/*
 *<# #>
 */
@property(assign,nonatomic)Boolean  noAleart;
@end

NS_ASSUME_NONNULL_END
