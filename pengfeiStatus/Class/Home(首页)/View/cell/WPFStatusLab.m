//
//  WPFStatusLab.m
//  鹏飞微博4
//
//  Created by 王家辉 on 15/11/26.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFStatusLab.h"
#import "WPFLink.h"

#define WPFLinkBackgroundTag 10000



@interface WPFStatusLab ()
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) NSMutableArray *links;

@end

@implementation WPFStatusLab

- (NSMutableArray *)links
{
    if (!_links) {
        NSMutableArray *links = [NSMutableArray array];
        
        // 搜索所有的链接
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSString *linkText = attrs[WPFLinkText];
            if (linkText == nil) return;
            
            // 创建一个链接
            WPFLink *link = [[WPFLink alloc] init];
            link.text = linkText;
            link.range = range;
            
            // 处理矩形框
            NSMutableArray *rects = [NSMutableArray array];
            // 设置选中的字符范围
            self.textView.selectedRange = range;
            // 算出选中的字符范围的边框
            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
                [rects addObject:selectionRect];
            }
            link.rects = rects;
            
            [links addObject:link];
        }];
        
        
        
        self.links = links;
    }
    return _links;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = [attributedText copy];
    
    self.textView.attributedText = _attributedText;
    self.links = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UITextView *textView = [[UITextView alloc] init];
        // 不能编辑
        textView.editable = NO;
        // 不能滚动
        textView.scrollEnabled = NO;
        // 设置TextView不能跟用户交互
        textView.userInteractionEnabled = NO;
        // 设置文字的内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        self.textView = textView;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
}



#pragma mark - 事件处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    WPFLink *touchingLink = [self touchingLinkWithPoint:point];
    
    // 设置链接选中的背景
    [self showLinkBackground:touchingLink];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    WPFLink *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        // 说明手指在某个链接上面抬起来, 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:WPFLinkDidSelectedNotification object:nil userInfo:@{WPFLinkText : touchingLink.text}];
    }
    
    // 相当于触摸被取消
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
}

#pragma mark - 链接背景处理
/**
 *  根据触摸点找出被触摸的链接
 *
 *  @param point 触摸点
 */
- (WPFLink *)touchingLinkWithPoint:(CGPoint)point
{
    __block WPFLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(WPFLink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}

/**
 *  显示链接的背景
 *
 *  @param link 需要显示背景的link
 */
- (void)showLinkBackground:(WPFLink *)link
{
    for (UITextSelectionRect *selectionRect in link.rects) {
        UIView *bg = [[UIView alloc] init];
        bg.tag = WPFLinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.frame = selectionRect.rect;
        bg.backgroundColor = [UIColor redColor];
        [self insertSubview:bg atIndex:0];
    }
}

- (void)removeAllLinkBackground
{
    for (UIView *child in self.subviews) {
        if (child.tag == WPFLinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  这个方法会返回能够处理事件的控件
 *  这个方法可以用来拦截所有触摸事件
 *  @param point 触摸点
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self touchingLinkWithPoint:point]) {
        return self;
    }
    return nil;
}


@end
