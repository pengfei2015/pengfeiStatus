//
//  WPFPhotoModel.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFPhotoModel.h"

@implementation WPFPhotoModel

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = thumbnail_pic;
    self.bmiddle_pic = [_thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
