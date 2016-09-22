//
//  HBEmojiAttachment.m
//  EmojiString
//
//  Created by MingleChang on 16/9/22.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "HBEmojiAttachment.h"

@implementation HBEmojiAttachment
- (CGRect)attachmentBoundsForTextContainer:(nullable NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);
}
@end
