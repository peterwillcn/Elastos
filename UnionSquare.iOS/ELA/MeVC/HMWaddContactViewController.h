//
//  HMWaddContactViewController.h
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "friendsModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, updateOrChangeInfo) {
   updateInfo = 0,
   ChangeInfo,
};

@interface HMWaddContactViewController : UIViewController
/*
 *<# #>
 */
@property(copy,nonatomic)friendsModel *model;
/*
 *<# #>
 */
@property(assign,nonatomic)updateOrChangeInfo  typeInfo;
@end

NS_ASSUME_NONNULL_END
