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

NS_ASSUME_NONNULL_BEGIN
@interface HWMcommentModel : NSObject<NSCoding>
@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *reason;
@property(copy,nonatomic)NSString *votedBy;
@property(copy,nonatomic)NSString *createdAt;
@property(copy,nonatomic)NSString *opinion;
@property(assign,nonatomic)CGFloat reasonCell;
@property(copy,nonatomic)NSString *avatar;
@property(copy,nonatomic)NSString *createdBy;
@property(copy,nonatomic)NSString*commentContent;
@end
@interface HWMVoteResultModel : NSObject<NSCoding>
@property(copy,nonatomic)NSString *value;
@property(copy,nonatomic)NSString *reason;
@property(copy,nonatomic)NSString *votedBy;
@property(copy,nonatomic)NSString *avatar;
@property(assign,nonatomic)CGFloat reasonCell;
@property(copy,nonatomic)NSString *createdAt;
@property(copy,nonatomic)NSString *didName;
@property(copy,nonatomic)id  comment;
@property(copy,nonatomic)NSString*  content;
@property(copy,nonatomic)NSString* stage;
@property(strong,nonatomic)HWMcommentModel *commentModel;
@end
@interface HWMDetailsProposalModel : NSObject<NSCoding>
@property(copy,nonatomic)NSString *ID;
@property(copy,nonatomic)NSString *abstract;
@property(copy,nonatomic)NSString *address;
@property(copy,nonatomic)NSString *duration;
@property(copy,nonatomic)NSArray  *voteResult;
@property(copy,nonatomic)NSArray  *tracking;
@property(strong,nonatomic)NSArray *summary;
@property(copy,nonatomic)NSString *rejectAmount;
@property(copy,nonatomic)NSString *rejectHeight;
@property(copy,nonatomic)NSString *rejectPercentage;
@property(assign,nonatomic)CGFloat abstractCell;
@property(assign,nonatomic)CGFloat rejectRatio;
@property(strong,nonatomic)NSMutableArray  *agreeResult;
@property(strong,nonatomic)NSMutableArray  *againstResult;
@property(strong,nonatomic)NSMutableArray  *waiverResult;
@property(strong,nonatomic)NSMutableArray *trackingResult;
@property(copy,nonatomic)NSString *rejectThroughAmount;

@end

NS_ASSUME_NONNULL_END
