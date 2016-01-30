//
//  WPFComposePhotoView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFComposePhotoView.h"
#define MAXCOUNT 9
@implementation WPFComposePhotoView

- (NSArray *)images
{
    
//    if (!_images) {
//        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:MAXCOUNT];
//        for (UIImageView *imageView in self.subviews) {
//            [arr addObject:imageView.image];
//        }
//        _images = arr;
//    }
//    return _images;  这样数组里面添加不了东西
    
    NSMutableArray *arr  = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [arr addObject:imageView.image];
    }
    return arr;
}


- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.backgroundColor = [UIColor redColor];
    [self addSubview:imageView];
    imageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.images.count;
    int maxClos = 4;
    int margin = 10;
    CGFloat imageViewW = (self.width - (maxClos + 1) * margin) / maxClos;
    CGFloat imageViewH = imageViewW;
    for (int i = 0; i < count; ++i) {
        CGFloat imageViewX = margin + i % maxClos *(imageViewW + margin);
        CGFloat imageViewY = i / maxClos * (imageViewH + margin);
        UIImageView *imageView = self.subviews[i];
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
    
}

@end
