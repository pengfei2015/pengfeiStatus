//
//  WPFRegexResult.h
//  鹏飞微博4
//
//  Created by 王家辉 on 15/11/26.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFRegexResult : NSObject

/**
 *  匹配到的字符串
 */
@property (nonatomic, copy) NSString * string;
/**
 *  匹配到的范围
 */
@property (nonatomic, assign) NSRange rang;
/**
 *  这个结果是否为表情
 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
