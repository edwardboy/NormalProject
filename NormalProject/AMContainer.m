//
//  AMContainer.m
//  NormalProject
//
//  Created by gyh on 2019/3/21.
//  Copyright © 2019 gyh. All rights reserved.
//

#import "AMContainer.h"

@implementation AMContainer

- (instancetype)init{
    
    self = [super init];
    if (self) {
        mDict = [NSMutableDictionary dictionary];
        mArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)dealloc{
    if (mDict != nil) {
        [mDict removeAllObjects];
        mDict = nil;
    }
    
    if (mArray != nil) {
        [mArray removeAllObjects];
        mArray = nil;
    }
    NSLog(@"%s",__func__);
}

- (void)setObject:(id)object forKeyedSubscript:(id<NSCopying>)key{
    [mDict setObject:object forKey:key];
}

- (id)objectForKeyedSubscript:(id)key{
    return [mDict objectForKey:key];
}

- (void)removeObjectForKeyedSubscript:(id)key{
    [mDict removeObjectForKey:key];
}

/***********************/

- (void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)idx{
    const NSUInteger length = [mArray count];
    if (idx > length) {
        return;
    }
    
    if (idx == length) {
        [mArray addObject:anObject];
    }else{
        [mArray replaceObjectAtIndex:idx withObject:anObject];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx{
    if (idx >= [mArray count]) {
        return nil;
    }
    return [mArray objectAtIndex:idx];
}

- (void)addObject:(id)anObject{
    [mArray addObject:anObject];
}

- (void)removeObject:(id)anObject{
    [mArray removeObject:anObject];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"mDict:%@ \n mArray:%@",mDict,mArray];
}

@end
