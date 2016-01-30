//
//  UIView+Extension.h
//  鹏飞微博3
//
//  Created by 王家辉 on 15/11/1.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/** View的x坐标 */
@property (nonatomic, assign) CGFloat x;
/** View的y坐标 */
@property (nonatomic, assign) CGFloat y;
/** View的宽度 */
@property (nonatomic, assign) CGFloat width;
/** View的高度 */
@property (nonatomic, assign) CGFloat height;
/** View的中心点x坐标 */
@property (nonatomic, assign) CGFloat centerX;
/** View的中心点y坐标 */
@property (nonatomic, assign) CGFloat centerY;
/** View的宽和高 */
@property (nonatomic, assign) CGSize size;
@end
