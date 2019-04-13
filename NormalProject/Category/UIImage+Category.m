//
//  UIImage+Category.m
//  NormalProject
//
//  Created by gyh on 2019/4/13.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "UIImage+Category.h"
#import "NSString+Category.h"

@implementation UIImage (Category)

- (NSString *)memoryBitSize {
    CGFloat cgImageBytesPerRow = CGImageGetBytesPerRow(self.CGImage); // 2560
    CGFloat cgImageHeight = CGImageGetHeight(self.CGImage); // 1137
    NSUInteger size  = cgImageHeight * cgImageBytesPerRow;
//    NSLog(@"size:%@",[NSString memoryOfBitSize:size]); // 输出 2910720
    return [NSString memoryOfBitSize:size];
}

@end
