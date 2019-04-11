//
//  NSArray+Category.m
//  NormalProject
//
//  Created by gyh on 2019/4/11.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "NSArray+Category.h"
#import <objc/runtime.h>


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@implementation NSArray (Category)

+ (void)swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load{
    swizzleMethod(self, @selector(objectAtIndex:), @selector(safeObjectAtIndex:));
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        @autoreleasepool {
//            [self swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safeObjectAtIndex:)];
//        }
//    });
}

- (id)safeObjectAtIndex:(NSInteger)index{
    NSLog(@"--%s--",__func__);
    if (index < self.count) {
        return [self safeObjectAtIndex:index];
    }
    return nil;
}

@end
