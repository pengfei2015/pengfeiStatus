//
//  WPFDetailFrame.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPFStatus,WPFOriginalFrame,WPFReweetFrame;
@interface WPFDetailFrame : NSObject
@property (nonatomic, strong) WPFStatus *status;
@property (nonatomic, strong) WPFOriginalFrame *originalFrame;
@property (nonatomic, strong) WPFReweetFrame *reweetFrame;
@property (nonatomic, assign) CGRect frame;
@end
