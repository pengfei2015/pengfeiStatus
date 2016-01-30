//
//  WPFAccount.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFAccount.h"

#define ACCOUNT_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.data"]

@implementation WPFAccount

- (NSDate *)expires_time
{
    if (!_expires_time)
    {
        NSDate *now = [NSDate date];
        return [now dateByAddingTimeInterval:[self.expires_in doubleValue]];
    }
    return _expires_time;
}

+ (WPFAccount *)account
{
    WPFAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_PATH];
    NSDate *now = [NSDate date];
    if ([account.expires_time compare:now] != NSOrderedDescending) { // 小于就过期
        account = nil;
    }
    return account;
}

+ (void)save:(WPFAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_PATH];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.screen_name forKey:@"screen_name"];
}
@end
