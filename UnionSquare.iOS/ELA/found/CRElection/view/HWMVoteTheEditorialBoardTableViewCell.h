//
//  HWMVoteTheEditorialBoardTableViewCell.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/9/3.
//

#import <UIKit/UIKit.h>
#import "HWMCRListModel.h"


@interface HWMVoteTheEditorialBoardTableViewCell : UITableViewCell
/*
 *<# #>
 */
@property(strong,nonatomic)HWMCRListModel *model;

@property (weak, nonatomic) IBOutlet UITextField *numberVotingTextField;


@end
