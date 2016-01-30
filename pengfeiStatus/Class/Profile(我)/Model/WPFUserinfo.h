//
//  WPFUserinfo.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFUserinfo : NSObject

/** int64 	用户UID */
@property (nonatomic, strong) NSNumber * ID;
/**  string 	字符串型的用户UID */
@property (nonatomic, copy) NSString * idstr;

/**  	string 	用户昵称 */
@property (nonatomic, copy) NSString * screen_name;
/**  string 	友好显示名称 */
@property (nonatomic, copy) NSString * name;
/**  int 	用户所在省级ID */
@property (nonatomic, copy) NSString * province;
/**  int 	用户所在城市ID */
@property (nonatomic, copy) NSString * city;
/**  string 	用户所在地 */
@property (nonatomic, copy) NSString * location;

/**  string 	用户个人描述 */
@property (nonatomic, copy) NSString * Description;
/**  string 	用户博客地址 */
@property (nonatomic, copy) NSString * url;
/**  string 	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString * profile_image_url;
/**  string 	用户的微博统一URL地址 */
@property (nonatomic, copy) NSString * profile_url;
/**  string 	用户的个性化域名 */
@property (nonatomic, copy) NSString * domain;
/**  string 	用户的微号 */
@property (nonatomic, copy) NSString * weihao;
/**  string 	性别，m：男、f：女、n：未知 */
@property (nonatomic, copy) NSString * gender;
/**  int 	粉丝数 */
@property (nonatomic, copy) NSString * followers_count;
/**  int 	关注数 */
@property (nonatomic, copy) NSString * friends_count;
/**   	int  微博数 */
@property (nonatomic, copy) NSString * statuses_count;
/**  	int 	收藏数 */
@property (nonatomic, copy) NSString * favourites_count;
/**  string 	用户创建（注册）时间 */
@property (nonatomic, copy) NSString * created_at;

/**  boolean 	是否允许所有人给我发私信，true：是，false：否 */
@property (nonatomic, copy) NSString * allow_all_act_msg;
/**  boolean 	是否允许标识用户的地理位置，true：是，false：否 */
@property (nonatomic, copy) NSString * geo_enabled;
/**  boolean 	是否是微博认证用户，即加V用户，true：是，false：否 */
@property (nonatomic, copy) NSString * verified;
/**  string 	用户备注信息，只有在查询用户关系时才返回此字段
 */
@property (nonatomic, copy) NSString * remark;
/** object 	用户的最近一条微博信息字段 详细 */
@property (nonatomic, copy) NSString * status;
/** boolean 	是否允许所有人对我的微博进行评论，true：是，false：否*/
@property (nonatomic, copy) NSString * allow_all_comment;
/** string 	用户头像地址（大图），180×180像素 */
@property (nonatomic, copy) NSString * avatar_large;
/** string 	用户头像地址（高清），高清头像原图 */
@property (nonatomic, copy) NSString * avatar_hd;
/** string 	认证原因 */
@property (nonatomic, copy) NSString * verified_reason;
/** boolean 	该用户是否关注当前登录用户，true：是，false：否 */
@property (nonatomic, copy) NSString * follow_me;
/** int 	用户的在线状态，0：不在线、1：在线 */
@property (nonatomic, copy) NSString * online_status;

/** 用户的互粉数 */
@property (nonatomic, copy) NSString * bi_followers_count;
/** string 	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语 */
@property (nonatomic, copy) NSString * lang;

/** 会员类型 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter=isVip) BOOL vip;

@end
