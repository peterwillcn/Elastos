//
//  FLTools.h
//  FLWALLET
//
//  Created by  on 2018/4/19.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWMMessageCenterModel.h"
//待用
@interface FLFLUser : NSObject
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *loginId;
@property (nonatomic, copy)NSString *deviceId;
@property (nonatomic, copy)NSString *mobilePhone;
@property (nonatomic, copy)NSString *loginToken;
@property (nonatomic, copy)NSString *passWord;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *headImg;
@property (nonatomic, copy)NSString *borrmeUserId;
@property (nonatomic, assign)NSInteger certificated;
@property (nonatomic, assign)NSInteger  currencyType; //
@property (nonatomic, assign)NSInteger  CNTOCurrencyWallteIndex;
@property (nonatomic, copy)NSString * CNTOWallteWallteAddress;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *firstFriends;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *isNode;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *tradingPassword;
/*
 *
 */
@property(copy,nonatomic)NSString *areaCode;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *channelType;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *channelId;
@end
@interface FLWallet :NSObject
@property (nonatomic, copy)NSString *walletAddress;
@property (nonatomic, copy)NSString *privateKey;
@property (nonatomic, copy)NSString *keyStore;
@property (nonatomic, copy)NSString *walletName;
@property (nonatomic, copy)NSString *passWord;
@property (nonatomic, copy)NSString *balance;
@property (nonatomic,assign)NSInteger curretIndex;
@property (nonatomic, copy) NSString* mnemonic;
@property (nonatomic, copy)NSString *logoNumber;//indexIcion
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isSingleAddress;
@property (nonatomic, copy) NSString* mnemonicPWD;
@property (nonatomic, copy) NSString* walletID;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *masterWalletID;
@property (nonatomic, copy)NSString*signType;
@property(assign,nonatomic)NSInteger TypeW;
@property(assign,nonatomic)NSInteger M;
@property(assign,nonatomic)NSInteger N;
@property(assign,nonatomic)BOOL  HasPassPhrase;
@property (nonatomic, copy)NSString*didString;
@end

@class YYCache;
@interface FLTools : NSObject
@property (nonatomic,readonly)YYCache *cache;
@property (nonatomic, strong)FLFLUser *user;
@property(nonatomic,strong)FLWallet *SUPMTCurrencyWallte;

+(instancetype)share;
-(void)saveUserModel;
-(void)clearlist;
//-(NSMutableArray*)getWalletList;
- (NSString *)getTimeFromTimesTamp:(NSString *)timeStr;
//YYYY/MM/dd HH:mm:ss
- (NSString *)YMDHMSgetTimeFromTimesTamp:(NSString *)timeStr;
//
- (NSString *)CNTOYMDHMSgetTimeFromTimesTamp:(NSString *)timeStr;
-(void)showLoadingView;
-(void)showErrorInfo:(NSString*)info;
-(CGFloat)gasETHwithGasPrice:(NSString*)gasPrice withLimetPrice:(NSString*)LimetPrice;
-(BOOL)isNineKeyBoard:(NSString *)string;
- (BOOL)hasEmoji:(NSString*)string;
- (BOOL)stringContainsEmoji:(NSString *)string;
-(NSString *)notRounding:(NSString *)priceString afterPoint:(int)position;
-(BOOL)checkWhetherThePassword:(NSString*)passWord;
-(NSInteger)isStringContainTheLetterNumberSpecialCharactersWith:(NSString *)str;
//YYYY.MM.dd"
- (NSString *)YMDCommunityTimeConversionTimeFromTimesTamp:(NSString *)timeStr;

// YYYY.MM.dd HH:mm:ss
-(NSString *)YMDCommunityTimeConversToAllFromTimesTamp:(NSString *)timeStr;
-(NSString *)TimeFormatConversion:(NSString *)timeStr;
-(void)copiedToTheClipboardWithString:(NSString*)str;
-(NSString*)pastingTextFromTheClipboard;
-(BOOL)checkWalletName:(NSString*)walletName;
-(NSArray*)stringToArray:(NSString*)str;
-(NSString *)getNowTimeTimestamp;
-(NSString *)getRandomStringWithNum:(NSInteger)num;
-(NSString*)getCurrentTimes;
-(NSString *)formattermnemonicWord:(NSString *)string;
-(NSString*)elaScaleConversionWith:(NSString*)el;

