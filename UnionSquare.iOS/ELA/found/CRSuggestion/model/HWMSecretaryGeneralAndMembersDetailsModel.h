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
typedef enum : NSUInteger {
    COUNCILType,
    SECRETARIATType,
   ordinaryType
} GeneralAndMembersType;
NS_ASSUME_NONNULL_BEGIN
@interface HWMStermModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *didName;
@property (nonatomic, copy) NSString *voteResult;
@property (nonatomic, assign) NSInteger createdAt;

@end


@interface HWMSecretaryGeneralAndMembersDetailsModel : NSObject
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *did;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) NSInteger impeachmentVotes;
@property (nonatomic, assign) NSInteger impeachmentThroughAmount;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, copy) NSString *didName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * birthday;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * wechat;
@property (nonatomic, copy) NSString * weibo;
@property (nonatomic, copy) NSString * facebook;
@property (nonatomic, copy) NSString * microsoft;
@property (nonatomic, copy) NSString * startDate;
@property (nonatomic, copy) NSString * endDate;
@property (nonatomic, copy) NSString * impeachmentThroughVotes;
@property (nonatomic, copy) NSString *depositAmount;
@property (nonatomic, assign)GeneralAndMembersType  GMtype;
@property (nonatomic, copy) NSArray *term;
@end

NS_ASSUME_NONNULL_END
