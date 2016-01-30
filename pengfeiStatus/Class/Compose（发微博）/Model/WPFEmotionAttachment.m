//
//  WPFEmotionAttachment.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/24.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotionAttachment.h"
#import "WPFEmotion.h"

@implementation WPFEmotionAttachment

- (void)setEmotion:(WPFEmotion *)emotion{
    _emotion = emotion;
    NSString *name = [NSString stringWithFormat:@"%@/%@",_emotion.directory,_emotion.png];
    self.image = [UIImage imageNamed:name];
}
@end
