//
//  HWMaddSignThePurseViewTableViewCell.h
//  elastos wallet
//
//  Created by  on 2019/7/2.
//

#import <UIKit/UIKit.h>

@protocol HWMaddSignThePurseViewTableViewCellDeleagate <NSObject>

-(void)QrCodeIndex:(NSInteger)row;

@end

@interface HWMaddSignThePurseViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *signThePublicKeyTextField;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger row;
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMaddSignThePurseViewTableViewCellDeleagate> delegate ;
@end

