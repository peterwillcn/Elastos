//
//  HMWMyVoteViewController.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
     MyVoteNodeElectioType,
    MyVoteCRType,
} MyVoteVotingListType;


NS_ASSUME_NONNULL_BEGIN

@interface HMWMyVoteViewController : UIViewController
@property(nonatomic,strong)NSArray *listData;
@property(assign,nonatomic)MyVoteVotingListType type;
@end

NS_ASSUME_NONNULL_END
