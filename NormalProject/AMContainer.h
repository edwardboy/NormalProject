//
//  AMContainer.h
//  NormalProject
//
//  Created bygyh on 2019/3/21.
//  Copyright © 2019gyh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMContainer : NSObject
{
    @private
    NSMutableDictionary *mDict;
    NSMutableArray *mArray;
}

- (void)setObject:(id)object forKeyedSubscript:(nonnull id<NSCopying>)key;
- (id)objectForKeyedSubscript:(id)key;
- (void)removeObjectForKeyedSubscript:(id)key;

- (void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)idx;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)addObject:(id)anObject;
- (void)removeObject:(id)anObject;

@end

NS_ASSUME_NONNULL_END
