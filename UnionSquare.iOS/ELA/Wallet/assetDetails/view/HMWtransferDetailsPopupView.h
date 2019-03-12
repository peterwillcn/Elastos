//
//  HMWtransferDetailsPopupView.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/26.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, transferDetailsPopupViewType) {
   sideChainTop_UpType,
};
@protocol HMWtransferDetailsPopupViewDelegate <NSObject>

-(void)closeThePage;
-(void)pwdAndInfoWithPWD:(NSString*_Nullable)pwd;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HMWtransferDetailsPopupView : UIView
/*
 *<# #>
 */
@property(weak,nonatomic)id<HMWtransferDetailsPopupViewDelegate> delegate;
/*
 *<# #>
 */
@property(assign,nonatomic) transferDetailsPopupViewType type;
-(void)transferDetailsWithToAddress:(NSString*)address withTheAmountOf:(NSString*)amount withFee:(NSString*)fee;
@end

NS_ASSUME_NONNULL_END
