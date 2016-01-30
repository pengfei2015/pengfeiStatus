//
//  WPFNewFeartureVC.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFNewFeartureVC.h"
#import "WPFMainTabBarController.h"

#define MAXCOUNT 4
@interface WPFNewFeartureVC ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation WPFNewFeartureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
    
    [self setupUIPagecontrol];
}

- (void)setupUIPagecontrol
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    pageControl.numberOfPages = MAXCOUNT;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height *0.9;
    self.pageControl = pageControl;
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(MAXCOUNT * self.view.width, self.view.height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    for (int i = 0; i < MAXCOUNT; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        UIImage *image = [UIImage imageNamed:name];
        imageView.image = image;
        CGFloat w = self.view.width;
        CGFloat h = self.view.height;
        CGFloat x = i * w;
        CGFloat y = 0;
        imageView.frame = CGRectMake(x, y, w, h);
        [scrollView addSubview:imageView];
        if (MAXCOUNT - 1 == i) {
            imageView.userInteractionEnabled = YES;
            [self setupShareBtn:imageView];
            [self setupStartBtn:imageView];
        }
    }

}

- (void)setupShareBtn:(UIImageView *)imageView
{
    // 1.添加分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    
    // 2.设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.7;
    
    // 4.设置间距
    // top left bottom right
    // 内边距 == 自切
    // 被切掉的区域就不能显示内容了
    // contentEdgeInsets : 切掉按钮内部的内容
    // imageEdgeInsets : 切掉按钮内部UIImageView的内容
    // titleEdgeInsets : 切掉按钮内部UILabel的内容
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

}

- (void)share:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.isSelected;
}

- (void)setupStartBtn:(UIImageView *)imageView
{
    UIButton *start = [UIButton addBackgroundNorImage:@"new_feature_finish_button"  highImage:@"new_feature_finish_button_highlighted" title:@"开始微博" target:self action:@selector(start)];
    
    [imageView addSubview:start];
    
    start.size = start.currentBackgroundImage.size;
    start.centerX = self.view.width * 0.5;
    start.centerY = self.view.height * 0.8;
    [start setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)start
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    WPFMainTabBarController *vc = [[WPFMainTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    
    // 保存这次的版本号
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *version = [NSBundle mainBundle].infoDictionary[versionKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:version forKey:versionKey];
    [defaults synchronize];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float doublePage = scrollView.contentOffset.x / self.view.width;
    int page = (int)(doublePage + 0.5);
    self.pageControl.currentPage = page;
}

@end
