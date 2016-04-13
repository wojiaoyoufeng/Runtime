//
//  RuntimeProtocol.h
//  Runtime
//
//  Created by 游峰 on 16/4/13.
//  Copyright © 2016年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol RuntimeBaseProtocol <NSObject>
@optional
- (void)doBaseAction;
@end
@protocol RuntimeProtocol <NSObject>
@required
- (void)doRequiredAction;
@optional
- (void)doOptionalAction;
@end
@interface RuntimeProtocol : NSObject <RuntimeProtocol,RuntimeBaseProtocol>
{
    NSString * name;
    NSString * kind;
}
@property (copy, nonatomic) NSString * value;
@property (assign, nonatomic) int age;
+ (void)doClassMethod;

@end
