//
//  UIBarButtonItem+Extension.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)imageName highImage:(NSString *)highName target:(id)target action:(SEL)action;
@end
