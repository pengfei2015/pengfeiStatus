//
//  WPFMainTabBar.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPFMainTabBar;

@protocol WPFMainTabBarDelegate <NSObject>

@optional
- (void)tabbar:(WPFMainTabBar *)tabbar plusBtnOnClick:(UIButton *)plusBtn;

@end

@interface WPFMainTabBar : UITabBar

@property (nonatomic, weak) id <WPFMainTabBarDelegate>mainTabBarDeleagte;
@end
