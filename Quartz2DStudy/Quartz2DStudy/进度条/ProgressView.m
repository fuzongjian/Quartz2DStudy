//
//  ProgressView.m
//  Quartz2DStudy
//
//  Created by 陈舒澳 on 16/4/18.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView
- (void)drawRect:(CGRect)rect{
    // 1. 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 创建路径对象
    CGPoint centerP = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - 15;
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:-M_PI_2 endAngle:M_PI * 2 * self.progress - M_PI_2 clockwise:YES];
    
    // 添加一根到中心点的线段
    [path addLineToPoint:centerP];
    
    // 设置线宽
    CGContextSetLineWidth(ctx, 30);
    // 设置显色
    [[UIColor blueColor] set];
    
    // 设置线头样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 3. 把路径添加到上下文中
    CGContextAddPath(ctx, path.CGPath);
    
    // 4. 渲染
    //CGContextDrawPath(ctx, kCGPathStroke);
    CGContextDrawPath(ctx, kCGPathFill);

}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    // 重绘View （必须）
    [self setNeedsDisplay];
}
@end
