//
//  FLJoinToChoseTransferInfoView.h
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FLJoinToChoseTransferViewDelegate <NSObject>

-(void)nextBtnAction;
-(void)cancelShow;
//-(void)pwdAndInfoWithPWD:(NSString*_Nullable)pwd;
@end

@interface FLJoinToChoseTransferInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *tagTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *TagfeeLab;


@property (weak, nonatomic) IBOutlet UILabel *theAmountOfLabel;
@property (weak, nonatomic) IBOutlet UILabel *poundageLabel;
@property (weak, nonatomic) IBOutlet UIButton *theNextStepButton;
+(instancetype)defultView;
@property(weak,nonatomic)id<FLJoinToChoseTransferViewDelegate> delegate;
/*
*<# #>
*/
-(void)transferDetailsWithTheAmountOf:(NSString*)amount withFee:(NSString*)fee;
@end



NS_ASSUME_NONNULL_END
