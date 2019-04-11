//
//  XdEmojiFilter.h
//  XdEmojiFilterDemo
//
//  Created by Dyw on 2019/4/4.
//  Copyright © 2019 am. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XdEmojiFilter : NSObject
/* 设置全局emoji过滤开关 */
+ (void)setEmojiFilterEnable:(BOOL)enable;
/* 开启全局emoji过滤 */
+ (BOOL)emojiFilterEnable;

@end

@interface UITextInputMode (XdEmojiFilter)

- (BOOL)isEmoji;

@end

@interface UITextField (XdEmojiFilter)

/* 是否开启Emoji过滤 */
@property(nonatomic, assign) BOOL filterEmoji;

/* 当前输入模式是否是Emoji */
- (BOOL)isEmoji;

@end

@interface UITextView (XdEmojiFilter)

/* 是否开启Emoji过滤 */
@property(nonatomic, assign) BOOL filterEmoji;

/* 当前输入模式是否是Emoji */
- (BOOL)isEmoji;

@end

@interface NSString (XdEmojiFilter)

/* 剔除Emoji */
- (NSString*)removeEmoji;

@end

NS_ASSUME_NONNULL_END
