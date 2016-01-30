//
//  WPFAccessTokenRequest.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFAccessTokenRequest : NSObject

/**  string 	申请应用时分配的AppKey。*/
@property (nonatomic, copy) NSString * client_id;
/**  string 	申请应用时分配的AppSecret。*/
@property (nonatomic, copy) NSString * client_secret;
/**  string 	请求的类型，填写authorization_code*/
@property (nonatomic, copy) NSString * grant_type;
/**  string 	调用authorize获得的code值。*/
@property (nonatomic, copy) NSString * code;
/**  string 	回调地址，需需与注册应用里的回调地址一致。*/
@property (nonatomic, copy) NSString * redirect_uri;

@end
