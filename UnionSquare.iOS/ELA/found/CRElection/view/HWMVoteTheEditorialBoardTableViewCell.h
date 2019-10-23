//
//  HWMVoteTheEditorialBoardTableViewCell.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/9/3.
//

#import <UIKit/UIKit.h>
#import "HWMCRListModel.h"

@protocol  HWMVoteTheEditorialBoardTableViewCellDeleate<NSObject>

-(void)addVoteWithIndex:(NSIndexPath*)index withVotes:(NSString*)votes;
-(void)VoteValueChangeWithIndex:(NSIndexPath*)index withVotes:(NSString*)votes;

@end


@interface HWMVoteTheEditorialBoardTableViewCell : UITableViewCell
/*
 *<# #>
 */
@property(strong,nonatomic)HWMCRListModel *model;

@property (weak, nonatomic) IBOutlet UITextField *numberVotingTextField;
/*
 *<# #>
 */
@property(copy,nonatomic)NSIndexPath *index;
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMVoteTheEditorialBoardTableViewCellDeleate> deleagte;


@end
