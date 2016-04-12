//
//  Gril.m
//  Runtime
//
//  Created by 游峰 on 16/4/8.
//  Copyright © 2016年 yf. All rights reserved.
//



#import "Gril.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif
@implementation Gril
/** 生成模型 */
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        for (NSString * key in dict.allKeys) {
            id value = dict[key];
            SEL setter = [self propertySetterByKey:key];
            if (setter) {
                ((void(*)(id, SEL, id))objc_msgSend)(self, setter, value);
            }
        }
    
    }
    return self;
}
/** 生成字典  */
- (NSDictionary *)covertToDictionary
{
    unsigned int count  = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    if (count != 0) {
        NSMutableDictionary *dict = [@{} mutableCopy];
        for (NSUInteger i = 0; i < count; i++)
        {
            const void * propertyName = property_getName(properties[i]);
            NSString * name = [NSString stringWithUTF8String:propertyName];
            SEL getter = [self propertyGetterByKey:name];
            if (getter)
            {
                id value = ( (id(*)(id, SEL))objc_msgSend)(self, getter);
                if (value)
                {
                    dict[name] = value;
                }
                else
                {
                    dict[name] = @"!Waning: key--value != nil !";
                }
            }
        }
        free(properties);
        return dict;
    }
    free(properties);
    return nil;
}

#pragma mark --  private methods
/** setter方法 */
- (SEL)propertySetterByKey:(NSString *)key
{
    // 首字母大写 setAge
    NSString * propertySetterName = [NSString stringWithFormat:@"set%@:",key.capitalizedString];
    SEL setter = NSSelectorFromString(propertySetterName);
    if ([self respondsToSelector:setter]) {
        return setter;
    }
    return nil;
}

/** getter方法 */
- (SEL)propertyGetterByKey:(NSString *)key
{
    SEL getter = NSSelectorFromString(key);
    if ([self respondsToSelector:getter]) {
        return getter;
    }
    return nil;
}

/**
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (NSUInteger i = 0; i < count; i++)
    {
        const char * name = ivar_getName(ivars[i]);
        NSString * key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (NSUInteger i = 0; i < count; i ++) {
            const char *name = ivar_getName(ivars[i]);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}
*/

/**
@interface Gril ()
{
    NSString * _liver;
}

@property (assign, nonatomic) double heigth;
@end

@implementation Gril
{
    int _countA;
}

- (NSDictionary *)allProperties
{
    unsigned int  count = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary * dict = [@{} mutableCopy];
    for (NSUInteger i = 0; i < count; i++)
    {
        // 名称
        const char * propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        // 值
        id propertyValue = [self valueForKey:name];
        if (propertyValue) {
            dict[name] = propertyValue;
        }
        else
        {
            dict[name] = @"!waning； key:value != nil------allProperties";
        }
    }
   
    free(properties); // 去内存
    return dict;
}

- (NSDictionary *)allvars
{
    unsigned int count = 0;
    NSMutableDictionary * dict = [@{} mutableCopy];
    Ivar * ivars  = class_copyIvarList([self class], &count);
    for (NSUInteger i = 0; i < count; i++)
    {
        const char * varName = ivar_getName(ivars[i]);
        NSString *name  = [NSString stringWithUTF8String:varName];
        id varValue = [self valueForKey:name];
        if (varValue) {
            dict[name] = varValue;
        }
        else
        {
            dict[name] = @"!waning； key:value != nil------allvars";
        }
    }
    free(ivars);
    return dict;
}

- (NSDictionary *)allmethods
{
    unsigned int count = 0;
    NSMutableDictionary * dict = [@{} mutableCopy];
    Method * methods = class_copyMethodList([self class], &count);
    for (NSUInteger i = 0; i < count; i++)
    {
        SEL methodSEL = method_getName(methods[i]);
        const char * methodName = sel_getName(methodSEL);
        NSString * name = [NSString stringWithUTF8String:methodName];
        
        // 参数
        int arguments = method_getNumberOfArguments(methods[i]);
        dict[name] = @(arguments-2);
    }
    free(methods);
    return dict;
}
*/
@end
