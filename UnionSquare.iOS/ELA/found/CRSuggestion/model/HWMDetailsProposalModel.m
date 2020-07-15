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


#import "HWMDetailsProposalModel.h"
@implementation HWMcommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"commentContent": @"content"};
}

+ (void)goThroughAllProperty:(id)object propertyBlock:(void(^)(NSString *propertyName))propertyBlcok {
  u_int count;
  objc_property_t *propertyList = class_copyPropertyList([object class], &count);
  for (int i = 0; i < count; i++) {
    const char *propertyChar = property_getName(propertyList[i]);
    NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
    if (propertyBlcok) {
      propertyBlcok(propertyName);
    }
  }
  free(propertyList);
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
  __weak __typeof__ (self) weakSelf = self;
  [[self class] goThroughAllProperty:self propertyBlock:^(NSString *propertyName) {
    id value = [weakSelf valueForKey:propertyName];
    [aCoder encodeObject:value forKey:propertyName];
  }];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    __weak __typeof__ (self) weakSelf = self;
    [[self class] goThroughAllProperty:self propertyBlock:^(NSString *propertyName) {
      id value = [aDecoder decodeObjectForKey:propertyName];
      [weakSelf setValue:value forKey:propertyName];
    }];
  }
  return self;
}

@end
@implementation HWMVoteResultModel
+ (void)goThroughAllProperty:(id)object propertyBlock:(void(^)(NSString *propertyName))propertyBlcok {
  u_int count;
  objc_property_t *propertyList = class_copyPropertyList([object class], &count);
  for (int i = 0; i < count; i++) {
    const char *propertyChar = property_getName(propertyList[i]);
    NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
    if (propertyBlcok) {
      propertyBlcok(propertyName);
    }
  }
  free(propertyList);
}

#pragma mark NSCoding protocol
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
  __weak __typeof__ (self) weakSelf = self;
  [[self class] goThroughAllProperty:self propertyBlock:^(NSString *propertyName) {
    id value = [weakSelf valueForKey:propertyName];
    [aCoder encodeObject:value forKey:propertyName];
  }];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    __weak __typeof__ (self) weakSelf = self;
    [[self class] goThroughAllProperty:self propertyBlock:^(NSString *propertyName) {
      id value = [aDecoder decodeObjectForKey:propertyName];
      [weakSelf setValue:value forKey:propertyName];
    }];
  }
  return self;
}

@end
@implementation HWMDetailsProposalModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID": @"id",@"abstract":@"abs"};
}

+ (void)goThroughAllProperty:(id)object propertyBlock:(void(^)(NSString *propertyName))propertyBlcok {
  u_int count;
  objc_property_t *propertyList = class_copyPropertyList([object class], &count);
  for (int i = 0; i < count; i++) {
    const char *propertyChar = property_getName(propertyList[i]);
    NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
    if (propertyBlcok) {
      propertyBlcok(propertyName);
    }
  }
  free(propertyList);
}

#pragma mark NSCoding protocol
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
  __weak __typeof__ (self) weakSelf = self;
  [[self class] goThroughAllProperty:self propertyBlock:^(NSString *propertyName) {
      id value = [weakSelf valueForKey:propertyName];
    [aCoder encodeObject:value forKey:propertyName];
  }];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    __weak __typeof__ (self) weakSelf = self;
    [[self class] goThroughAllProperty:self propertyBlock:^(NSString *propertyName) {
      id value = [aDecoder decodeObjectForKey:propertyName];
      [weakSelf setValue:value forKey:propertyName];
    }];
  }
  return self;
}

@end
