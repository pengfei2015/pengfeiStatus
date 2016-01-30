//
//  UIBarButtonItem+Extension.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)imageName highImage:(NSString *)highName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton addBackgroundNorImage:imageName highImage:highName title:nil target:target action:action];
    button.size = button.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
