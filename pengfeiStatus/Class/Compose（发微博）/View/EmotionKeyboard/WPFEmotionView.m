//
//  WPFEmotionView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotionView.h"
#import "WPFEmotion.h"

@implementation WPFEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(WPFEmotion *)emotion
{
    _emotion = emotion;

    if (_emotion.code) {
        [self setTitle:_emotion.emoji forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setImage:nil forState:UIControlStateNormal];
    }else{
        [self setTitle:nil forState:UIControlStateNormal];
        NSString *name = [NSString stringWithFormat:@"%@/%@",_emotion.directory,_emotion.png];
        UIImage *image = [UIImage imageNamed:name];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:image forState:UIControlStateNormal];
    }
}

@end
