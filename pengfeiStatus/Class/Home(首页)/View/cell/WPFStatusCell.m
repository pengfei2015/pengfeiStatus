//
//  WPFStatusCell.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFStatusCell.h"
#import "WPFDetailView.h"
#import "WPFCellToolBar.h"
#import "WPFStatusFrame.h"

@interface WPFStatusCell ()

@property (nonatomic, weak) WPFDetailView *detailView;
@property (nonatomic, weak) WPFCellToolBar * toolBar;

@end
@implementation WPFStatusCell

+ (WPFStatusCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"status";
    WPFStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WPFStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    
        WPFDetailView *detailView = [[WPFDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        WPFCellToolBar *toolBar = [[WPFCellToolBar alloc] init];
        [self.contentView addSubview:toolBar];
        self.toolBar = toolBar;
        
    }
    return self;
}

- (void)setStatusFrame:(WPFStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.detailView.detailFrame = _statusFrame.detailFrame;
    
    
    self.toolBar.frame = _statusFrame.toolBarFrame;
    self.toolBar.status = _statusFrame.status;
}

@end
