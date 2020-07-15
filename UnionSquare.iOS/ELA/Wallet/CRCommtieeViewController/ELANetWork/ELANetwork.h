//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import <Foundation/Foundation.h>
#import "HWMCRSuggestionNetWorkManger.h"

#define ERRORDESC (ELALocalizedString(@"Unknown Error"))

NS_ASSUME_NONNULL_BEGIN


@interface ELANetwork : NSObject


/// 查询历届CR委员会相关信息 
+ (NSURLSessionDataTask *)getCommitteeInfo:(void (^) (id data, NSError *error))block;

/// 查询某届CR委员会委员列表
/// @param _id  id  第几届
/// @param block 回调
+ (NSURLSessionDataTask *)getCouncilListInfo:(NSInteger)_id block:(void (^) (id data, NSError *error))block;


/// 查询CR委员或秘书长详细信息
/// @param did  委员DID
/// @param _id 第几届 [默认当届]
/// @param block 回调
+ (NSURLSessionDataTask *)getInformation:(NSString *)did ID:(NSInteger)_id block:(void (^) (id data, NSError *error))block;

/// 2.1)dpos列表
+ (NSURLSessionDataTask *)listproducer:(NSString *)state moreInfo:(NSInteger)moreInfo block:(void (^) (id data, NSError *error))block;

///crc列表是否存在
+ (NSURLSessionDataTask *)listcrcandidates:(NSString *)state  block:(void (^) (id data, NSError *error))block;

///
+ (NSURLSessionDataTask *)cvoteAllSearch:(NSString *)searchString  page:(NSInteger)page  results:(NSInteger)results type:(CommunityProposalType)type  block:(void (^) (id data, NSError *error))block;
@end

NS_ASSUME_NONNULL_END
