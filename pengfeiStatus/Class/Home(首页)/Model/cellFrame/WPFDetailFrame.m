//
//  WPFDetailFrame.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFDetailFrame.h"
#import "WPFOriginalFrame.h"
#import "WPFReweetFrame.h"
#import "WPFStatus.h"

@implementation WPFDetailFrame
- (void)setStatus:(WPFStatus *)status
{
    _status = status;
    
    // 1.计算原创微博的frame
    WPFOriginalFrame *originalFrame = [[WPFOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    // 2.计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        WPFReweetFrame *retweetedFrame = [[WPFReweetFrame alloc] init];
        retweetedFrame.status = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.reweetFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SCREEN_WIDTH;
    self.frame = CGRectMake(x, y, w, h);
    
    
}
@end
