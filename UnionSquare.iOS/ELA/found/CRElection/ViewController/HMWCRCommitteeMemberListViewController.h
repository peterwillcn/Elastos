//
//  HMWCRCommitteeMemberListViewController.h
//  elastos wallet
//
//  Created by  on 2019/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMWCRCommitteeMemberListViewController : UIViewController
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *typeString;
/*
 *
 */
@property(copy,nonatomic)NSString *CROwnerDID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *CROwnerPublicKey;
@property(copy,nonatomic)NSString *nodeName;
/*
 *
 */
@property(copy,nonatomic)NSString *CRnewDID;
/*
 *
 */
@property(assign,nonatomic)BOOL BondedDID;
@end

NS_ASSUME_NONNULL_END
