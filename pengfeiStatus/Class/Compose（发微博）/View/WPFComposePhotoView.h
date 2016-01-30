//
//  WPFComposePhotoView.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPFComposePhotoView : UIView

- (void)addImage:(UIImage *)image;

@property (nonatomic, strong) NSArray *images;

@end
