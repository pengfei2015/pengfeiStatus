//
//  WPFAccount.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFAccount : NSObject<NSCoding>

/**  用于调用access_token，接口获取授权后的access token*/
@property (nonatomic, copy) NSString * access_token;
/**  access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSString * expires_in;
/**  string 	当前授权用户的UID*/
@property (nonatomic, copy) NSString * uid;
/**  过期时间*/
@property (nonatomic, strong) NSDate * expires_time;
/**  string 	用户昵称*/
@property (nonatomic, copy) NSString * screen_name;

+ (void)save:(WPFAccount *)account;
+ (WPFAccount *)account;
@end
