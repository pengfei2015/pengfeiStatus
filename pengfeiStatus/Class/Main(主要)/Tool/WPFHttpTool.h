//
//  WPFHttpTool.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPFHttpTool : NSObject

+ (void)get:(NSString *)url params:(id)model success:(void(^)(id responsObj))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(id)model success:(void(^)(id responsObj))success failure:(void(^)(NSError *error))failure;

@end
