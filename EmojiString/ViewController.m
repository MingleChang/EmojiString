//
//  ViewController.m
//  EmojiString
//
//  Created by MingleChang on 16/9/22.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Emoji.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _label.font=[UIFont systemFontOfSize:5];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *lString=@"不知道呀[吓][哈哈]这是一个测试[哭笑不得][哭笑不得][哭笑不得][哭笑不得][哭笑不得][哭笑不得][哭笑不得]";
//    NSRegularExpression *regular=[NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[\\]]*\\]" options:0 error:nil];
//    [regular enumerateMatchesInString:lString options:0 range:NSMakeRange(0, lString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        NSLog(@"%@",result);
//    }];
    _label.attributedText=[lString transformEmojiAttributedString];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
