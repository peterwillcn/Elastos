//
//  HWMTransactionDetailsView.h
//  elastos wallet
//
//  Created by  on 2019/10/8.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger  {
    didInfoType
} TransactionDetailsType;

@protocol HWMTransactionDetailsViewDelegate <NSObject>
-(void)pwdAndInfoWithPWD:(NSString*)pwd;
-(void)closeTransactionDetailsView;


@end
@interface HWMTransactionDetailsView : UIView
/*
 *<# #>
 */
@property(weak,nonatomic)id<HWMTransactionDetailsViewDelegate> delegate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *popViewTitle;

/*
 *<# #>
 */
@property(assign,nonatomic)TransactionDetailsType DetailsType;
-(void)TransactionDetailsWithFee:(NSString*)fee withTransactionDetailsAumont:(NSString*)aumont;
@end


