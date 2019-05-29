//
//  FLSetMenmoryWordPassView.h
//  ELA
//
//  Created by 樊晓乐 on 2018/12/14.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FLSetMenmoryWordPassViewDelegate <NSObject>
-(void)theNextStepDWithPWD:(NSString*)pwd;


@end
@interface FLSetMenmoryWordPassView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<FLSetMenmoryWordPassViewDelegate> delegate;
/*
 *<# #>
 */
@property(strong,nonatomic)UIViewController *VC;

@end

