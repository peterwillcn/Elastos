//
//  HWMDIDInfoModel.h
//  elastos wallet
//
//  Created by  on 2019/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDInfoModel : NSObject
@property(copy,nonatomic)NSString *didName;
@property(copy,nonatomic)NSString *did;
@property(copy,nonatomic)NSString *nickname;
@property(copy,nonatomic)NSString *gender;//1男2nv
@property(copy,nonatomic)NSString *avatar;//头像
@property(copy,nonatomic)NSString *email;
@property(copy,nonatomic)NSString *phone;
@property(copy,nonatomic)NSString *phoneCode;
@property(copy,nonatomic)NSString *nation;//使用area code
@property(copy,nonatomic)NSString *introduction;// 简介
@property(copy,nonatomic)NSString *homePage;//主页

@property(copy,nonatomic)NSString *wechat;
@property(copy,nonatomic)NSString *twitter;
@property(copy,nonatomic)NSString *weibo;
@property(copy,nonatomic)NSString *facebook;
@property(copy,nonatomic)NSString *googleAccount;
@property(copy,nonatomic)NSString *editTime;


@property(copy,nonatomic)NSString *DateBirthString;

@property(copy,nonatomic)NSString *endString;
@end

NS_ASSUME_NONNULL_END
