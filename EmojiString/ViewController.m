//
//  ViewController.m
//  EmojiString
//
//  Created by MingleChang on 16/9/22.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Emoji.h"

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24)
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    //创建NSTextAttachment
//    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//    attachment.image = [UIImage imageNamed:@"tt_e0.png"];
//    attachment.bounds = CGRectMake(0, 0, 20, 20);
//
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"后面跟着图片"];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 6)];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 6)];
//    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
//    [attributedString insertAttributedString:attachmentString atIndex:6];
//    
//    //设置attributedText
//    _label.attributedText = attributedString;
    int sym = EMOJI_CODE_TO_SYMBOL(0x1f603);
    NSString *lString=[[NSString alloc]initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
    NSLog(@"%x %@",sym,lString);
    _label.text=lString;
//    _label.attributedText = [lString transformAttributedString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
