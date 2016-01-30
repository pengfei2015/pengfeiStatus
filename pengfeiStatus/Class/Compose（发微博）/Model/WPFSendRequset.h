//
//  WPFSendRequset.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFSendRequset : NSObject
/**  string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString * access_token;
/**  string 	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property (nonatomic, copy) NSString * status;

@end
