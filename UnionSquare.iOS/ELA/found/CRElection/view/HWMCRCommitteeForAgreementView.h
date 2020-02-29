//
//  HWMCRCommitteeForAgreementView.h
//  elastos wallet
//
//  Created by  on 2019/11/26.
//

#import <UIKit/UIKit.h>

@protocol HWMCRCommitteeForAgreementViewDelegate <NSObject>

-(void)closeView;
-(void)Agreed;
@end



NS_ASSUME_NONNULL_BEGIN

@interface HWMCRCommitteeForAgreementView : UIView
@property(strong,nonatomic)id<HWMCRCommitteeForAgreementViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
