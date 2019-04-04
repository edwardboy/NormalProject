//
//  AMTextDelegate.h
//  NormalProject
//
//  Created by gyh on 2019/4/3.
//  Copyright © 2019 gyh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AMTextRuleType) {
    AMTextRuleTypePureText,
    AMTextRuleTypePureNum,
    AMTextRuleTypeWithoutEmoji,
};

NS_ASSUME_NONNULL_BEGIN

@interface AMTextDelegate : NSObject<UITextFieldDelegate>

- (instancetype)initWithRuleType:(AMTextRuleType)ruleType;

@end

NS_ASSUME_NONNULL_END
