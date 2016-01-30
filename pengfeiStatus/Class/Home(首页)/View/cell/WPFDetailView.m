//
//  WPFDetailView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFDetailView.h"
#import "WPFOriginalView.h"
#import "WPFReweetView.h"
#import "WPFDetailFrame.h"

@interface WPFDetailView ()

@property (nonatomic, weak) WPFOriginalView *originalView;
@property (nonatomic, weak) WPFReweetView *reweetView;

@end
@implementation WPFDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        WPFOriginalView *originalView = [[WPFOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        WPFReweetView *reweetView = [[WPFReweetView alloc] init];
        reweetView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:reweetView];
        self.reweetView = reweetView;
    }
    return self;
}

- (void)setDetailFrame:(WPFDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = _detailFrame.frame;
    
    self.originalView.originalFrame = _detailFrame.originalFrame;
    
    self.reweetView.reweetFrame = _detailFrame.reweetFrame;
    
}
@end
