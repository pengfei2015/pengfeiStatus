//
//  WPFOriginalFrame.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPFStatus;
@interface WPFOriginalFrame : NSObject
@property (nonatomic, strong) WPFStatus *status;
@property (nonatomic, assign) CGRect frame;


@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect vipFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect sourceFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect photosFrame;

@end
