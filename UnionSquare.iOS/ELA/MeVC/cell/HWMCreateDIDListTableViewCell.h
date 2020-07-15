//
//  HWMCreateDIDListTableViewCell.h
//  elastos wallet
//
//  Created by  on 2019/10/21.
//

#import <UIKit/UIKit.h>

@protocol HWMCreateDIDListTableViewCellDelegate <NSObject>

-(void)deleteWithIndex:(NSString*_Nullable)index;

@end



NS_ASSUME_NONNULL_BEGIN



@interface HWMCreateDIDListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *intPutTextField;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property(copy,nonatomic)NSString *index;
@property (weak, nonatomic) IBOutlet UILabel *LimitThatLabel;
@property(weak,nonatomic)id<HWMCreateDIDListTableViewCellDelegate> delegate;
@property(assign,nonatomic)BOOL isEeiD;
@end

NS_ASSUME_NONNULL_END
