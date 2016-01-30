//
//  WPFPopView.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPFEmotionView;

@interface WPFPopView : UIView

+ (instancetype)popView;
- (void)dismiss;
- (void)showFrameEmotionView:(WPFEmotionView *)emotionView;

@end
