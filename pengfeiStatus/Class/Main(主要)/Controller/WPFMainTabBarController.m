//
//  WPFMainTabBarController.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFMainTabBarController.h"
#import "WPFHomeVC.h"
#import "WPFMessageVC.h"
#import "WPFDiscoverVC.h"
#import "WPFProfileVC.h"
#import "WPFComposeVC.h"
#import "WPFMainNavigationController.h"
#import "WPFMainTabBar.h"
#import "WPFAccount.h"
#import "WPFHttpTool.h"
#import "WPFUserinfo.h"
#import "MJExtension.h"
#import "WPFUnreadRequest.h"
#import "WPFUnreadRecieve.h"

@interface WPFMainTabBarController ()<WPFMainTabBarDelegate>

@property (nonatomic, weak) WPFHomeVC *home;
@property (nonatomic, weak) WPFMessageVC *message;
@property (nonatomic, weak) WPFDiscoverVC *discover;
@property (nonatomic, weak) WPFProfileVC *profile;

@end

@implementation WPFMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 添加子控制器
    [self setupChildVCs];
    // 2 添加自定义的tabbar
    [self setupTabBar];
    // 3 加载个人信息
    [self loadUserMessage];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)getUnreadCount
{
    WPFUnreadRequest *params = [[WPFUnreadRequest alloc] init];
    params.access_token = [WPFAccount account].access_token;
    params.uid = [WPFAccount account].uid;
    
    [WPFHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id responsObj) {
        WPFUnreadRecieve *model = [WPFUnreadRecieve objectWithKeyValues:responsObj];
        
        if (model.status) {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",model.status];
        }else{
            self.home.tabBarItem.badgeValue = nil;
        }
        if (model.message) {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",model.message];
        }else{
            self.message.tabBarItem.badgeValue = nil;
        }
        if (model.follower) {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",model.follower];
        }else{
            self.profile.tabBarItem.badgeValue = nil;
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = model.totalCount;
        WPFLog(@"%d",model.totalCount);
    } failure:^(NSError *error) {
        WPFLog(@"WPFUnreadRequest");
    }];
    
}
- (void)loadUserMessage
{
    WPFAccount *account = [WPFAccount account];
    [WPFHttpTool get:@"https://api.weibo.com/2/users/show.json" params:account success:^(id responsObj) {
        WPFUserinfo *user = [WPFUserinfo objectWithKeyValues:responsObj];
        account.screen_name = user.screen_name;
        [WPFAccount save:account];
    } failure:^(NSError *error) {
        WPFLog(@"loadUserMessage");
    }];

    
}
- (void)setupTabBar
{
    WPFMainTabBar *tabbar = [[WPFMainTabBar alloc] init];
    tabbar.mainTabBarDeleagte = self;
    [self setValue:tabbar forKey:@"tabBar"];
}
- (void)setupChildVCs
{
    // 添加子控制器
    WPFHomeVC *home = [[WPFHomeVC alloc] init];
    [self addChildViewController:home title:@"首页" norImageName:@"tabbar_home" selectImageName:@"tabbar_home_selected"];
    self.home = home;
    
    WPFMessageVC *message = [[WPFMessageVC alloc] init];
    [self addChildViewController:message title:@"消息" norImageName:@"tabbar_message_center" selectImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    WPFDiscoverVC *discover = [[WPFDiscoverVC alloc] init];
    [self addChildViewController:discover title:@"发现" norImageName:@"tabbar_discover" selectImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    WPFProfileVC *profile = [[WPFProfileVC alloc] init];
    [self addChildViewController:profile title:@"我" norImageName:@"tabbar_profile" selectImageName:@"tabbar_profile_selected"];
    self.profile = profile;
}
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title norImageName:(NSString *)norImageName selectImageName:(NSString *)selectImageName
{
    childController.title = title;
    // 设置文字
    NSMutableDictionary *norDict = [NSMutableDictionary dictionary];
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:14.0];
    norDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, 0);
    norDict[NSShadowAttributeName] = shadow;
    [childController.tabBarItem setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
    // 设置图片
    UIImage *selectImage = [UIImage imageNamed:selectImageName];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectImage;
    UIImage *norImage = [UIImage imageNamed:norImageName];
    childController.tabBarItem.image = norImage;
    
    // 添加
    WPFMainNavigationController *nav = [[WPFMainNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
    
}

#pragma mark - WPFMainTabBarDelegate
- (void)tabbar:(WPFMainTabBar *)tabbar plusBtnOnClick:(UIButton *)plusBtn
{
    WPFComposeVC *compose = [[WPFComposeVC alloc] init];
    WPFMainNavigationController *nav = [[WPFMainNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
