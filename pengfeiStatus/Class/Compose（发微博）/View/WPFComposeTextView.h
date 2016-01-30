//
//  WPFComposeTextView.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPFEmotion;
@interface WPFComposeTextView : UITextView

@property (nonatomic, copy) NSString * placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
- (void)appendEmotion:(WPFEmotion *)emotion;
- (NSString *)realString;
@end
