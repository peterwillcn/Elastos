//
//  HMWSendSuccessPopuView.h
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SendSuccessType) {
   sendDealType,         // slow at beginning and end
   saveSuccessType
    
   
};


NS_ASSUME_NONNULL_BEGIN

@interface HMWSendSuccessPopuView : UIView
@property(assign,nonatomic) SendSuccessType type;
@end

NS_ASSUME_NONNULL_END
