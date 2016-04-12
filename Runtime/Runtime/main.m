//
//  main.m
//  Runtime
//
//  Created by 游峰 on 16/4/7.
//  Copyright © 2016年 yf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
      [object_getClassName(<#id obj#>)  Class]
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        
        
        /**
         本文目标:
         1. 什么是Objective-C Runtime，并对它有一定的基本了解，可以在开发过程中运用自如.
         2. 简而言之，Objective-C Runtime是一个将C语言转化为面向对象语言的扩展.
         3. C++是基于静态类型,Objective-C是基于动态运行时类型.
         4. 通过Runtime把程序转为可令机器读懂的机器语言,Runtime是Objective不可缺少的重要一部分.
         
         《Objective-C的元素认知》: 子类 类 父类 元类 根类
         id和Class
         // objc_isa_availability
         // typedef struct
         object_class *Class 、、类
         objc_object Class object_class isa OBJC_ISA_AVAILABILITY 、、 isa指针
         objc_object *id
         
         1. Class是一个指向objc_class结构体的指针，
         2. id是一个指向objc_object结构体的指针，
         3. isa是一个指向objc_class结构体的指针。
         4. id就是我们所说的对象，Class就是我们所说的类。
         
         Class super_class OBJC2_UNAVAILABLE 、、父类
         const char *name OBJC2_UNAVAILABLE 、、类名
         long version OBJC2_UNAVAILABLE 、、类的版本信息，默认为0，可以通过runtime函数class_setVersion或者class_getVersion进行修改、读取
         long info OBJC2_UNAVAILABLE 、、类信息，供运行时期使用的一些位标识，如CLS_CLASS (0x1L) 表示该类为普通 class，其中包含实例方法和变量;CLS_META (0x2L) 表示该类为 metaclass，其中包含类方法;
         long instance_size OBJC2_UNAVAILABLE 、、该类的实例变量大小（包括从父类继承下来的实例变量）
         objec_ivar_list *ivars OBJC2_UNAVAILABLE 、、该类的成员变量地址列表
         objc_method_list **methodLists OBJC2_UNAVAILABLE 、、方法地址列表，与 info 的一些标志位有关，如CLS_CLASS (0x1L)，则存储实例方法，如CLS_META (0x2L)，则存储类方法;
         objc_cache_list *cache OBJC2_UNAVAILABLE 、、缓存最近使用的方法地址，用于提升效率；
         objc_protocol_list *protocols OBJC2_UNAVAILABLE 、、存储该类声明遵守的协议的列表
         
         SEL
         1. SEL是selector在Objective-C中的表示类型。
         2. selector可以理解为区别方法的ID。
         objc_selector *SEL
         objc_selector char * name OBJC2_UNAVLABLE 名称
         char *type 
         // name和types都是char类型。
         
         IMP
         id (* IMP)(id,SEL,...);
        // IMP是“implementation”的缩写，它是由编译器生成的一个函数指针。
        // 当你发起一个消息后（下文介绍），这个函数指针决定了最终执行哪段代码
         
         Method 
         Method代表类中的某个方法的类型
         objc_method *Method
         objc_method SEL method_name OBJC2_UNAVAILABLE 、、方法名
         obcj_method char *method_types OBJC2_UNAVAILABLE 、、方法类型
         IMP method_imp OBJC2_UNAVAILABLE 、、方法实现
         
         1. 方法名method_name类型为SEL，上文提到过。
         2. 方法类型method_types是一个char指针，存储着方法的参数类型和返回值类型。
         3. 方法实现method_imp的类型为IMP，上文提到过。
         
         Ivar
         Ivar代表类中实例变量的类型
         objc_ivar *Ivar
         objc_ivar char *ivar_name OBJC2_UNAVAILABLE 、、变量名
         objc_ivar char *ivar_type OBJC2_UNAVAILABLE 、、变量类型
         objc_ivar int ivar_offset OBJC2_UNAVAILABLE 、、基地址偏移字节
         objc_ivar int space OBJC2_UNAVAILABLE 、、占用空间
         
         objc_propery_t
         objc_property_t是属性
         objc_property *objc_property_t;
         1. objc_property是内置的类型，与之关联的还有一个objc_property_attribute_t，它是属性的attribute，
         2. 也就是其实是对属性的详细描述，包括属性名称、属性编码类型、原子类型/非原子类型等
         const char  *name 、、名称
         const char  *value 、、值（通常为空的）
         ------ objc_property_attribute_t
         
         Cache
         objc_cache *Cache
         objc_cache unsigned int mask OBJC2_UNAVAILABLE 、、
         unsigned int occupied  OBJC2_UNAVAILABLE 、、
         Method buckets[1]  OBJC2_UNAVAILABLE 、、
         
         1. mask: 指定分配cache buckets的总数。
         2. 在方法查找中，Runtime使用这个字段确定数组的索引位置。
         3. occupied: 实际占用cache buckets的总数。
         4. buckets: 指定Method数据结构指针的数组。
         5. 这个数组可能包含不超过mask+1个元素。
         6. 需要注意的是，指针可能是NULL，
         7. 表示这个缓存bucket没有被占用，另外被占用的bucket可能是不连续的。
         8. 这个数组可能会随着时间而增长。
         9. objc_msgSend（下文讲解）每调用一次方法后，就会把该方法缓存到cache列表中，
         10. 下次的时候，就直接优先从cache列表中寻找，如果cache没有，才从methodLists中查找方法。
         
         Category
         就是我们平时所说的类别了，很熟悉吧。它可以动态的为已存在的类添加新的方法
         objc_catagory *Category
         char *category   OBJC2_UNAVAILABLE 、、类别名称
         char *class_name   OBJC2_UNAVAILABLE 、、类名
         objc_method_list *instance_methods   OBJC2_UNAVAILABLE 、、实例方法列表
         objc_method_list *class_methods  OBJC2_UNAVAILABLE 、、类方法列表
         objc_method_list *protocols   OBJC2_UNAVAILABLE 、、协议列表
         
         《OC消息传递》
         基本消息传递
         1. 在面向对象编程中，对象调用方法叫做发送消息。
         2. 在编译时，程序的源代码就会从对象发送消息转换成Runtime的objc_msgSend函数调用。
         
         例如某实例变量receiver实现某一个方法oneMethod
         [receiver oneMethod] Runtime会将其转成类似这样的代码：objc_msgSend(receiver, selector);
         
         1. Runtime会根据类型自动转换成下列某一个函数：
         2. objc_msgSend:普通的消息都会通过该函数发
         3. objc_msgSend_stret:消息中有数据结构作为返回值（不是简单值）时，通过此函数发送和接收返回值
         4. objc_msgSendSuper:和objc_msgSend类似，这里把消息发送给父类的实例
         5. objc_msgSendSuper_stret:和objc_msgSend_stret类似，这里把消息发送给父类的实例并接收返回值
         
         objc_msgSend函数的调用过程：
         第一步：检测这个selector是不是要忽略的。
         第二步：检测这个target是不是nil对象。nil对象发送任何一个消息都会被忽略掉。
         第三步：
            1.调用实例方法时，它会首先在自身isa指针指向的类（class）methodLists中查找该方法，
               如果找不到则会通过class的super_class指针找到父类的类对象结构体，
               然后从methodLists中查找该方法，
               如果仍然找不到，则继续通过super_class向上一级父类结构体中查找，
               直至根class；
            2.当我们调用某个某个类方法时，它会首先通过自己的isa指针找到metaclass，
               并从其中methodLists中查找该类方法，
               如果找不到则会通过metaclass的super_class指针找到父类的metaclass对象结构体，
               然后从methodLists中查找该方法，
               如果仍然找不到，则继续通过super_class向上一级父类结构体中查找，
               直至根metaclass；
         第四部：前三部都找不到就会进入动态方法解析(看下文
         
         消息动态解析
         第一步：
            通过resolveInstanceMethod：方法决定是否动态添加方法。
            如果返回Yes则通过class_addMethod动态添加方法，消息得到处理，结束；
            如果返回No，则进入下一步；
         第二步：
            这步会进入forwardingTargetForSelector: 方法，
            用于指定备选对象响应这个selector，不能指定为self。
            如果返回某个对象则会调用对象的方法，结束。
            如果返回nil，则进入第三部；
         第三部：
            这步我们要通过methodSignatureForSelector: 方法签名，
            如果返回nil，则消息无法处理。
            如果返回methodSignature，则进入下一步；
         第四部：
            这步调用forwardInvocation：方法，
            我们可以通过anInvocation对象做很多处理，
            比如修改实现方法，修改响应对象等，如果方法调用成功，则结束。
            如果失败，则进入doesNotRecognizeSelector方法，
            若我们没有实现这个方法，那么就会crash。
         
         
         
         
         
         */
        
    }
}
