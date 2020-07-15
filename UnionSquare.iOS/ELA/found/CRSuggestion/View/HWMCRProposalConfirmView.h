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


#import <UIKit/UIKit.h>

@protocol HWMCRProposalConfirmViewDelgate <NSObject>

-(void)closeCRProposalConfirmView;
-(void)CRProposalConfirmWithPWD:(NSString*_Nonnull)PWD;

@end
typedef enum : NSUInteger {
    againstType,
    NOPperatingType,
    WaiverType,
    favorType,
    OpposingVotesType,
    ProposalLeadType,
    SecretaryGeneType,
    withdrawaType
    
} opinionType;

NS_ASSUME_NONNULL_BEGIN

@interface HWMCRProposalConfirmView : UIView

@property(assign,nonatomic)opinionType type;
@property(weak,nonatomic)id<HWMCRProposalConfirmViewDelgate> delegate;
-(void)postWithHash:(NSString*)hash withVotes:(NSString*)votes withFee:(NSString*)fee;
@end

NS_ASSUME_NONNULL_END
