//
//  WPFStatus.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/10.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFStatus.h"
#import "NSDate+MJ.h"
#import "MJExtension.h"
#import "WPFPhotoModel.h"
#import "WPFUserinfo.h"
#import "RegexKitLite.h"
#import "WPFRegexResult.h"
#import "WPFEmotion.h"
#import "WPFEmotionTool.h"
#import "WPFEmotionAttachment.h"

@implementation WPFStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[WPFPhotoModel class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
#warning 真机必须加上这句话，否则转换不成功，必须告诉日期格式的区域，才知道怎么解析
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    // 获取微博创建时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%d小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%d分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}


- (void)setUser:(WPFUserinfo *)user
{
    _user = user;
    
    [self createAttributedText];
}
- (void)setSource:(NSString *)source
{
    // <a href="http://app.weibo.com/t/feed/5yiHuw" rel="nofollow">iPhone 6 Plus</a>
    // <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    
    if ([source isEqualToString:@""]) return;
    
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + 1];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];

    _source = [NSString stringWithFormat:@"来自%@",source];
}

- (void)setRetweeted_status:(WPFStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    self.reweeted = NO;// 默认不是，如何有转发微博，那自身就不是转发微博
    self.retweeted_status.reweeted = YES;// 确定转发微博
}
- (void)setReweeted:(BOOL)reweeted
{
    _reweeted = reweeted;
    [self createAttributedText];
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    [self createAttributedText];
}

// 建立富文本
- (void)createAttributedText{
    if (nil == self.text || nil == self.user) return;
    
    if (self.isReweeted) {
        NSString *totalText = [NSString stringWithFormat:@"@%@ : %@",self.user.name,self.retweeted_status.text];
        self.attributedString = [self attributedStringWithString:totalText];
    }else{
        self.attributedString = [self attributedStringWithString:self.text];
    }
    
}

// 生成富文本
- (NSMutableAttributedString *)attributedStringWithString:(NSString *)text
{
    // 1 匹配字符串
    NSArray *regexResults = [self regexResultsWithText:text];
    
    // 2 根据匹配结果进行拼接
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(WPFRegexResult *obj, NSUInteger idx, BOOL *stop) {
        WPFEmotion *emotion = nil;
        if (obj.isEmotion) { // 如果是表情符号
            emotion = [WPFEmotionTool emotionWithDesc:obj.string];
        }
        
        //
        if (emotion) {// 如果有表情
            // 创建附件对象
            WPFEmotionAttachment *attach = [[WPFEmotionAttachment alloc] init];
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, NAME_FONT.lineHeight, NAME_FONT.lineHeight);
            
            // 讲附件包装成富文本
            NSAttributedString *attactString = [NSAttributedString attributedStringWithAttachment:attach];
            [string appendAttributedString:attactString];
        }else{
            // 非表情
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc]initWithString:obj.string];
            // 匹配看看是不是话题
            
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [obj.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:*capturedRanges];
                
                [substr addAttribute:@"linkText" value:*capturedStrings range:*capturedRanges];
            }];
            
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+";
            [obj.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:*capturedRanges];
                [substr addAttribute:WPFLinkText value:*capturedStrings range:*capturedRanges];
            }];

            
            // 匹配超链接
            
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [obj.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:*capturedRanges];
                
                [substr addAttribute:@"linkText" value:*capturedStrings range:*capturedRanges];
            }];
            [string appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [string addAttribute:NSFontAttributeName value:NAME_FONT range:NSMakeRange(0, string.length)];
    return string;
}

// 匹配
- (NSArray *)regexResultsWithText:(NSString *)text
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        WPFRegexResult *rr = [[WPFRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.rang = *capturedRanges;
        rr.emotion = YES;
        [regexResults addObject:rr];
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        WPFRegexResult *rr = [[WPFRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.rang = *capturedRanges;
        rr.emotion = NO;
        [regexResults addObject:rr];
    }];
    
    // 排序
    
    [regexResults sortUsingComparator:^NSComparisonResult(WPFRegexResult *obj1, WPFRegexResult *obj2) {
        int loc1 = obj1.rang.location;
        int loc2 = obj2.rang.location;
        return [@(loc1)compare:@(loc2)];
    }];
    
    return regexResults;
}

@end
