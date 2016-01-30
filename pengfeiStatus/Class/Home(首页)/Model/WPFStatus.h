//
//  WPFStatus.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPFUserinfo;

@interface WPFStatus : NSObject

/**  string 	字符串型的微博ID*/
@property (nonatomic, copy) NSString * idstr;

/**  string 	微博创建时间*/
@property (nonatomic, copy) NSString * created_at;
/**  string 	微博信息内容*/
@property (nonatomic, copy) NSString * text;
/**  string 	微博来源*/
@property (nonatomic, copy) NSString * source;
/**  string 	缩略图片地址，没有时不返回此字段*/
@property (nonatomic, copy) NSString * thumbnail_pic;
/**  int 	转发数*/
@property (nonatomic, assign) long long reposts_count;

/**  int 	评论数*/
@property (nonatomic, assign) long long comments_count;
/**  int 	表态数*/
@property (nonatomic, assign) long long attitudes_count;

/**  object 	微博作者的用户信息字段*/
@property (nonatomic, strong) WPFUserinfo *user;
/**  object 	被转发的原微博信息字段，当该微博为转发微博时返回*/
@property (nonatomic, strong) WPFStatus *retweeted_status;

/**  object 	微博配图地址。多图时返回多图链接。无配图返回“[]”  数组里面都是HMPhoto模型。*/
@property (nonatomic, strong) NSArray *pic_urls;

/** 判断自身是不是转发微博 */
@property (nonatomic, assign, getter=isReweeted) BOOL reweeted;
@property (nonatomic, copy) NSMutableAttributedString *attributedString;


@end
