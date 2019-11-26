//
//  HMWinputVotesPopupWindowView.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol VotesPopupViewDelegate <NSObject>

-(void)didHadInputVoteTicket:(NSString*)ticketNumer WithIsMax:(BOOL)isMax;

@end

@interface HMWinputVotesPopupWindowView : UIView
@property(nonatomic,weak)id<VotesPopupViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *accountBalanceLab;
@property(nonatomic,assign)double votes;


@end

NS_ASSUME_NONNULL_END
