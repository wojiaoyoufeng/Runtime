//
//  BigBoby.m
//  Runtime
//
//  Created by 游峰 on 16/4/9.
//  Copyright © 2016年 yf. All rights reserved.
//


#import "BigBoby.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

@interface BigBoby ()
{
    int _no;
}
@property (assign, nonatomic) double goodF;
@end

@implementation BigBoby
{
    int _mather;
}

- (NSDictionary *)allIvars;
{
    unsigned int count = 0;
    Ivar * ivarsList = class_copyIvarList([self class], &count);
    NSMutableDictionary *dict = [@{} mutableCopy];
    for (int i = 0; i < count; i++)
    {
        const char *ivar = ivar_getName(ivarsList[i]);
        NSString * name = [NSString stringWithUTF8String:ivar];
        id ivarValue =  [self valueForKey:name];
        if (ivarValue) {
            dict[name] = ivarValue;
        }
        else
        {
            dict[name] = @"!waning； key:value != nil------allvars";
        }
    }
    free(ivarsList);
    return dict;
}

@end
