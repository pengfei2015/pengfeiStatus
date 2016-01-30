//
//  WPFComposeTItle.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/8.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFComposeTItle.h"
#import "WPFAccount.h"

@interface WPFComposeTItle ()

@property (nonatomic, weak) UILabel *nameLab;
@property (nonatomic, weak) UILabel *titleLab;
@end
@implementation WPFComposeTItle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        UILabel *nameLab = [[UILabel alloc] init];
        [self addSubview:nameLab];
        nameLab.text = [WPFAccount account].screen_name;
        nameLab.font = [UIFont systemFontOfSize:14.0];
        nameLab.textColor = [UIColor lightGrayColor];
        nameLab.textAlignment = NSTextAlignmentCenter;
        self.nameLab = nameLab;
        
        UILabel *titleLab = [[UILabel alloc] init];
        [self addSubview:titleLab];
        titleLab.text = @"发微博";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont systemFontOfSize:18.0];
        self.titleLab = titleLab;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.size = CGSizeMake(200, 44);
    
    self.titleLab.frame = CGRectMake(0, 0, 200, 25);
    self.nameLab.frame = CGRectMake(0, 26, 200, 18);
}

@end
