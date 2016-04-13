//
//  main.m
//  RuntimeLine
//
//  Created by 游峰 on 16/4/8.
//  Copyright © 2016年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gril.h"
#import "Gril+Hiee.h"
#import "BigBoby.h"
#import "Boby.h"
#import "Cat.h"
#import "Car.h"

//#if TARGET_IPHONE_SIMULATOR
//#import <objc/runtime.h>
//#else
//#import <objc/runtime.h>
//#import <objc/message.h>
//#endif


int main(int argc, const char * argv[]) {
    
    Car * car = [[Car alloc] init];
    [car eat];
    //本质： 让对象发送消息
//    objc_msgSend(car,@selector(eat));
    ((void(*)(id, SEL))objc_msgSend)((id)car, @selector(eat));
//    [Car eat];
    [[Car class] eat];
    
    //
    
    return 0;
}


void bobyFei(id self)
{
    Boby * minBoby = [[Boby alloc] init];
    ((void(*)(id, SEL))objc_msgSend)((id)minBoby, @selector(eating));
}
void cat(id self)
{
    Cat * cat = [[Cat alloc] init];
    cat.name = @"朕。。。和铲屎官";
    ((void(*)(id, SEL))objc_msgSend)((id)cat, @selector(eating));
}
void boby(id self)
{
//    Boby *minBoby = [[Boby alloc] init];
  // minBoby.name = @"哈利波特";
  //  [minBoby eating];
}
void grilHiee(id  self)
{
    Gril * grilTeacher = [[Gril alloc] init];
    grilTeacher.name = @"女教师";
    grilTeacher.age = 26;
    [grilTeacher setValue:@"教师" forKey:@"occupation"];
    grilTeacher.associatedBust = @(120); // 豪大大的
    grilTeacher.associatedCallBack = ^(){
        NSLog(@"当男友出轨的时候，赶紧回来找bug，一定是代码没写好，导致的。。。。");
    };
    
    grilTeacher.associatedCallBack();
    
    //    NSDictionary * propertyDict = [grilTeacher allProperties];
    //    NSDictionary * lvarDict = [grilTeacher allvars];
    //    NSDictionary * methodDict = [grilTeacher allmethods];
    //
    //    NSLog(@"%@", propertyDict);
    //    NSLog(@"%@", lvarDict);
    //    NSLog(@"%@", methodDict);
}

void porintTeacher(id sel)
{
    NSDictionary *dict = @{
                           @"name" : @"萌萌",
                           @"age"  : @(26),
                           @"occupation" : @"教师",
                           @"nationality" : @"瑞典国"
                           };
    // 字典转模型
    Gril * grilTeacher = [[Gril alloc] initWithDictionary:dict];
    NSLog(@"age:%d, name: %@, occupation: %@, nationality:%@",  (int)grilTeacher.age, grilTeacher.name, grilTeacher.occupation, grilTeacher.nationality);
    // 模型转字典
    NSDictionary * modelDict = [grilTeacher covertToDictionary];
    NSLog(@"%@",modelDict);
}
void hai(id  self)
{
    /**
     * 1. 下面获得property
     ````
     
     ````
     打印结果：
     */
}