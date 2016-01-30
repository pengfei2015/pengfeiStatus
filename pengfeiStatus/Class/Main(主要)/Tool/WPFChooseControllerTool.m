//
//  WPFChooseControllerTool.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFChooseControllerTool.h"
#import "WPFAccount.h"
#import "WPFNewFeartureVC.h"
#import "WPFOAuthVC.h"
#import "WPFMainTabBarController.h"

@implementation WPFChooseControllerTool

+ (void)chooseController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    WPFAccount *account = [WPFAccount account];
    if (!account) {
        // 如果第一次登陆
        window.rootViewController = [[WPFOAuthVC alloc] init];
    }else{
        // 如果不是第一次登陆
        NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
        // 取出上次存储的版本号
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *version = [defaults objectForKey:versionKey];
        // 取出正在调试对版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
        if (![version isEqualToString:currentVersion]) { // 如果版本不同 进入新特性
            [UIApplication sharedApplication].statusBarHidden = YES;
            window.rootViewController = [[WPFNewFeartureVC alloc] init];
        }else
        {
            // 如果版本相同 进入主界面
            window.rootViewController = [[WPFMainTabBarController alloc] init];
        }

    }
}
@end
