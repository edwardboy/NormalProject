//
//  UIView+Color.m
//  NormalProject
//
//  Created by gyh on 2019/4/1.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "UIView+Color.h"

@implementation UIView (Color)

- (void)gradientTop:(UIColor *)topColor bottom:(UIColor *)bottomColor{
//
//    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//    gradientLayer.frame = self.bounds;
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
////    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
//    [gradientLayer setColors:@[(id)[topColor CGColor],(id)[bottomColor CGColor]]];//渐变数组
//    [self.layer addSublayer:gradientLayer];
    
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    NSArray *colors = [NSArray arrayWithObjects: (id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [gradLayer setColors:colors];
    [gradLayer setStartPoint:CGPointMake(0.0f,0.0f)];
    [gradLayer setEndPoint:CGPointMake(0.0f,1.0f)];
    [gradLayer setFrame:CGRectMake(0,0, self.frame.size.width,self.frame.size.height)];
    [self.layer insertSublayer:gradLayer atIndex:0];
}

@end
