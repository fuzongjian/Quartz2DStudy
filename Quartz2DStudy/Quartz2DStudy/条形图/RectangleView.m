//
//  RectangleView.m
//  Quartz2DStudy
//
//  Created by 陈舒澳 on 16/4/18.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "RectangleView.h"

@implementation RectangleView
- (void)drawRect:(CGRect)rect{
    [self drawRectangle:rect];
}
- (void)drawRectangle:(CGRect)rect{
    //数据源
    NSArray * dataArray = @[ @300, @150.65, @55.3, @507.7, @95.8, @700, @650.65 ];
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 循环绘制每一个柱子
    for (int i = 0; i < dataArray.count; i ++) {
        CGFloat W = rect.size.width / (dataArray.count * 2 -1);
        CGFloat H = ([dataArray[i] intValue] / 1000.0) * rect.size.height;
        CGFloat Y = rect.size.height - H;
        CGFloat X = i * (2 * W);
        //创建绘制矩形路径对象
        UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(X, Y, W, H)];
        // 设置颜色
        [[UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0] set];
        // 把路径对象添加到图形上下文中
        CGContextAddPath(context, path.CGPath);
        CGContextDrawPath(context, kCGPathFill);
    }
}
@end
