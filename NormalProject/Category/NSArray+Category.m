//
//  NSArray+Category.m
//  NormalProject
//
//  Created by gyh on 2019/4/11.
//  Copyright © 2019 gyh. All rights reserved.
//

//#import "NSArray+Category.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@implementation NSArray (Category)

+ (void)load{
    NSLog(@"--%s--",__func__);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            swizzleMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(singleObjectArrayIObjectAtIndex:));
            swizzleMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:), @selector(arrayIObjectAtIndex:));
            swizzleMethod(NSClassFromString(@"__NSArray0"), @selector(objectAtIndex:), @selector(array0ObjectAtIndex:));
            swizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:), @selector(arrayMObjectAtIndex:));
        }
    });
}

- (id)arrayIObjectAtIndex:(NSInteger)index{
    NSLog(@"--%s--",__func__);
    if (self.count != 0 && index < self.count) {
        return [self arrayIObjectAtIndex:index];
    }
    return nil;
}

- (id)arrayMObjectAtIndex:(NSInteger)index{
    NSLog(@"--%s--",__func__);
    if (self.count != 0 && index < self.count) {
        return [self arrayMObjectAtIndex:index];
    }
    return nil;
}

- (id)singleObjectArrayIObjectAtIndex:(NSInteger)index{
    NSLog(@"--%s--",__func__);
    if (index == 0) {
        return [self singleObjectArrayIObjectAtIndex:index];
    }
    return nil;
}

- (id)array0ObjectAtIndex:(NSInteger)index{
    NSLog(@"--%s--",__func__);
    return nil;
}

@end
