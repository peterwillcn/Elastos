//
//  HWMTheImportDocumentsViewController.h
//  elastos wallet
//
//  Created by  on 2020/2/14.
//

#import <UIKit/UIKit.h>


@protocol HWMTheImportDocumentsViewControllerDelegate <NSObject>

-(void)needUpLoadDataSource;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HWMTheImportDocumentsViewController : UIViewController
@property (nonatomic, strong)FLWallet *currentWallet;

@property (nonatomic, weak)id<HWMTheImportDocumentsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
