//
//  WPFReweetFrame.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFReweetFrame.h"
#import "WPFStatus.h"
#import "WPFUserinfo.h"
#import "WPFPhotosView.h"

@implementation WPFReweetFrame

- (void)setStatus:(WPFStatus *)status
{
    _status = status;
    
    CGFloat margin = 10;
    // 1.正文
    CGFloat h = 0;
    CGFloat textX = margin;
    CGFloat textY = margin * 0.5;
    CGFloat maxW = SCREEN_WIDTH - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.reweetFrame = (CGRect){{textX, textY}, textSize};
    h = CGRectGetMaxY(self.reweetFrame) + margin;
    
    // 2.配图相册
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.reweetFrame) + margin * 0.5;
        CGSize photosSize = [WPFPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        h = CGRectGetMaxY(self.photosFrame) + margin;
    }
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SCREEN_WIDTH;
    self.frame = CGRectMake(x, y, w, h);
    
}
@end
