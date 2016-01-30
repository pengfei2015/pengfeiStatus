//
//  WPFphotosView.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPFPhotosView : UIView

@property (nonatomic, strong) NSArray *pic_urls;

+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
