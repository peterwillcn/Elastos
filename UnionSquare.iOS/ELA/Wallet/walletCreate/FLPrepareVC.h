//
//  FLPrepareVC.h
//  FLWALLET
//
//  Created by  on 2018/4/18.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FROMETYPE) {
    addWalletType,
    creatWalletType,
    
};

@interface FLPrepareVC : UIViewController
/*
 *<# #>
 */
@property(assign,nonatomic)FROMETYPE type;
@end
