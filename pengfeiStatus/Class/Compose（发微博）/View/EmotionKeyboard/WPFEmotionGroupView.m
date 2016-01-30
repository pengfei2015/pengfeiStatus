//
//  WPFEmotionGroupView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotionGroupView.h"
#import "WPFEmotionView.h"
#import "WPFPopView.h"
#import "WPFEmotionTool.h"

@interface WPFEmotionGroupView ()

@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, weak) UIButton *deletButton;
@property (nonatomic, strong) WPFPopView *popView;
@property (nonatomic, weak) WPFEmotionView *selectEmotionView;
@end
@implementation WPFEmotionGroupView

- (WPFPopView *)popView
{
    if (!_popView) {
        _popView = [WPFPopView popView];
    }
    return _popView;
}

- (NSMutableArray *)emotionViews{
    if (!_emotionViews) {
        _emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
 
        
        UIButton *deletButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deletButton setImage:@"compose_emotion_delete" highImageName:@"compose_emotion_delete_highlighted"];
        [deletButton addTarget:self action:@selector(deletButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deletButton];
        self.deletButton = deletButton;
        
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

// 触发手势
- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    // 捕获触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    // 检测触摸点落在哪个表情
    WPFEmotionView *emotionView = [self emotionWithPoint:point];
    
    if (UIGestureRecognizerStateEnded == recognizer.state) {
        [self.popView dismiss];
        [self selectEmotionViewWithEmotionView:emotionView];
    }else{
        [self.popView showFrameEmotionView:emotionView];
    }
}

- (WPFEmotionView *)emotionWithPoint:(CGPoint)point
{
    __block WPFEmotionView *emotionView = nil;
    
    // 循环遍历
    [self.emotionViews enumerateObjectsUsingBlock:^(WPFEmotionView *obj, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            emotionView = (WPFEmotionView *)obj;
            *stop = YES;
        }
    }];
    return emotionView;
}


- (void)deletButtonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DELETE_EMOTIONVIEW_NOTIFICATION object:nil userInfo:nil];
}


- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    // 获取应该显示数据的个数
    NSInteger count = _emotions.count;
    // 获取当前view共有多少个
    NSInteger currentCount = self.emotionViews.count;
    for (int i = 0; i < count; ++i) {
        WPFEmotionView *emotionView = nil;
        if (i >= currentCount) {
            emotionView = [[WPFEmotionView alloc] init];
            [self addSubview:emotionView];
            [emotionView addTarget:self action:@selector(emotionViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.emotionViews addObject:emotionView];
        }else{
            emotionView = self.emotionViews[i];
        }
        emotionView.emotion = _emotions[i];
        emotionView.hidden = NO;
    }
    
    for (int i = count; i < currentCount; ++i) {
        WPFEmotionView *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
    
}

- (void)emotionViewClick:(WPFEmotionView *)emotionView{
    // 预览下图片
    [self.popView showFrameEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
    // 把点击的表情加载到textview上  这个得用通知  因为当长按的时候也要触发这个方法，所以能写一起。  因为视图的层数太多  所以不宜使用代理  应适用通知
    [self selectEmotionViewWithEmotionView:emotionView];
}

- (void)selectEmotionViewWithEmotionView:(WPFEmotionView *)emotionView{
    self.selectEmotionView = emotionView;
    
    [WPFEmotionTool addRecentEmotion:self.selectEmotionView.emotion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SELECT_EMOTIONVIEW_NOTIFICATION object:nil userInfo:@{SELECT_EMOTIONVIEW:emotionView}];
    
}
    

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat leftInsert = 15;
    CGFloat topInsert = 15;
    
    NSInteger totalCount = self.emotionViews.count;
    NSInteger maxClos = 7;
    NSInteger maxRows = 3;
    
    CGFloat emotionW = (self.width - leftInsert * 2) / maxClos;
    CGFloat emitionH = (self.height - topInsert) / maxRows;
    for (int i = 0; i < totalCount; ++i) {
        CGFloat emotionX = leftInsert + i % maxClos * emotionW;
        CGFloat emotionY = topInsert +i / maxClos * emitionH;
        WPFEmotionView *emotionView = self.emotionViews[i];
        emotionView.frame = CGRectMake(emotionX, emotionY, emotionW, emitionH);
    }
    
    CGFloat deletButtonW = emotionW;
    CGFloat deletButtonH = emitionH;
    CGFloat deletButtonX = self.width - leftInsert - deletButtonW;
    CGFloat deletButtonY = self.height - deletButtonH;
    self.deletButton.frame = CGRectMake(deletButtonX, deletButtonY, deletButtonW, deletButtonH);
}
@end
