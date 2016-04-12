//
//  BigBoby.h
//  Runtime
//
//  Created by 游峰 on 16/4/9.
//  Copyright © 2016年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Boby;
@interface BigBoby : NSObject
{
    int _money;
}
@property (nonatomic, assign, readonly) int age;
@property (nonatomic, assign) double height;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *books;
@property (nonatomic, strong) id test;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, copy) void (^block)();
@property (nonatomic, assign) int *p;
@property (nonatomic, strong) NSString *cat;
- (NSDictionary *)allIvars;
@end
