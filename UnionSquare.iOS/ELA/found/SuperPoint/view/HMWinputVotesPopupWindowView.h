//
//  HMWinputVotesPopupWindowView.h
//  ELA
//
//  Created by 韩铭文 on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol VotesPopupViewDelegate <NSObject>

-(void)didHadInputVoteTicket:(NSString*)ticketNumer;

@end

@interface HMWinputVotesPopupWindowView : UIView
@property(nonatomic,weak)id<VotesPopupViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *accountBalanceLab;
@property(nonatomic,assign)NSInteger votes;


@end

NS_ASSUME_NONNULL_END
