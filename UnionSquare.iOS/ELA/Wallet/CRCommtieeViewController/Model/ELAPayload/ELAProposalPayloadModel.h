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
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELAProposalPayloadModel : NSObject

@property (nonatomic, assign) int Type;
@property (nonatomic, strong) NSString *CategoryData;
@property (nonatomic, strong) NSString *OwnerPublicKey;
@property (nonatomic, strong) NSString *DraftHash;
@property (nonatomic, strong) NSArray *Budgets;
@property (nonatomic, strong) NSString *Recipient;
@property (nonatomic, strong) NSString *Signature;
@property (nonatomic, strong) NSString *CRCouncilMemberDID;
//@property (nonatomic, strong) NSString *CRCouncilMemberSignature;


@end

@interface Budgets : NSObject
@property (nonatomic, assign) int Type;
@property (nonatomic, assign) int Stage;
@property (nonatomic, strong) NSString *Amount;

@end

NS_ASSUME_NONNULL_END


//{
//*    "Type": 0,                   // same as mention on method ProposalOwnerDigest()
//*    "CategoryData": "testdata",  // limit: 4096 bytes
//*    "OwnerPublicKey": "031f7a5a6bf3b2450cd9da4048d00a8ef1cb4912b5057535f65f3cc0e0c36f13b4", // Owner DID public key
//*    "DraftHash": "a3d0eaa466df74983b5d7c543de6904f4c9418ead5ffd6d25814234a96db37b0",
//*    "Budgets": [                 // same as mention on method ProposalOwnerDigest()
//*      {"Type":0,"Stage":0,"Amount":"300"},{"Type":1,"Stage":1,"Amount":"33"},{"Type":2,"Stage":2,"Amount":"344"}
//*    ],
//*    "Recipient": "EPbdmxUVBzfNrVdqJzZEySyWGYeuKAeKqv", // address
//*
//*    // signature of owner
//*    "Signature": "ff0ff9f45478f8f9fcd50b15534c9a60810670c3fb400d831cd253370c42a0af79f7f4015ebfb4a3791f5e45aa1c952d40408239dead3d23a51314b339981b76",
//*    "CRCouncilMemberDID": "icwTktC5M6fzySQ5yU7bKAZ6ipP623apFY",
//*    "CRCouncilMemberSignature": "ff0ff9f45478f8f9fcd50b15534c9a60810670c3fb400d831cd253370c42a0af79f7f4015ebfb4a3791f5e45aa1c952d40408239dead3d23a51314b339981b76"
//* }
