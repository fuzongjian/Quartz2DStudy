//
//  ProgressViewSecond.m
//  Quartz2DStudy
//
//  Created by 陈舒澳 on 16/4/18.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "ProgressViewSecond.h"

@implementation ProgressViewSecond
- (void)drawRect:(CGRect)rect{
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 屏幕中心点
    CGPoint centerP = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    // 半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - 15;
    
    // 外
    UIBezierPath* path2 = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:- M_PI_2 endAngle: M_PI_2 + M_PI *2 clockwise:YES];
    [[UIColor greenColor] set];
    CGContextAddPath(ctx, path2.CGPath);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // 内
    UIBezierPath* path3 = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius-20 startAngle:- M_PI_2 endAngle: M_PI_2 + M_PI * 2 clockwise:YES];
    [[UIColor redColor] set];
    CGContextAddPath(ctx, path3.CGPath);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // 不断不变化的进度条
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius-10 startAngle:-M_PI_2 endAngle:M_PI * 2 * self.progress - M_PI_2 clockwise:YES];
    CGContextSetLineWidth(ctx, 20);
    [[UIColor blueColor] set];
    //线条终点形状
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathStroke);

}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    // 重绘（必须）
    [self setNeedsDisplay];
}
@end
