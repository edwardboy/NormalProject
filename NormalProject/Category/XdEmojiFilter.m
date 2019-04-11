//
//  XdEmojiFilter.m
//  XdEmojiFilterDemo
//
//  Created by Dyw on 2019/4/4.
//  Copyright © 2019 am. All rights reserved.
//

#import "XdEmojiFilter.h"
#import <objc/runtime.h>

#define kDelegator @"kDelegator"
#define kFilterEmoji @"kFilterEmoji"
#define kXdEmojiFilterEnable @"kXdEmojiFilterEnable"

@implementation XdEmojiFilter

+ (void)setEmojiFilterEnable:(BOOL)enable{
    [[NSUserDefaults standardUserDefaults] setObject:@(enable) forKey:kXdEmojiFilterEnable];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)emojiFilterEnable{
    BOOL enable = [[[NSUserDefaults standardUserDefaults] objectForKey:kXdEmojiFilterEnable] boolValue];
    return enable;
}

@end

@implementation UITextInputMode (XdEmojiFilter)

- (BOOL)isEmoji{
    if(![self primaryLanguage]){
        return YES;
    }
    return (![self primaryLanguage] || [[self primaryLanguage] isEqualToString:@"emoji"]);
}

@end


@interface XdTextFieldDelegator : NSObject

@end

@implementation XdTextFieldDelegator

- (void)handleTextChangeEvent:(UITextField *)textField {
    NSString *str = [textField.text removeEmoji];
    textField.text = str;
}

- (void)handleTextChangeNotification:(NSNotification *)ntf{
    UITextView *textView = ntf.object;
    NSString *str = [textView.text removeEmoji];
    textView.text = str;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@interface UITextField ()

@property(nonatomic, strong) XdTextFieldDelegator *xdTextFieldDelegator;

@end

@implementation UITextField (XdEmojiFilter)

+ (void)load{
    NSLog(@"===%s===",__func__);
    swizzleMethod(self, @selector(initWithCoder:), @selector(xdInitWithCoder:));
    swizzleMethod(self, @selector(init), @selector(xdInit));
}

- (instancetype)xdInitWithCoder:(NSCoder *)aDecoder{
    self.filterEmoji = [XdEmojiFilter emojiFilterEnable];
    return [self xdInitWithCoder:aDecoder];
}

- (instancetype)xdInit{
    self.filterEmoji = [XdEmojiFilter emojiFilterEnable];
    return [self xdInit];
}

- (BOOL)isEmoji{
    return (![self.textInputMode primaryLanguage] || self.textInputMode.isEmoji);
}

- (void)setXdTextFieldDelegator:(XdTextFieldDelegator *)xdTextFieldDelegator{
    objc_setAssociatedObject(self, kDelegator, xdTextFieldDelegator, OBJC_ASSOCIATION_RETAIN);
    if(xdTextFieldDelegator){
        [self addTarget:xdTextFieldDelegator action:@selector(handleTextChangeEvent:) forControlEvents:UIControlEventEditingChanged];
    }else{
        [self removeTarget:xdTextFieldDelegator action:@selector(handleTextChangeEvent:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (XdTextFieldDelegator *)xdTextFieldDelegator{
    XdTextFieldDelegator *xdTextFieldDelegator = (XdTextFieldDelegator *)objc_getAssociatedObject(self, kDelegator);
    return xdTextFieldDelegator;
}

- (void)setFilterEmoji:(BOOL)filterEmoji{
    objc_setAssociatedObject(self, kFilterEmoji, @(filterEmoji), OBJC_ASSOCIATION_RETAIN);
    if(filterEmoji){
        self.xdTextFieldDelegator = [[XdTextFieldDelegator alloc] init];
    }else{
        self.xdTextFieldDelegator = nil;
    }
}

- (BOOL)filterEmoji{
    NSNumber *filterEmoji = objc_getAssociatedObject(self, kFilterEmoji);
    return [filterEmoji boolValue];
}


@end

@interface UITextView ()

@property(nonatomic, strong) XdTextFieldDelegator *xdTextFieldDelegator;

@end

@implementation UITextView (XdEmojiFilter)

+ (void)load{
    NSLog(@"===%s===",__func__);
    swizzleMethod(self, @selector(initWithCoder:), @selector(xdInitWithCoder:));
//    swizzleMethod(self, @selector(init), @selector(xdInit));
}

- (instancetype)xdInitWithCoder:(NSCoder *)aDecoder{
    self.filterEmoji = [XdEmojiFilter emojiFilterEnable];
    return [self xdInitWithCoder:aDecoder];
}

- (BOOL)isEmoji{
    return (![self.textInputMode primaryLanguage] || self.textInputMode.isEmoji);
}

- (void)setXdTextFieldDelegator:(XdTextFieldDelegator *)xdTextFieldDelegator{
    objc_setAssociatedObject(self, kDelegator, xdTextFieldDelegator, OBJC_ASSOCIATION_RETAIN);
    if(xdTextFieldDelegator){
        [[NSNotificationCenter defaultCenter] addObserver:xdTextFieldDelegator selector:@selector(handleTextChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:xdTextFieldDelegator name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (XdTextFieldDelegator *)delegator{
    XdTextFieldDelegator *delegator = (XdTextFieldDelegator *)objc_getAssociatedObject(self, kDelegator);
    return delegator;
}

- (void)setFilterEmoji:(BOOL)filterEmoji{
    objc_setAssociatedObject(self, kFilterEmoji, @(filterEmoji), OBJC_ASSOCIATION_RETAIN);
    if(filterEmoji){
        self.xdTextFieldDelegator = [[XdTextFieldDelegator alloc] init];
    }else{
        self.xdTextFieldDelegator = nil;
    }
}

- (BOOL)filterEmoji{
    NSNumber *filterEmoji = objc_getAssociatedObject(self, kFilterEmoji);
    return [filterEmoji boolValue];
}

@end

@implementation NSString (XdEmojiFilter)

/* 剔除Emoji表情 */
- (NSString*)removeEmoji{
    __block NSMutableString* temp = [NSMutableString string];
    [self enumerateSubstringsInRange: NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange,    NSRange enclosingRange, BOOL *stop){
        const unichar hs = [substring characterAtIndex: 0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            const unichar ls = [substring characterAtIndex: 1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            [temp appendString: (0x1d000 <= uc && uc <= 0x1f77f)? @"": substring]; // U+1D000-1F77F
        } else {
            [temp appendString: (0x2100 <= hs && hs <= 0x26ff)? @"": substring]; // U+2100-26FF
        }
    }];
    return temp;
}

@end
