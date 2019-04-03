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
};

@protocol AMTextProtocol <UITextFieldDelegate,UITextViewDelegate>

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField types:(AMTextRuleType)type;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AMTextDelegate : NSObject

@end

NS_ASSUME_NONNULL_END
