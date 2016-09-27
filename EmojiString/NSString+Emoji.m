//
//  NSString+Emoji.m
//  EmojiString
//
//  Created by MingleChang on 16/9/22.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "NSString+Emoji.h"
#import "HBEmojiAttachment.h"


@implementation NSString (Emoji)

-(NSAttributedString *)transformEmojiAttributedString{
    //初始化emoji配置文件
    static NSDictionary *emojiInfo=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *lPath=[[NSBundle mainBundle]pathForResource:@"emoji" ofType:@"json"];
        NSData *lData=[NSData dataWithContentsOfFile:lPath];
        emojiInfo=[NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
    });
    
    //正则表达式，用于匹配emoji的特殊字符串，用于查找所有满足配置文件的特殊字符串
    NSRegularExpression *regular=[NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[\\]]*\\]" options:0 error:nil];
    NSMutableArray *lRangeArray=[NSMutableArray array];
    [regular enumerateMatchesInString:self options:0 range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result==nil) {
            return;
        }
        NSString *lResult=[self substringWithRange:result.range];
        if ([emojiInfo.allKeys containsObject:lResult]) {
            [lRangeArray addObject:[NSValue valueWithRange:result.range]];
        }
    }];
    
    NSUInteger offset=0;//用图片替换文字后产生的偏差
    NSMutableAttributedString *lAttributedString=[[NSMutableAttributedString alloc]initWithString:self];
    for (NSValue *lRangeValue in lRangeArray) {
        NSRange lRange=lRangeValue.rangeValue;
        NSString *lKey=[self substringWithRange:lRange];
        NSString *lImageName=[emojiInfo objectForKey:lKey];
        HBEmojiAttachment *lAttachment = [[HBEmojiAttachment alloc] init];
        lAttachment.image = [UIImage imageNamed:lImageName];
        NSAttributedString *lAttachmentString = [NSAttributedString attributedStringWithAttachment:lAttachment];
        NSRange lNewRange=NSMakeRange(lRange.location-offset, lRange.length);
        [lAttributedString replaceCharactersInRange:lNewRange withAttributedString:lAttachmentString];
        offset=offset+lRange.length-1;
    }
    return lAttributedString;
}

@end
