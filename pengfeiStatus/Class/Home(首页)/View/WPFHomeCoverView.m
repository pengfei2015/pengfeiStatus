//
//  WPFHomeCoverView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFHomeCoverView.h"

@interface WPFHomeCoverView ()
@property (nonatomic, weak) UIButton *coverBtn;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIView *contentView;

@end
@implementation WPFHomeCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.backgroundColor = [UIColor clearColor];
        [coverBtn addTarget:self action:@selector(coverBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverBtn];
        self.coverBtn = coverBtn;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage resizeImage:@"popover_background"];
        [coverBtn addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)addContentView:(UIView *)conentView
{
    self.contentView  = conentView;
}
- (void)coverBtnOnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(coverView:OnClick:)]) {
        [self.delegate coverView:self OnClick:btn];
    }
    [self removeFromSuperview]; 
}

- (void)showInRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.imageView.frame = rect;
    [self.imageView addSubview:self.contentView];
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.imageView.width - leftMargin - rightMargin;
    self.contentView.height = self.imageView.height - topMargin - bottomMargin;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.coverBtn.frame = self.bounds;
    
}
@end
