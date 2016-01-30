//
//  WPFEmotionTool.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPFEmotion;

@interface WPFEmotionTool : NSObject

/**  默认表情*/
+ (NSArray *)defaultEmotions;
/**  emoji表情*/
+ (NSArray *)emojiEmotions;
/**  浪小花表情*/
+ (NSArray *)lxhEmotions;
/**  最近表情*/
+ (NSMutableArray *)recentEmotions;

/**
 *  添加最近表情
 */
+ (void)addRecentEmotion:(WPFEmotion *)emtion;
/**
 *  根据图片的描述 返回对应的图片模型
 */
+ (WPFEmotion *)emotionWithDesc:(NSString *)desc;
@end
