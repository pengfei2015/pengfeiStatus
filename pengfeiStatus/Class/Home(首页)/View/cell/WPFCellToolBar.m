//
//  WPFCellToolBar.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFCellToolBar.h"
#import "WPFStatus.h"

@interface WPFCellToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;
@property (nonatomic, weak) UIButton *retweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end
@implementation WPFCellToolBar

- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *retweetBtn = [self addButtonWithImage:@"timeline_icon_retweet" title:@"转发" type:WPFCellToolBarRetweet target:self action:@selector(toolBarOnClick:)];
        self.retweetBtn = retweetBtn;
        
        UIButton *commentBtn = [self addButtonWithImage:@"timeline_icon_comment" title:@"评论" type:WPFCellToolBarComment target:self action:@selector(toolBarOnClick:)];
        self.commentBtn = commentBtn;
        
        UIButton *attitudeBtn = [self addButtonWithImage:@"timeline_icon_unlike" title:@"赞" type:WPFCellToolBarAttitude target:self action:@selector(toolBarOnClick:)];
        self.attitudeBtn = attitudeBtn;
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (void)toolBarOnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case WPFCellToolBarRetweet:
        {
            
        }
            break;
        case WPFCellToolBarComment:
        {
            
        }
            break;
        case WPFCellToolBarAttitude:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.btns.count;
    
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    CGFloat y = 0;
    for (int i = 0; i < count; ++i) {
        UIButton *btn = self.btns[i];
        CGFloat x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    int dividerCount = self.dividers.count;
    for (int i = 0; i < dividerCount; ++i) {
        UIImageView *divider = self.dividers[i];
        divider.width = 4;
        divider.height = h;
        divider.centerX = (i + 1) * w;
        divider.centerY = h * 0.5;
    }
}

- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    [self.dividers addObject:divider];
                    
}

- (UIButton *)addButtonWithImage:(NSString *)name title:(NSString *)title type:(WPFCellToolBarType)type target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton addBackgroundNorImage:@"timeline_card_bottom_background" highImage:@"timeline_card_bottom_background_highlighted" title:title target:target action:action];
    btn.tag = type;
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    return btn;
}

- (void)setStatus:(WPFStatus *)status
{
    _status = status;
 
    [self setupBtn:self.retweetBtn count:_status.reposts_count defaultTitle:@"转发"];
    
    [self setupBtn:self.commentBtn count:_status.comments_count defaultTitle:@"评论"];
    
    [self setupBtn:self.attitudeBtn count:_status.attitudes_count defaultTitle:@"赞"];
}

- (void)setupBtn:(UIButton *)btn count:(long long)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) {
        defaultTitle = [NSString stringWithFormat:@"%.1f万",count/10000.0];
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if(count > 0){
        defaultTitle = [NSString stringWithFormat:@"%lld",count];
    }
    [btn setTitle:defaultTitle forState:UIControlStateNormal];
}

@end
