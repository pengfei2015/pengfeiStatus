//
//  WPFReweetFrame.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPFStatus;
@interface WPFReweetFrame : NSObject
@property (nonatomic, strong) WPFStatus *status;
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) CGRect reweetFrame;
@property (nonatomic, assign) CGRect photosFrame;

@end
