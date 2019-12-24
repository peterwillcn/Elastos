//
//  HMWVotingListView.h
//  ELA
//
//  Created by  on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
     NodeElectioType,
    CRType,
} VotingListType;

@protocol HMWVotingListViewDelegate <NSObject>

-(void)selectedVotingListWithIndex:(NSInteger)index;
-(void)VotingListisEdite:(BOOL)edite;
-(void)updateDataInfo;
@end


NS_ASSUME_NONNULL_BEGIN

@interface HMWVotingListView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lab1;
/*
 *<# #>
 */
@property (weak, nonatomic) IBOutlet UILabel *taglab1;

@property (weak, nonatomic) IBOutlet UILabel *taglab3;

@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property(weak,nonatomic)id<HMWVotingListViewDelegate>delegate;

@property(nonatomic,strong)NSMutableArray *dataSource;

/*
 *<# #>
 */
@property(assign,nonatomic)VotingListType type;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *typeString;



-(void)selectAllListWithIsSelect:(BOOL)isSelectAll;
-(void)AddAllTheCRList;


@end

NS_ASSUME_NONNULL_END
