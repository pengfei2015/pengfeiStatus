//
//  WPFUnreadRecieve.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFUnreadRecieve : NSObject

/**  int 	新微博未读数*/
@property (nonatomic, assign) int status;
/**  int 	新粉丝数*/
@property (nonatomic, assign) int follower;
/**  int 	新评论数*/
@property (nonatomic, assign) int cmt;
/**  int 	新私信数*/
@property (nonatomic, assign) int dm;
/**  int 	新提及我的微博数*/
@property (nonatomic, assign) int mention_status;
/**  int 	新提及我的评论数*/
@property (nonatomic, assign) int mention_cmt;

/**  int 	消息总数*/
@property (nonatomic, assign) int message;
/**  全部消息*/
@property (nonatomic, assign) int totalCount;
/*
group 	int 	微群消息未读数
private_group 	int 	私有微群消息未读数
notice 	int 	新通知未读数
invite 	int 	新邀请未读数
badge 	int 	新勋章数
photo 	int 	相册消息未读数
*/

@end
