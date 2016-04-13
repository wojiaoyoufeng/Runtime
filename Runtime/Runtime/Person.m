//
//  Person.m
//  Runtime
//
//  Created by 游峰 on 16/4/12.
//  Copyright © 2016年 yf. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
void eat(id self, SEL sel)
{
    NSLog(@"%@ -- %@ ",self, NSStringFromSelector(sel));
}
+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(eat)) {
        // 动态添加eat方法
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), (IMP)eat, "v@:");
    }
    return [super resolveClassMethod:sel];
}
//- (void)eating
//{
//    NSLog(@"%s",__func__);
//}
@end
