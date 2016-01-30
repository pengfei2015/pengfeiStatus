//
//  WPFEmotionList.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/18.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotionList.h"
#import "WPFEmotionGroupView.h"

@interface WPFEmotionList () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
@implementation WPFEmotionList

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 创建滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
         //创建指示视图
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        pageControl.backgroundColor = [UIColor redColor];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat pageControlW = self.width;
    CGFloat pageControlH = 35;
    CGFloat pageControlX = 0;
    CGFloat pageControlY = self.height - pageControlH;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    CGFloat scrollViewW = self.width;
    CGFloat scrollViewH = self.height - pageControlH;
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    NSInteger count = self.pageControl.numberOfPages;
    
    CGFloat groupViewW = self.scrollView.width;
    CGFloat groupViewH = self.scrollView.height;
    CGFloat groupViewY = 0;
    CGFloat groupViewX = 0;
    self.scrollView.contentSize = CGSizeMake(count * groupViewW, groupViewH);
    
    for (int i = 0; i < count; ++i) {
        groupViewX = groupViewW * i;
        WPFEmotionGroupView *groupView = self.scrollView.subviews[i];
        groupView.frame = CGRectMake(groupViewX, groupViewY, groupViewW, groupViewH);
    }
    
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSInteger totalCount = _emotions.count;
    NSInteger maxCountPerPage = 20;
    NSInteger maxPage = (totalCount + maxCountPerPage - 1) / maxCountPerPage;
    NSInteger currentGroup = self.scrollView.subviews.count;
    
    for (int i = 0; i < maxPage; ++i) {
        WPFEmotionGroupView *groupView = nil;
        if (i >= currentGroup) {
            groupView = [[WPFEmotionGroupView alloc] init];
            [self.scrollView addSubview:groupView];
        }else{
            groupView = self.scrollView.subviews[i];
        }
        // 传递每个页面显示的数据
        NSInteger loc = i * maxCountPerPage;
        NSInteger len = maxCountPerPage;
        if (loc + len > _emotions.count) {
            len = _emotions.count - loc;
        }
        NSRange rang = NSMakeRange(loc, len);
        NSArray *groupArr = [_emotions subarrayWithRange:rang];
        groupView.emotions = groupArr;
        
        groupView.hidden = NO;
    }
    
    for (int i = maxPage; i < currentGroup; ++i) {
        WPFEmotionGroupView *groupView = self.scrollView.subviews[i];
        groupView.hidden = YES;
    }
    
    [self setNeedsLayout];
    
    self.scrollView.contentOffset = CGPointZero;
    
    self.pageControl.numberOfPages = maxPage;
    self.pageControl.currentPage = 0;
    self.pageControl.hidden = maxPage <= 1;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = (NSInteger)scrollView.contentOffset.x / scrollView.width + 0.5;
    self.pageControl.currentPage = page;
}

@end
