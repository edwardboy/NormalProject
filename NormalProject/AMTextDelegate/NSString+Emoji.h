//
//  NSString+Emoji.h
//  NormalProject
//
//  Created by gyh on 2019/4/4.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Emoji)
- (BOOL) emojiInUnicode:(short)code;
- (BOOL) emojiInSoftBankUnicode:(short)code;
- (BOOL) containEmoji;

@end

NS_ASSUME_NONNULL_END
