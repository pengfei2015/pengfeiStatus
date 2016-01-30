//
//  WPFEmotionTool.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotionTool.h"
#import "MJExtension.h"
#import "WPFEmotion.h"
#import "WPFEmotionView.h"

#define RECENT_EMOTIONS_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"recentEmotions.data"]

@implementation WPFEmotionTool

static NSArray *_defaultEmotions;
static NSArray *_emojiEmotions;
static NSArray *_lxhEmotions;
static NSMutableArray *_recentEmotions;
+ (NSArray *)defaultEmotions{
    if(!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        
        _defaultEmotions = [WPFEmotion objectArrayWithFile:path];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}


+ (NSArray *)emojiEmotions{
    if(!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        
        _emojiEmotions = [WPFEmotion objectArrayWithFile:path];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;}

+ (NSArray *)lxhEmotions{
    if(!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        
        _lxhEmotions = [WPFEmotion objectArrayWithFile:path];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (void)addRecentEmotion:(WPFEmotion *)emtion{
    [self recentEmotions];
    // 删除原有的这个这个数据
    [_recentEmotions removeObject:emtion];
    // 添加新的数据，并在最前面
    [_recentEmotions insertObject:emtion atIndex:0];
    // 存储整个文件  貌似效率不是很高
#warning 为什么没有文件？
    //NSDocumentationDirectory 和  NSDocumentDirectory
    
    // 点击自己  
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:RECENT_EMOTIONS_PATH];
    
    
}

+ (NSMutableArray *)recentEmotions{
    if(!_recentEmotions){ // 如果为空就进入  每次启动的时候都是空的
        NSString *path = RECENT_EMOTIONS_PATH;
        WPFLog(@"%@",path);
        // 读取文件中的内容
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_recentEmotions) { // 如果内容为空  则创建数组
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}


+ (WPFEmotion *)emotionWithDesc:(NSString *)desc
{
    if (!desc) return nil;
    
    __block WPFEmotion *foundEmotion = nil;
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(WPFEmotion *obj, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:obj.chs] || [desc isEqualToString:obj.cht]) {
            foundEmotion = obj;
            *stop = YES;
        }
    }];
    
    if (foundEmotion) return foundEmotion;
    
    // 从浪小花里面找
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(WPFEmotion *obj, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:obj.chs] || [desc isEqualToString:obj.cht]) {
            foundEmotion = obj;
            *stop = YES;
        }
    }];
    return foundEmotion;
}
@end
