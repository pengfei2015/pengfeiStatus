//
//  WPFCellToolBar.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WPFCellToolBarRetweet,
    WPFCellToolBarComment,
    WPFCellToolBarAttitude
}WPFCellToolBarType;


@class WPFStatus;
@interface WPFCellToolBar : UIView
@property (nonatomic, strong) WPFStatus *status;
@end
