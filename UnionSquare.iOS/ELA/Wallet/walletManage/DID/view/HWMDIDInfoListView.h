//
//  HWMDIDInfoListView.h
//  elastos wallet
//
//  Created by  on 2020/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HWMDIDInfoListViewDelegate <NSObject>

-(void)addInfoWithIndex:(NSString*)index;
-(void)closeView;

@end

@interface HWMDIDInfoListView : UIView
@property(strong,nonatomic)NSMutableArray *dataSourceArray;
@property(weak,nonatomic)id<HWMDIDInfoListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
