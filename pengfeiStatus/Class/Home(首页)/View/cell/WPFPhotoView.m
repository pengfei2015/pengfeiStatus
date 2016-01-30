//
//  WPFPhotoView.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/14.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFPhotoView.h"
#import "UIImageView+WebCache.h"
#import "WPFPhotoModel.h"

@interface WPFPhotoView ()
@property (nonatomic, weak) UIImageView *gifView;

@end
@implementation WPFPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    
    }
    return self;
}

- (void)setPhoto:(WPFPhotoModel *)photo
{
    _photo = photo;
    
    [self setImageWithURL:[NSURL URLWithString:_photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    NSString *extension = _photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"git"];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;

}
@end
