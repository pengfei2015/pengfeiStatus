//
//  WPFComposeTabBar.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WPFComposeToolbarButtonTypeCamera, // 照相机
    WPFComposeToolbarButtonTypePicture, // 相册
    WPFComposeToolbarButtonTypeMention, // 提到@
    WPFComposeToolbarButtonTypeTrend, // 话题
    WPFComposeToolbarButtonTypeEmotion // 表情
} WPFComposeToolbarButtonType;

@class WPFComposeTabBar;

@protocol WPFComposeTabBarDelegate <NSObject>

@optional
- (void)composeTabBar:(WPFComposeTabBar *)composeTabBar
              onClick:(WPFComposeToolbarButtonType)type;

@end
@interface WPFComposeTabBar : UIView

@property (nonatomic, weak) id<WPFComposeTabBarDelegate>delegate;
@end
