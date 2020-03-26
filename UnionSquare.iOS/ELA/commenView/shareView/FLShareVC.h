//
//  FLShareVC.h
//  FLWALLET
//
//  Created by  on 2018/9/21.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FLShareVC : UIViewController
@property (nonatomic, copy)NSString *shareContent;
@end

@interface FLShareModel : NSObject
@property (nonatomic, copy)NSString *UrlScheme;
@property (nonatomic, assign)NSInteger sharePlant;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *plantName;

@end
