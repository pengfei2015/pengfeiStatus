//
//  WPFPopView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFPopView.h"
#import "WPFEmotionView.h"

@interface WPFPopView ()

@property (weak, nonatomic) IBOutlet WPFEmotionView *emotionView;

@end
@implementation WPFPopView


+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WPFPopView" owner:nil options:nil] lastObject];
}

- (void)showFrameEmotionView:(WPFEmotionView *)emotionView
{
    if (emotionView == nil) return;
    
    // 1.显示表情
    self.emotionView.emotion = emotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = emotionView.centerX;
    CGFloat centerY = emotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    
    self.center = [window convertPoint:center fromView:emotionView.superview];
    
}



- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect {
    //[super drawRect:rect];
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}


@end
