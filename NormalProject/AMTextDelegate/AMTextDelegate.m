//
//  AMTextDelegate.m
//  NormalProject
//
//  Created by gyh on 2019/4/3.
//  Copyright © 2019 gyh. All rights reserved.
//

#import "AMTextDelegate.h"
#import "NSString+Emoji.h"

@interface AMTextDelegate ()
{
    AMTextRuleType _ruleType;
}

@end

@implementation AMTextDelegate

- (instancetype)initWithRuleType:(AMTextRuleType)ruleType{
    self = [super init];
    if (self) {
        _ruleType = ruleType;
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"string:%@",string);
    
    if (_ruleType == AMTextRuleTypeWithoutEmoji && [string containEmoji]) {
        return NO;
    }else if (_ruleType == AMTextRuleTypePureNum){
        return YES;
    }
    
    return YES;
}


@end
