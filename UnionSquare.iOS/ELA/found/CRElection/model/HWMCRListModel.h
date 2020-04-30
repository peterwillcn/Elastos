//
//  HWMCRListModel.h
//  elastos wallet
//
//  Created by  on 2019/9/25.
//

#import <Foundation/Foundation.h>
#import "HWMDIDInfoModel.h"



@interface HWMCRListModel : NSObject
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *location;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *index;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *did;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *nickname;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *code;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *votes;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *voterate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *state;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *url;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *iconImageUrl;

@property(nonatomic,copy)NSString *ownerpublickey;
@property(nonatomic,assign)BOOL isCellSelected;
@property(nonatomic,assign)BOOL isNewCellSelected;
@property(nonatomic,copy)NSString * SinceVotes;
/*
 *<# #>
 */
//@property(assign,nonatomic)NSInteger   index;

/*
 *<# #>
 */
@property(copy,nonatomic)NSString *infoEN;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *infoZH;
@property(nonatomic,copy)NSString * TextVotes;
@property(nonatomic,copy)NSString *cid;

@property(copy,nonatomic)HWMDIDInfoModel *didIndoModel;

@end

