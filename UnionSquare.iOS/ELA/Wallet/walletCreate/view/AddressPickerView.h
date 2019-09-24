//
//  AddressPickerView.h
//  
//
//
//

#import <UIKit/UIKit.h>

@protocol  AddressPickerViewDelegate<NSObject>

-(void)sureActionWithNumber:(NSString*)number;
-(void)closePickerView;

@end

@interface AddressPickerView : UIView
/*
 *<# #>
 */
@property(weak,nonatomic)id<AddressPickerViewDelegate> delegate;
@end
