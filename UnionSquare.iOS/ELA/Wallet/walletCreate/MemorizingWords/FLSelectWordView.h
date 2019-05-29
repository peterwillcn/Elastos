//
//  FLSelectWordView.h
//  FLWALLET
//
//  Created by  on 2018/8/17.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WordModel : NSObject
@property (nonatomic, copy)NSString *word;
@property (nonatomic, assign)NSInteger state;
@end


@interface FLSelectWordView : UIView
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, copy)void(^callBack)(WordModel *model);
@property (nonatomic, copy)void(^sureBtnClick)(void);
-(void)canlceSelectWordModelWithWord:(NSString*)word;
@end


@interface FLSelectWordCollectCell : UICollectionViewCell
@property (nonatomic, strong)WordModel *model;
@property (weak, nonatomic) IBOutlet UILabel *wordLab;

@end


