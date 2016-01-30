//
//  WPFMainTabBar.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFMainTabBar.h"

@interface WPFMainTabBar ()
@property (nonatomic, weak) UIButton *btn;

@end
@implementation WPFMainTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加自定义的按钮
        
        UIButton *btn = [UIButton addBackgroundNorImage:@"tabbar_compose_button" highImage:@"tabbar_compose_button_highlighted" title:nil target:self action:@selector(composeClick:)];
        [btn setImage:@"tabbar_compose_icon_add" highImageName:@"tabbar_compose_icon_add_highlighted"];
        [self addSubview:btn];
        self.btn = btn;
    }
    return self;
}

- (void)composeClick:(UIButton *)btn
{
    if ([self.mainTabBarDeleagte respondsToSelector:@selector(tabbar:plusBtnOnClick:)]) {
        [self.mainTabBarDeleagte tabbar:self plusBtnOnClick:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setPlusBtnFrame];
    
    [self setupTabBarButtonFrame];
}

- (void)setPlusBtnFrame
{
    self.btn.size = self.btn.currentBackgroundImage.size;
    self.btn.centerX = self.centerX;
    self.btn.centerY = self.height * 0.5;
}

- (void)setupTabBarButtonFrame
{
    int i = 0;
    for (UIView *view in self.subviews) {
        if (![view isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat w = self.width / (self.items.count + 1);
        CGFloat h = self.height;
        CGFloat y = 0;
        CGFloat x = 0;
        if (i < 2) {
            x = w * i;
        }else{
            x = w * (i + 1);
        }
        view.frame = CGRectMake(x, y, w, h);
        ++i;
    }
}
@end
