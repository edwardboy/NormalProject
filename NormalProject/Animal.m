//
//  Animal.m
//  NormalProject
//
//  Created by gyh on 2019/5/6.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "Animal.h"

@implementation Animal
- (id)copyWithZone:(NSZone *)zone{
    Animal * model = [[Animal allocWithZone:zone] init];
    model.name = self.name;
    return model;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    Animal * model = [[Animal allocWithZone:zone] init];
    model.name = self.name;
    return model;
}

@end
