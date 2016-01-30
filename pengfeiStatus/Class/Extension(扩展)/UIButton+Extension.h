//
//  UIButton+Extension.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

+ (UIButton *)addBackgroundNorImage:(NSString *)norImageName highImage:(NSString *)highImageName title:(NSString *)title target:(id)target action:(SEL)action;

- (void)setImage:(NSString *)imageName highImageName:(NSString *)highImageName;
@end
