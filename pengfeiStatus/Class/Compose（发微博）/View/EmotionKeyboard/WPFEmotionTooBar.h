//
//  WPFEmotionTooBar.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/18.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WPFEmotionType) {
    WPFEmotionTypeRecent,
    WPFEmotionTypeDefault,
    WPFEmotionTypeEmoji,
    WPFEmotionTypeLxh
};

@class WPFEmotionTooBar;

@protocol WPFEmotionTooBarDelegate <NSObject>
@optional
- (void)emotionTooBar:(WPFEmotionTooBar *)tooBar ClickWithButtonTpye:(WPFEmotionType)type;

@end
@interface WPFEmotionTooBar : UIView

@property (nonatomic, weak) id <WPFEmotionTooBarDelegate> delegate;
//@property (nonatomic, assign) WPFEmotionType type;
@end
