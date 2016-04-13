//
//  main.m
//  Runtime
//
//  Created by 游峰 on 16/4/7.
//  Copyright © 2016年 yf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RuntimeProtocol.h"
#import <objc/runtime.h>

int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    unsigned int count = 0;
    __unsafe_unretained Protocol ** protocols = class_copyProtocolList([RuntimeProtocol class], &count);
    for (NSUInteger i = 0; i < count; i++)
    {
        const char * name = protocol_getName(protocols[i]);
        printf("%s\n",name);
    }
    
    unsigned int countP = 0;
    objc_property_t * properties = class_copyPropertyList([RuntimeProtocol class], &countP);
    for (unsigned int  i = 0; i < countP; i++)
    {
        const char * name = property_getName(properties[i]);
        printf("%s\n",name);
    }

    /**unsigned int countP;
    objc_property_t *propertys = class_copyPropertyList([RuntimeProtocol class], &countP);
    for (unsigned int i = 0; i < countP; i++) {
        const char *name = property_getName(propertys[i]);
        printf("%s\n",name);
    }
   */
            /**
    printf("\n\n\n");
    // Get dynamic framework name
        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
        const char *name = class_getImageName(LSApplicationWorkspace_class);
        printf("%s\n",name);
    
    printf("\n\n\n");
    // Installed apps
        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        NSObject *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        NSLog(@"Installed apps:%@",[workspace performSelector:@selector(allApplications)]);
#pragma clang diagnostic pop
    
    */
    
    

    
    return 0;
}

