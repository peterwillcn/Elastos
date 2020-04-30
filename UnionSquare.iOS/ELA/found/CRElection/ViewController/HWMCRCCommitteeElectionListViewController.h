//
//  HWMCRCCommitteeElectionListViewController.h
//  elastos wallet
//
//  Created by  on 2019/9/5.
//

#import <UIKit/UIKit.h>

@protocol HWMCRCCommitteeElectionListViewControllerDelegate <NSObject>

-(void)needUpdataSta;

@end


NS_ASSUME_NONNULL_BEGIN

@interface HWMCRCCommitteeElectionListViewController : UIViewController

@property(nonatomic,copy)NSString *persent;
@property(nonatomic,copy)NSString *totalvotes;
@property(nonatomic,copy)NSArray *lastArray;
@property(nonatomic,weak)id<HWMCRCCommitteeElectionListViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
