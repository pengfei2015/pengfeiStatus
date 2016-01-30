//
//  WPFStatusFrame.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPFStatus,WPFDetailFrame,WPFCellToolBarFrame;
@interface WPFStatusFrame : NSObject

@property (nonatomic, strong) WPFStatus *status;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) WPFDetailFrame *detailFrame;
@property (nonatomic, assign) CGRect toolBarFrame;
@property (nonatomic, assign) CGRect frame;
@end
