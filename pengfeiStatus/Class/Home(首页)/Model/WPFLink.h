//
//  WPFLink.h
//  pengfeiStatus
//
//  Created by 温鹏飞 on 16/1/30.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFLink : NSObject

/** 链接文字 */
@property (nonatomic, copy) NSString *text;
/** 链接的范围 */
@property (nonatomic, assign) NSRange range;
/** 链接的边框 */
@property (nonatomic, strong) NSArray *rects;

@end
