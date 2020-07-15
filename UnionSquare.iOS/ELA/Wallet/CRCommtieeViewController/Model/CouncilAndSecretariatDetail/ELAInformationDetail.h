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
#import "ELABaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELAInformationDetail : ELABaseModel


@property (nonatomic, assign) double impeachmentRatio;
@property (nonatomic, assign) double impeachmentThroughVotes;
@property (nonatomic, assign) double impeachmentVotes;

@property (nonatomic, strong) NSString *did;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *didName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray *term;
@property (nonatomic, strong) NSString *depositAmount;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, assign) double birthday;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *wechat;
@property (nonatomic, strong) NSString *weibo;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *microsoft;
@property (nonatomic, assign) double startDate;
@property (nonatomic, assign) double endDate;


@end

@interface ELATermModel : NSObject

@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *voteResult;

@property (nonatomic, assign) double createdAt;

@end

    
NS_ASSUME_NONNULL_END
