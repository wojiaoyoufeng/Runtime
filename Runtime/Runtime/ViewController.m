//
//  ViewController.m
//  Runtime
//
//  Created by 游峰 on 16/4/7.
//  Copyright © 2016年 yf. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "RuntimeProtocol.h"

#if TARGET_IPHONE_SIMULATOR
#import <objc/runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
}

- (void)eat
{
    NSLog(@"%s",__func__);
}
- (void)image
{
    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    //    UIImage *image = [UIImage imageNamed:@"123.png"];
    
    UIImageView * imageV = [[UIImageView alloc] init];
    [self.view addSubview:imageV];
    imageV.frame = CGRectMake(100, 100, 200, 200);
    imageV.backgroundColor = [UIColor whiteColor];
    [imageV setImage:[UIImage imageNamed:@"123.png"]];
    //    [imageV setHighlightedImage:[UIImage <#image#>]];
}

+ (void)load
{
    // 交换方法
    // 获取方法地址
    Method imageWihtName = class_getClassMethod(self, @selector(imageWihtName:));
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    
    // 交换方法地址 == 交换实现方法
    method_exchangeImplementations(imageWihtName, imageName);
    
    // 如果在分类中重写系统方法imageNamed，就会把系统的功能给覆盖掉，而且分类中不能调用super.
}

+ (instancetype)imageWithName:(NSString *)name
{
    NSLog(@"%s",__func__);
    //  这里开始调用imageWithName 等于调用imageName了
    UIImage * image = [self imageWithName:name];
    if ( !image) {
        NSLog(@"咩。。。。。喵。。。。");
    }
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
