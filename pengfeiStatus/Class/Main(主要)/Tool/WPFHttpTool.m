//
//  WPFHttpTool.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFHttpTool.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@implementation WPFHttpTool

+ (void)get:(NSString *)url params:(id)model success:(void(^)(id responsObj))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *dict = [model keyValues];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)post:(NSString *)url params:(id)model success:(void(^)(id responsObj))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *dict = [model keyValues];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}



@end
