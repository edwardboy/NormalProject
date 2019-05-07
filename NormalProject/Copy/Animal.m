//
//  Animal.m
//  NormalProject
//
//  Created by gyh on 2019/5/7.
//  Copyright © 2019 gyh. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (id)copyWithZone:(NSZone *)zone{
    Animal *animal = [[Animal allocWithZone:zone] init];
    animal.name = self.name;
    
    return animal;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    Animal *animal = [[Animal allocWithZone:zone] init];
    animal.name = self.name;
    
    return animal;
}

@end
