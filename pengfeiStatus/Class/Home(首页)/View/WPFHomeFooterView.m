//
//  WPFHomeFooterView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFHomeFooterView.h"

@interface WPFHomeFooterView ()

@property (nonatomic, weak) UILabel *lab;
@property (nonatomic, weak) UIActivityIndicatorView *activity;

@end
@implementation WPFHomeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
        lab.frame = self.bounds;
        lab.textColor = [UIColor blackColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:15.0];
        lab.text = @"上拉加载更多。。。";
        [self addSubview:lab];
        self.lab = lab;
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
        activity.hidesWhenStopped = YES;
        [self addSubview:activity];
        self.activity = activity;
    }
    return self;
}

- (void)startAnimation
{
    self.lab.text = @"拼命加载中，请休息一下。。。";
    [self.activity startAnimating];
    self.refreshing = YES;
}

- (void)stopAnimation
{
    self.lab.text = @"上拉加载更多。。。";
    [self.activity stopAnimating];
    self.refreshing = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = 44;
    
    CGFloat activityW = self.height;
    CGFloat activityH = self.height;
    CGFloat activityX = self.width - self.height;
    CGFloat activityY = 0;
    self.activity.frame = CGRectMake(activityX, activityY, activityW, activityH);
    
    CGFloat labX = 0;
    CGFloat labY = 0;
    CGFloat labW = self.width;
    CGFloat labH = self.height;
    self.lab.frame = CGRectMake(labX, labY, labW, labH);
}
@end
