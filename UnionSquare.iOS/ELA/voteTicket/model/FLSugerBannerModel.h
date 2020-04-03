//
//  FLSugerBannerModel.h
//  FLWALLET
//
//  Created by  on 2018/7/12.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLSugerBannerModel : NSObject
@property (nonatomic, copy) NSString*idd;
@property (nonatomic, copy) NSString* imgUrl;
@property (nonatomic, copy) NSString* linkUrl;
@property (nonatomic, copy) NSString* uptDatetime;
@property (nonatomic, copy) NSString* gmtDatetime;
@property (nonatomic, assign) NSInteger channel;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger linkType;


@end
