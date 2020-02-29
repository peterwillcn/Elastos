//
//  HWMDIDWalletListView.h
//  elastos wallet
//
//  Created by  on 2019/10/22.
//

#import <UIKit/UIKit.h>



@protocol HWMDIDWalletListViewDelegate <NSObject>

-(void)cancelDIDListViewView;
-(void)selectListIndex:(NSInteger)index;
@end


NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDWalletListView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *dataSourceArray;
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMDIDWalletListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
