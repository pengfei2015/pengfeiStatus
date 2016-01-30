//
//  WPFEmotionKeyboard.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/18.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotionKeyboard.h"
#import "WPFEmotionList.h"
#import "WPFEmotionTooBar.h"
#import "WPFEmotionTool.h"

@interface WPFEmotionKeyboard () <WPFEmotionTooBarDelegate>

@property (nonatomic, weak) WPFEmotionList *list;
@property (nonatomic, weak) WPFEmotionTooBar *toolBar;

@end
@implementation WPFEmotionKeyboard

+ (instancetype)keybored
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        WPFEmotionList *list = [[WPFEmotionList alloc] init];
        [self addSubview:list];
        self.list = list;
        
        WPFEmotionTooBar *tooBar = [[WPFEmotionTooBar alloc] init];
        tooBar.delegate = self;
        [self addSubview:tooBar];
        self.toolBar = tooBar;
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
 
    CGFloat tooBarW = self.width;
    CGFloat tooBarH = 30;
    CGFloat tooBarX = 0;
    CGFloat tooBarY = self.height - tooBarH;
    self.toolBar.frame = CGRectMake(tooBarX, tooBarY, tooBarW, tooBarH);
    
    CGFloat listW = tooBarW;
    CGFloat listH = tooBarY;
    CGFloat listX = 0;
    CGFloat listY = 0;
    self.list.frame = CGRectMake(listX, listY, listW, listH);
}

#pragma mark - WPFEmotionTooBarDelegate
- (void)emotionTooBar:(WPFEmotionTooBar *)tooBar ClickWithButtonTpye:(WPFEmotionType)type{
    switch (type) {
        case WPFEmotionTypeRecent:
        {
            self.list.emotions = [WPFEmotionTool recentEmotions];
        }
            break;
        case WPFEmotionTypeDefault:
        {
            self.list.emotions = [WPFEmotionTool defaultEmotions];
        }
            break;
        case WPFEmotionTypeEmoji:
        {
            self.list.emotions = [WPFEmotionTool emojiEmotions];
        }
            break;
        case WPFEmotionTypeLxh:
        {
            self.list.emotions = [WPFEmotionTool lxhEmotions];
        }
            break;
            
        default:
            break;
    }

}
@end
