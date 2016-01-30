//
//  WPFphotosView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFPhotosView.h"
#import "UIImageView+WebCache.h"
#import "WPFPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "WPFPhotoModel.h"

#define MAX_COLS(photosCount) (photosCount ==4 ?2 : 3)
#define MAX_COUNT 9
#define PHOTO_WIDTH 80
#define PHOTO_HEIGHT PHOTO_WIDTH

@implementation WPFPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < MAX_COUNT; ++i) {
            WPFPhotoView *photoView = [[WPFPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int margin = 10;
    int count = self.pic_urls.count;
    int maxCols = MAX_COLS(count);
    
    for (int i = 0; i < count; ++i) {
        
        WPFPhotoView *photoView = self.subviews[i];
        // 这里的self。width 不是屏幕的宽度  而是下面自己设置的宽度
        // 图片的宽度最好自己算出来  因为self的宽和高时根据每个图片的大小算出来的
        photoView.width = PHOTO_WIDTH;
        photoView.height = PHOTO_HEIGHT;
        photoView.x = i % maxCols * (photoView.width + margin) + margin;
        photoView.y = i / maxCols * (photoView.height + margin) + margin;
    }
   
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    int margin = 10;
    int maxCols = MAX_COLS(photosCount);
    
    int totalCols = photosCount >= maxCols ? maxCols : photosCount;
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    CGFloat photosW = totalCols * (PHOTO_WIDTH + margin) + margin;
    CGFloat photosH = totalRows * (PHOTO_HEIGHT + margin) + margin;;
    
    return CGSizeMake(photosW, photosH);
}
- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    for (int i = 0; i < MAX_COUNT; ++i) {
        WPFPhotoView *photoView = self.subviews[i];
        if (i < pic_urls.count) {
            photoView.photo = _pic_urls[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    NSMutableArray *photos = [NSMutableArray array];
    int count = self.pic_urls.count;
    
    for (int i = 0; i < count; ++i) {
        WPFPhotoModel *pic = self.pic_urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    browser.currentPhotoIndex = recognizer.view.tag;
    [browser show];
}
@end
