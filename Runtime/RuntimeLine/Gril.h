//
//  Gril.h
//  Runtime
//
//  Created by 游峰 on 16/4/8.
//  Copyright © 2016年 yf. All rights reserved.
//
/**
 {
 NSString * _occupation;
 NSString * _nationality;
 }
 - (NSDictionary *)allProperties;
 - (NSDictionary *)allvars;
 - (NSDictionary *)allmethods;
 
 */

#import <Foundation/Foundation.h>
@interface Gril : NSObject //<NSCoding>
@property (copy, nonatomic) NSString * occupation; // 专业
@property (copy, nonatomic) NSString * nationality;  // 国度
@property (copy, nonatomic) NSString * name;  // 名称
@property (assign, nonatomic) NSUInteger age;  // 年龄
/** 生成模型 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
/** 生成字典 */
- (NSDictionary *)covertToDictionary;
@end