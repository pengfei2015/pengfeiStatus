//
//  WPFEmotion.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/20.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFEmotion.h"
#import "NSString+Emoji.h"

@implementation WPFEmotion

- (void)setCode:(NSString *)code
{
    _code = [code copy];
    if (_code == nil) return;
    self.emoji = [NSString emojiWithStringCode:_code];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.directory = [aDecoder decodeObjectForKey:@"directory"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.directory forKey:@"directory"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.chs forKey:@"chs"];
}
@end
