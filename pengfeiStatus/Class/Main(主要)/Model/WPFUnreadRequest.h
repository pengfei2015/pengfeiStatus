//
//  WPFUnreadRequest.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFUnreadRequest : NSObject
/**  string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString * access_token;

/**  int64 	需要获取消息未读数的用户UID，必须是当前登录用户。*/
@property (nonatomic, copy) NSString * uid;

@end
