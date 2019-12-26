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
@property(nonatomic,strong)NSArray *ActivData;
@property(copy,nonatomic)NSString * totalvotes;
@property(assign,nonatomic)MyVoteVotingListType VoteType;
@property(copy,nonatomic)NSString * persent;


@end

NS_ASSUME_NONNULL_END
