//
//  WPFStatusCell.h
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/11.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPFStatusFrame;
@interface WPFStatusCell : UITableViewCell

@property (nonatomic, strong) WPFStatusFrame *statusFrame;

+ (WPFStatusCell *)cellWithTableView:(UITableView *)tableView;
@end
