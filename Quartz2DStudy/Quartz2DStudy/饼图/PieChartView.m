//
//  PieChartView.m
//  Quartz2DStudy
//
//  Created by 陈舒澳 on 16/4/18.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "PieChartView.h"

@implementation PieChartView
- (void)drawRect:(CGRect)rect{
    [self drawPieChart:rect];
}
- (void)drawPieChart:(CGRect)rect{
    //提供的数据
    NSArray * dataArray = @[@30,@17,@5,@15,@3,@7,@23];
    //上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //中心点
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    //半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5;
    // 起始弧度
    CGFloat startAngle = 0;
    // 结束弧度
    CGFloat endAngle;
    for (int i = 0; i < dataArray.count; i ++) {
        //计算每个扇形的结束弧度
        endAngle = ([dataArray[i] intValue] / 100.0) * M_PI * 2 + startAngle;
        //创建路径对象（画弧的一个路径对象）
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        // 创建与中心点的连线
        [path addLineToPoint:center];
        CGContextSetLineWidth(context, 0);
        
        //添加到上下文
        CGContextAddPath(context, path.CGPath);
        [[UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0] set];
        //渲染
        CGContextDrawPath(context, kCGPathFill);
        //重新设置其实弧度
        startAngle = endAngle;
    }
    
}
@end
