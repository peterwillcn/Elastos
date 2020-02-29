//
//  HWMDIDInfoModel.h
//  elastos wallet
//
//  Created by  on 2019/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDInfoModel : NSObject
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *expires;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *ID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *didName;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *operation;
/*
 *
 */
@property(copy,nonatomic)NSString *issuanceDate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *status;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *walletID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *did;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * PubKeyString;



/*
 *<# #>
 */
@property(copy,nonatomic)NSString *  nameString;

/*
 *<# #>
 */
@property(copy,nonatomic)NSString *  nickNameString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *  genderString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *  DateBirthString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * iconUrlString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * emailString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * MobilePhoneNoString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * areMobilePhoneNoString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * countriesString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSMutableDictionary * SocialAccountDic;

/*
 *<# #>
 */
@property(copy,nonatomic)NSString * introductionInfoString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * editTimeString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * infoTimeString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * IntroductionTimeString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString * socialAccountTimeString;


@end

NS_ASSUME_NONNULL_END
