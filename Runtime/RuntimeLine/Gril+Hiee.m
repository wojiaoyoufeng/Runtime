//
//  Gril+Hiee.m
//  Runtime
//
//  Created by 游峰 on 16/4/9.
//  Copyright © 2016年 yf. All rights reserved.
//

#import "Gril+Hiee.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

@implementation Gril (Hiee)

- (void)setAssociatedBust:(NSNumber *)bust
{
    // 关联对象 objc_association_retain_nonatomc
    objc_setAssociatedObject(self, @selector(associatedBust), bust, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)associatedBust
{
    // 获取关联
    return objc_getAssociatedObject(self, @selector(associatedBust));
}

- (void)setAssociatedCallBack:(codingCallBack)callBack
{
    objc_setAssociatedObject(self, @selector(associatedCallBack), callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (codingCallBack)associatedCallBack
{
    return objc_getAssociatedObject(self, @selector(associatedCallBack));
}

@end
