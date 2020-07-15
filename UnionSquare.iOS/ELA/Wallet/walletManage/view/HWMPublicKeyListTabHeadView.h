//
//  HWMPublicKeyListTabHeadView.h
//  elastos wallet
//
//  Created by  on 2019/9/10.
//

#import <UIKit/UIKit.h>





typedef NS_ENUM(NSInteger,ListTabHeadType){
    LocalPublicKeyType,
    ParticipatePublicKeyType
    
};




@interface HWMPublicKeyListTabHeadView : UIView
/*
 *<# #>
 */
@property(assign,nonatomic)ListTabHeadType type;
@end
