//
//  WCQRCodeScanningVC.h
//  SGQRCodeExample
//
//  Created by kingsic on 17/3/20.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCQRCodeScanningVC : UIViewController
@property (nonatomic, copy)void(^scanBack)(NSString*addr);
/*
 *<# #>
 */
@property(strong,nonatomic)UIViewController *frVC;
@end
