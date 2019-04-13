//
//  NSString+Category.m
//  NormalProject
//
//  Created by gyh on 2019/4/13.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "NSString+Category.h"


@implementation NSString (Category)

+ (NSString *)memoryOfBitSize:(NSInteger)size{
    float per = 1024.0;
    
    float kb = size / per;
    float mb = kb / per;
    float gb = mb / per;
    
    if (gb > 0.01) return [NSString stringWithFormat:@"%.2f G",gb];
    if (mb > 0.01) return [NSString stringWithFormat:@"%.2f M",mb];
    
    return [NSString stringWithFormat:@"%.2f k",kb];
}

@end
