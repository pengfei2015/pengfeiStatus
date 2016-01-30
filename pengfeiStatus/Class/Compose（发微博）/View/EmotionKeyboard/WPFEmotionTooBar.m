//
//  WPFEmotionTooBar.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/18.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotionTooBar.h"

#define MAX_COUNT 4

@interface WPFEmotionTooBar ()
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, weak) UIButton *defaultButton;
@end
@implementation WPFEmotionTooBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addButtonWithTitle:@"最近" type:WPFEmotionTypeRecent];
        
        self.defaultButton = [self addButtonWithTitle:@"默认" type:WPFEmotionTypeDefault];
        
        [self addButtonWithTitle:@"Emoji" type:WPFEmotionTypeEmoji];
        
        [self addButtonWithTitle:@"浪小花" type:WPFEmotionTypeLxh];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionviewClick:) name:SELECT_EMOTIONVIEW_NOTIFICATION object:nil];
    }
    
    return self;
}

- (void)emotionviewClick:(NSNotificationCenter *)note{
    if (WPFEmotionTypeRecent == self.selectButton.tag) {
        [self btnClick:self.selectButton];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    
    for (int i = 0; i < count; ++i) {
        CGFloat buttonX = buttonW * i;
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
- (UIButton *)addButtonWithTitle:(NSString *)title type:(WPFEmotionType)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = type;
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    // 设置背景图片
    int count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == MAX_COUNT) { // 最后一个按钮
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizeImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    return btn;
}


- (void)btnClick:(UIButton *)btn
{
    self.selectButton.selected = NO;
    btn.selected = YES;
    self.selectButton = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTooBar:ClickWithButtonTpye:)]) {
        [self.delegate emotionTooBar:self ClickWithButtonTpye:btn.tag];
    }
}

- (void)setDelegate:(id<WPFEmotionTooBarDelegate>)delegate
{
    _delegate = delegate;
    [self btnClick:self.defaultButton];
}
@end
