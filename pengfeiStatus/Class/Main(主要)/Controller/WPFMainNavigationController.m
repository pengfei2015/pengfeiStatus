//
//  WPFMainNavigationController.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFMainNavigationController.h"

@implementation WPFMainNavigationController

+ (void)initialize
{
    
    [self setupBarButtonItem];
    
    
}

+ (void)setupBarButtonItem
{
    UIBarButtonItem *apperance = [UIBarButtonItem appearance];
    NSMutableDictionary *norDict = [NSMutableDictionary dictionary];
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:18.0];
    norDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, 0);
    norDict[NSShadowAttributeName] = shadow;
    
    [apperance setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    NSMutableDictionary *highDict = [NSMutableDictionary dictionary];
    highDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [apperance setTitleTextAttributes:highDict forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableDict = [NSMutableDictionary dictionary];
    disableDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [apperance setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
}
@end
