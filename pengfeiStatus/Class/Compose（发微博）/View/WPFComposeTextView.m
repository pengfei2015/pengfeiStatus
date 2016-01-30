//
//  WPFComposeTextView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFComposeTextView.h"
#import "WPFEmotion.h"
#import "WPFEmotionAttachment.h"
#import "WPFEmotionAttachment.h"

@interface WPFComposeTextView ()

@property (nonatomic, weak) UILabel *placeholderLab;

@end
@implementation WPFComposeTextView

-  (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textChange];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLab.font = font;
    [self setNeedsLayout];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLab.text = placeholder;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLab.textColor = placeholderColor;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *placeholderLab = [[UILabel alloc] init];
        [self addSubview:placeholderLab];
        placeholderLab.text = @"分享新鲜事...";
        placeholderLab.font = [UIFont systemFontOfSize:14.0];
        placeholderLab.textColor = [UIColor lightGrayColor];
        self.placeholderLab = placeholderLab;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textChange
{
    self.placeholderLab.hidden = self.text.length;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [self.placeholderLab.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLab.font} context:nil].size;
    self.placeholderLab.width = size.width;
    self.placeholderLab.height = size.height;
    self.placeholderLab.x = 5;
    self.placeholderLab.y = 8;

}

- (void)appendEmotion:(WPFEmotion *)emotion{
    if (emotion.emoji) {
        [self insertText:emotion.emoji];
    }else{
        // 初始化
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        // 创建一个带有图片表情的富文本
        WPFEmotionAttachment *attachment = [[WPFEmotionAttachment alloc] init];
        attachment.emotion = emotion;
        attachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        int index = self.selectedRange.location;
        
        [attributedText insertAttributedString:attributedString atIndex:index];
        
        // 设置字体
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        // 重新赋值  光标在文字最后面
        self.attributedText = attributedText;
        // 光标回到表情后面的位置
        self.selectedRange = NSMakeRange(index + 1, 0);
        
    }
}

- (NSString *)realString{
    NSMutableString *mutableString = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        WPFEmotionAttachment *attachment = attrs[@"NSAttachment"];
        if (attachment) {
            [mutableString appendString:attachment.emotion.chs];
        }else{
            NSString *substr = [self.attributedText attributedSubstringFromRange:range].string;
            [mutableString appendString:substr];
        }
    }];
    return mutableString;
}
@end
