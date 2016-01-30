//
//  WPFStatusFrame.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFStatusFrame.h"
#import "WPFStatus.h"
#import "WPFDetailFrame.h"
#import "WPFCellToolBarFrame.h"

@implementation WPFStatusFrame

- (void)setStatus:(WPFStatus *)status
{
    _status = status;
    
    WPFDetailFrame *detailFrame = [[WPFDetailFrame alloc] init];
    detailFrame.status = _status;
    self.detailFrame = detailFrame;
    
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = SCREEN_WIDTH;
    CGFloat toolbarH = 35;
    self.toolBarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    self.height = CGRectGetMaxY(self.toolBarFrame);
}
@end
