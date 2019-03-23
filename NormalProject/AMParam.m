//
//  AMParam.m
//  NormalProject
//
//  Created by 李宁锋 on 2019/3/21.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "AMParam.h"

@implementation AMParam

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    [super setObject:anObject forKeyedSubscript:aKey];
    NSLog(@"%s",__func__);
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    NSLog(@"%s",__func__);
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
    [super setObject:obj forKeyedSubscript:key];
    NSLog(@"%s",__func__);
}

@end
