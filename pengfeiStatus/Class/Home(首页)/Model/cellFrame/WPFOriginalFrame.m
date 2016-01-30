//
//  WPFOriginalFrame.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFOriginalFrame.h"
#import "WPFStatus.h"
#import "WPFAccount.h"
#import "WPFUserinfo.h"
#import "WPFPhotosView.h"


@interface WPFOriginalFrame ()


@end
@implementation WPFOriginalFrame


- (void)setStatus:(WPFStatus *)status
{
    _status = status;
    
    CGFloat margin = 10;
    
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    CGFloat nameX = margin + CGRectGetMaxX(self.iconFrame);
    CGFloat nameY = iconY;
    
    NSString *name = _status.user.screen_name;
    CGSize nameSize = [name sizeWithFont:NAME_FONT];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    if (_status.user.isVip) {
        CGFloat vipX = margin + CGRectGetMaxX(self.nameFrame);
        CGFloat vipY = nameY;
        CGFloat vipW = nameSize.height;
        CGFloat vipH = vipW;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }else{
        self.vipFrame = CGRectMake(0, 0, 0, 0);
    }
    
    CGFloat h = 0;
    
    CGFloat textX = iconX;
    
    CGFloat textY = margin + (CGRectGetMaxY(self.iconFrame) >= CGRectGetMaxY(self.timeFrame) ? CGRectGetMaxY(self.iconFrame) : CGRectGetMaxY(self.timeFrame));
    CGFloat maxW = SCREEN_WIDTH - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    // 删掉最前面的昵称
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedString];
    if (status.reweeted) {
        int len = status.user.name.length + 4;
        [text deleteCharactersInRange:NSMakeRange(0, len)];
    }
    
    CGSize textSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    if (_status.pic_urls.count) {
        CGFloat photosX = iconX;
        CGFloat photosY = margin + CGRectGetMaxY(self.textFrame);
        CGSize photosSize = [WPFPhotosView sizeWithPhotosCount:_status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX,photosY},photosSize};
        h = CGRectGetMaxY(self.photosFrame);
    }else{
        self.photosFrame = CGRectMake(0, 0, 0, 0);
        h = CGRectGetMaxY(self.textFrame);
    }
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SCREEN_WIDTH;
    self.frame = CGRectMake(x, y, w, h);
}


@end
