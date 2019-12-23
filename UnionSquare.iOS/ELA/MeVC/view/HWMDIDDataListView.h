//
//  HWMDIDDataListView.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/22.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, HWMDIDDataListViewType) {
    DIDDataType,
    genderType,
    birthdayType
    
};


@protocol HWMDIDDataListViewDelegate <NSObject>

-(void)cancelDataListView;
@optional
-(void)selectDataWithYY:(NSString*_Nullable)yy withMM:(NSString*_Nullable)mm wihMMWithInt:(NSInteger)mInt wtihDD:(NSString*_Nullable)dd;
-(void)selectGender:(NSUInteger)genderType;


@end

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDDataListView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMDIDDataListViewDelegate>delegate;
/*
 *<# #>
 */
@property(assign,nonatomic)HWMDIDDataListViewType ListViewType;
@end

NS_ASSUME_NONNULL_END