-(NSString *)contryNameTransLateByCode:(NSInteger)code;
-(NSString *)elsToSela:(NSString*)ela;
-(BOOL)changeisEnglish:(NSString*)m;
-(NSDictionary *)getImageViewURLWithURL:(NSString*)urlString withCRString:(NSString*)CRS;
-(NSDictionary*)CreateQrCodeImage:(NSString*)contentString WithType:(NSString*)type withSubWalletIdChain:(NSString *)subW;
-(NSString*)DicToString:(NSDictionary*)dic;
- (UIImage*)imageWithSize:(CGFloat)size andColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andQRDic:(NSDictionary *)qrDic;
-(NSArray*)CreateArrayQrCodeImage:(NSString*)contentString WithType:(NSString*)type withSubWall:(NSString*)subW;
- (UIImage*)imageWithSize:(CGFloat)size andColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andQRString:( NSString*)qrString;
-(NSDictionary*)QrCodeImageFromDic:(NSString*)QrCodeString fromVC:(UIViewController*)VC oldQrCodeDic:(NSDictionary*)oldDic;
-(BOOL)SCanQRCodeWithDicCode:(NSDictionary*)dic;
-(NSString*)http_IpFast;
-(NSArray*)theInterceptionHttpWithArray:(NSArray*)array;
-(NSString*)WhetherTheCurrentTypeWithDataString:(NSString*)dataString withType:(NSString*)type;
-(NSDictionary*)DicFromJosnString:(NSString*)json;
-(BOOL)connectedToNetwork;
-(NSString *)returnJSONStringWithDictionary:(NSDictionary *)dictionary;
-(BOOL)WhetherTheCurrentTypeNeedType:(NSString*)dataString withType:(NSString*)type;
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
-(BOOL)APPIntegrity;
-(BOOL)allHasNameAndHas;
- (NSString*)timeSwitchTimestamp:(NSString *)formatTime;
-(NSString *)http_ipString:(NSString *)sdknet;
-(NSString*)http_transUrl:(NSString*)sdknet;
-(NSString*)http_PongUrl:(NSString*)sdknet;
-(NSString*)CRVotingPercentageWithAllCount:(NSString*)allcount withCRMermVoting:(NSString*)MermVot;
-(NSString*)CRVotingTheAverageDistribution:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout;
-(NSString*)CRVotingDecimalNumberBySubtracting:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout;
-(NSString*)CRVotingDecimalNumberByAdding:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout;
-(NSString*)CRVotingDecimalNumberByMultiplying:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout;
-(NSString*)DownTheValue:(NSString*)blance withLength:(NSInteger)MermVotCout;
-(NSString*)DownAlllTheValuePercentage:(NSString*)blance withLength:(NSInteger)MermVotCout;
-(NSString*)DownNumberPercentage:(NSString*)blance withLength:(NSInteger)MermVotCout;
-(BOOL)isBlankString:(NSString *)str;
-(NSString*)genderStringWithType:(NSString*)type;
-(NSString *)getNowTimeTimestampS;
-(NSString *)TimeFormatConversionBirthday:(NSString *)timeStr;
-(NSString*)getFileIndexCount:(NSString*)fielName;
-(NSString *)YMDWithDate:( NSDate *)myDate;
-(BOOL)textField:(UITextField *)textField replacementString:(NSString *)string withStringLenth:(NSInteger)length;
-(void)loadUrlSVGAndPNG:(NSString*)imageURL WithSuccessBlock:(void(^)(id data))successBlock;
-(NSString *)bytesToAvaiUnit:(NSString*)bytesString;
-(void)setMseeagPush:(NSString *)Push;
-(BOOL)readMseeagPush:(NSString *)Push;
-(BOOL)MseeagPRead:(NSString*)r;
-(void)setMMseeagPRead:(NSString*)r;
-(BOOL)hasMessageNeedRead:(NSString*)r;
-(void)sethasMessageNeedRead:(NSString*)r;
-(void)showNeMessageWith:(HWMMessageCenterModel*)mode;
- (NSString *)SpecialTimeZoneConversion:(NSString *)timeStr;
-(NSString*)EnquiryForDetailsWithTransactiontype:(NSInteger)type withChainName:(NSString*)chainID;
-(BOOL)IPcheckWithIP:(NSString*)ip;
-(BOOL)checkAndTheDomainName:(NSString*)Domain;
-(void)hideLoadingView;
-(NSString*)conversionMessserTime:(NSString*)messTime;
-(void)setLastReadTime;
-(NSInteger)readLastReadTime;
-(NSString*)DIDDefinTime;
-(NSInteger)GetMonthDaysWithYear:(NSString*)year WithMonth:(NSString*)month;
@end
