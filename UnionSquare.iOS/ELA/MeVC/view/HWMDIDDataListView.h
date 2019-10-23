//
//  HWMDIDDataListView.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/22.
//

#import <UIKit/UIKit.h>

@protocol HWMDIDDataListViewDelegate <NSObject>



@end

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDDataListView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMDIDDataListViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
