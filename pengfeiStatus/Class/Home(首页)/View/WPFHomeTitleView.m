//
//  WPFHomeTitleView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFHomeTitleView.h"

#define TITLE_FONT [UIFont systemFontOfSize:18.0]
@implementation WPFHomeTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = TITLE_FONT;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat y = 0;
    CGFloat x = 0;
    CGFloat w = self.width - self.height;
    CGFloat h = self.height;
    return CGRectMake(x, y, w, h);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = self.height;
    CGFloat w = h;
    CGFloat y = 0;
    CGFloat x = self.width - w;
    return CGRectMake(x, y, w, h);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGSize tilteSize = [title sizeWithFont:TITLE_FONT];
    self.width = tilteSize.width + self.height + 10;
}
@end
