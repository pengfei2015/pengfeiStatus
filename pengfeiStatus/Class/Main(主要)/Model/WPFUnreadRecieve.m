//
//  WPFUnreadRecieve.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFUnreadRecieve.h"

@implementation WPFUnreadRecieve

- (int)message
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}


- (int)totalCount
{
    return self.message + self.status + self.follower;
}
@end
