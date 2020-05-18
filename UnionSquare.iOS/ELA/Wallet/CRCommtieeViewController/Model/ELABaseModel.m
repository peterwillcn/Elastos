//
//  ELABaseModel.m
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/14.
//  Copyright © 2020 64. All rights reserved.
//

#import "ELABaseModel.h"

@implementation ELABaseModel

#pragma mark - 归档、解档
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    Class class = [self class];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            //利用KVC取值
            id value = [self valueForKey:strName];
            [encoder encodeObject:value forKey:strName];
        }
        free(ivar);
        
        class = class_getSuperclass(class);//记住还要遍历父类的属性呢
    }
}

- (id)copyWithZone:(NSZone *)zone {
    
    id obj = [[[self class] allocWithZone:zone] init];
    Class class = [self class];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            //利用KVC取值
            id value = [[self valueForKey:strName] copy];//如果还套了模型也要copy呢
            [obj setValue:value forKey:strName];
        }
        free(ivar);
        
        class = class_getSuperclass(class);//记住还要遍历父类的属性呢
    }
    return obj;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        
        Class class = [self class];
        while (class != [NSObject class]) {
            unsigned int count = 0;
            //获取类中所有成员变量名
            Ivar *ivar = class_copyIvarList(class, &count);
            for (int i = 0; i < count; i++) {
                Ivar iva = ivar[i];
                const char *name = ivar_getName(iva);
                NSString *strName = [NSString stringWithUTF8String:name];
                //进行解档取值
                id value = [decoder decodeObjectForKey:strName];
                //利用KVC对属性赋值
                [self setValue:value forKey:strName];
            }
            free(ivar);
            
            class = class_getSuperclass(class);//记住还要遍历父类的属性呢
        }
    }
    return self;
}


@end
