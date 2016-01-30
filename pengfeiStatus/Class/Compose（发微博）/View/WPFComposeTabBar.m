//
//  WPFComposeTabBar.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFComposeTabBar.h"

@implementation WPFComposeTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setBackgroundImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" tag:WPFComposeToolbarButtonTypeCamera];
        [self setBackgroundImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" tag:WPFComposeToolbarButtonTypePicture];
        [self setBackgroundImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" tag:WPFComposeToolbarButtonTypeMention];
        [self setBackgroundImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" tag:WPFComposeToolbarButtonTypeTrend];
        [self setBackgroundImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" tag:WPFComposeToolbarButtonTypeEmotion];
    }
    return self;
}

- (UIButton *)setBackgroundImage:(NSString *)norImageName highImage:(NSString *)highImageName tag:(WPFComposeToolbarButtonType)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:norImageName highImageName:highImageName];
    btn.tag = type;
    [btn addTarget:self action:@selector(tabBarOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (void)tabBarOnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeTabBar:onClick:)]) {
        [self.delegate composeTabBar:self onClick:btn.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.width / self.subviews.count;
    CGFloat h = self.height;
    CGFloat y = 0;
    CGFloat x = 0;
    
    for (int i = 0; i < self.subviews.count; ++i) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}
@end
