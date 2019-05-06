//
//  Animal.h
//  NormalProject
//
//  Created by gyh on 2019/5/6.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject<NSCopying,NSMutableCopying>

@property (nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
