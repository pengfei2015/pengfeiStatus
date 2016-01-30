//
//  WPFUserinfo.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFUserinfo.h"

@implementation WPFUserinfo

- (BOOL)isVip
{
    return self.mbtype > 2;
}
@end
