//
//  WPFReweetView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFReweetView.h"
#import "WPFReweetFrame.h"
#import "WPFStatus.h"
#import "WPFUserinfo.h"
#import "WPFPhotosView.h"
#import "WPFStatusLab.h"


@interface WPFReweetView ()
@property (nonatomic, weak) WPFStatusLab *textLab;
@property (nonatomic, weak) WPFPhotosView *photosView;
@end
@implementation WPFReweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        WPFStatusLab *textLab = [[WPFStatusLab alloc] init];
        [self addSubview:textLab];
        self.textLab = textLab;
        
        WPFPhotosView *photosView = [[WPFPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setReweetFrame:(WPFReweetFrame *)reweetFrame
{
    _reweetFrame = reweetFrame;
    self.frame = _reweetFrame.frame;
    

    self.textLab.frame = _reweetFrame.reweetFrame;
    WPFStatus *status = _reweetFrame.status;
    
    self.textLab.attributedText = status.attributedString;
    self.textLab.frame = reweetFrame.reweetFrame;
    
    if (status.pic_urls.count) {
        self.photosView.frame = _reweetFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
}
@end
