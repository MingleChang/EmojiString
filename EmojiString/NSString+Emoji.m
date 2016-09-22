//
//  NSString+Emoji.m
//  EmojiString
//
//  Created by MingleChang on 16/9/22.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "NSString+Emoji.h"
#import "HBEmojiAttachment.h"

@interface HBEmojiManager : NSObject

@property(nonatomic,copy)NSDictionary *emojiInfo;

+(HBEmojiManager *)manager;

@end

@implementation HBEmojiManager

+(HBEmojiManager *)manager{
    static HBEmojiManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[HBEmojiManager alloc]init];
    });
    return manager;
}
-(NSDictionary *)emojiInfo{
    if (_emojiInfo) {
        return _emojiInfo;
    }
    NSString *lPath=[[NSBundle mainBundle]pathForResource:@"emoji" ofType:@"json"];
    NSData *lData=[NSData dataWithContentsOfFile:lPath];
    _emojiInfo=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
    return _emojiInfo;
}
@end

@implementation NSString (Emoji)

-(NSAttributedString *)transformAttributedString{
    NSMutableAttributedString *lAttributedString=[[NSMutableAttributedString alloc]initWithString:self];
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([[HBEmojiManager manager].emojiInfo.allKeys containsObject:substring]) {
            NSString *lFileName=[[HBEmojiManager manager].emojiInfo objectForKey:substring];
            HBEmojiAttachment *attachment = [[HBEmojiAttachment alloc] init];
            attachment.image = [UIImage imageNamed:lFileName];
            NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
            [lAttributedString replaceCharactersInRange:enclosingRange withAttributedString:attachmentString];
        }
    }];
    return lAttributedString;
}

@end
