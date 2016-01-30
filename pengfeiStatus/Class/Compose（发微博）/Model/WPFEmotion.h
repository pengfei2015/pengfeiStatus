//
//  WPFEmotion.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFEmotion : NSObject <NSCoding>

/**  表情描述*/
@property (nonatomic, copy) NSString * chs;
@property (nonatomic, copy) NSString * cht;
@property (nonatomic, copy) NSString * gif;
/**  图片名称*/
@property (nonatomic, copy) NSString * png;
@property (nonatomic, copy) NSString * type;
/**  emoji图片编码*/
@property (nonatomic, copy) NSString * code;

/** 表情的存放文件夹\目录 */
@property (nonatomic, copy) NSString *directory;
@property (nonatomic, copy) NSString * emoji;
@end
