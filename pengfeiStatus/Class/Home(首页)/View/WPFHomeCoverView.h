//
//  WPFHomeCoverView.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPFHomeCoverView;
@protocol WPFHomeCoverViewDelegate <NSObject>
@optional

- (void)coverView:(WPFHomeCoverView *)coverView OnClick:(UIButton *)btn;

@end
@interface WPFHomeCoverView : UIView

- (void)showInRect:(CGRect)rect;

- (void)addContentView:(UIView *)conentView;
@property (nonatomic, weak) id<WPFHomeCoverViewDelegate>delegate;
@end
