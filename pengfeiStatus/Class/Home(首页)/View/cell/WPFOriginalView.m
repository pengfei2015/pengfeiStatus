//
//  WPFOriginalView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFOriginalView.h"
#import "WPFOriginalFrame.h"
#import "UIImageView+WebCache.h"
#import "WPFStatus.h"
#import "WPFUserinfo.h"
#import "WPFPhotosView.h"
#import "WPFStatusLab.h"

@interface WPFOriginalView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLab;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel *timeLab;
@property (nonatomic, weak) UILabel *sourceLab;
@property (nonatomic, weak) WPFStatusLab *textLab;
@property (nonatomic, weak) WPFPhotosView *photosView;
@end
@implementation WPFOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.font = NAME_FONT;
        [self addSubview:nameLab];
        self.nameLab = nameLab;
        
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        UILabel *timeLab = [[UILabel alloc] init];
        timeLab.textColor = [UIColor orangeColor];
        timeLab.font = TIME_FONT;
        [self addSubview:timeLab];
        self.timeLab = timeLab;
        
        UILabel *sourceLab = [[UILabel alloc] init];
        sourceLab.font = TIME_FONT;
        [self addSubview:sourceLab];
        self.sourceLab = sourceLab;
        
        WPFStatusLab *textLab = [[WPFStatusLab alloc] init];
//        textLab.font = NAME_FONT;
//        textLab.numberOfLines = 0;
        [self addSubview:textLab];
        self.textLab = textLab;
        
        WPFPhotosView *photosView = [[WPFPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setOriginalFrame:(WPFOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    
    WPFStatus *status = _originalFrame.status;
    WPFUserinfo *user = status.user;
    
    self.frame = _originalFrame.frame;
    
    self.iconView.frame = _originalFrame.iconFrame;
    
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"]];
    
    self.nameLab.frame = _originalFrame.nameFrame;
    self.nameLab.text = user.screen_name;
    
    if (user.isVip) {
        self.vipView.frame = _originalFrame.vipFrame;
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.nameLab.textColor = [UIColor orangeColor];
    }else{
        self.nameLab.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    NSString *time = status.created_at;
    CGFloat timeX = self.nameLab.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLab.frame);
    CGSize timeSize = [time sizeWithFont:TIME_FONT];
    
    self.timeLab.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLab.text = time;

    CGFloat sourceX = 10 + CGRectGetMaxX(self.timeLab.frame);
    CGFloat sourceY = CGRectGetMaxY(self.nameLab.frame);
    CGSize sourceSize = [status.source sizeWithFont:TIME_FONT];
    self.sourceLab.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLab.text = status.source;
    
    
    if (status.isReweeted) {
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedString];
        int len = user.name.length + 4;
        [text deleteCharactersInRange:NSMakeRange(0, len)];
        self.textLab.attributedText = text;
    } else {
        self.textLab.attributedText = status.attributedString;
    }
    self.textLab.frame = originalFrame.textFrame;

    
    if (status.pic_urls.count) {
        self.photosView.frame = _originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
}
@end
