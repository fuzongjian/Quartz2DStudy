//
//  Quartz2DView.m
//  Quartz2DStudy
//
//  Created by 陈舒澳 on 16/4/18.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "Quartz2DView.h"

@implementation Quartz2DView
/**  一般步骤如下
 *  1、获取图形的上下文
 *  2、创建并设置路径
 *  3、将路径添加到上下文
 *  4、设置上下文相关状态
 *  5、绘制路径
 *  6、释放路径
 */


/**  一般方法如下
 *  1、获得上下文  CGContextRef context = UIGraphicsGetCurrentContext();
 *  2、拼接路径  
 *  2.1 CGContextMoveToPoint(context, 200, 50);  
 *  2.2 CGContextAddLineToPoint(context, 200, 200);
 *  2.3 CGContextAddRect(CGContextRefc, CGRectrect) 矩形
 *  2.4 voidCGContextAddEllipseInRect(CGContextRefcontext, CGRectrect) 椭圆
 *  2.5 CGContextAddArc(CGContextRefc, CGFloatx, CGFloaty,CGFloatradius, CGFloatstartAngle, CGFloatendAngle, int  clockwise)  圆弧
 *  2.6
 *  3、绘制路径
 *  3.1  CGContextStrokePath(context);（空心）   CGContextFillPath(context);（实心）
 *  3.2  CGContextDrawPath(context, kCGPathStroke);
 *
 */
//CGContextRef context = UIGraphicsGetCurrentContext(); 设置上下文
//CGContextMoveToPoint 开始画线
//CGContextAddLineToPoint 画直线
//
//CGContextAddEllipseInRect 画一椭圆
//CGContextSetLineCap 设置线条终点形状
//CGContextSetLineDash 画虚线
//CGContextAddRect 画一方框
//CGContextStrokeRect 指定矩形
//CGContextStrokeRectWithWidth 指定矩形线宽度
//CGContextStrokeLineSegments 一些直线
//
//CGContextAddArc 画已曲线 前俩店为中心 中间俩店为起始弧度 最后一数据为0则顺时针画 1则逆时针
//CGContextAddArcToPoint(context,0,0, 2, 9, 40);//先画俩条线从point 到 弟1点 ， 从弟1点到弟2点的线  切割里面的圆
//CGContextSetShadowWithColor 设置阴影
//CGContextSetRGBFillColor 这只填充颜色
//CGContextSetRGBStrokeColor 画笔颜色设置
//CGContextSetFillColorSpace 颜色空间填充
//CGConextSetStrokeColorSpace 颜色空间画笔设置
//CGContextFillRect 补充当前填充颜色的rect
//CGContextSetAlaha 透明度
//
//CGContextTranslateCTM 改变画布位置
//CGContextSetLineWidth 设置线的宽度
//CGContextAddRects 画多个线
//CGContextAddQuadCurveToPoint 画曲线
//CGContextStrokePath 开始绘制图片
//CGContextDrawPath 设置绘制模式
//CGContextClosePath 封闭当前线路
//CGContextTranslateCTM(context, 0, rect.size.height);    CGContextScaleCTM(context, 1.0, -1.0);反转画布
//CGContextSetInterpolationQuality 背景内置颜色质量等级
//CGImageCreateWithImageInRect 从原图片中取小图

/**  为什么一定要在调用  - (void)drawRect:(CGRect)rect
 * 1、View之多可以显示东西，完全因为内部的layer
 * 2、而在drawRect:方法中取得上下文后，就可以绘制东西到view上
 * 3、View内部有个layer（图层）属性，drawRect:方法中取得的是一个Layer Graphics Context
 */


- (void)drawRect:(CGRect)rect{
    [self drawProgressSecond:rect];
}
#pragma mark --- 进度条
- (void)drawProgressSecond:(CGRect)rect{
    // 1. 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 创建路径对象
    CGPoint centerP = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - 15;
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:-M_PI_2 endAngle:M_PI * 2 * 0.3 - M_PI_2 clockwise:YES];
    
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
/**
 *  360° ==> 2π  =>  M_PI * 2
 *  180° ==> π  => M_PI
 *  90° ==> π * 0.5  => M_PI_2
 */
- (void)drawProgress:(CGRect)rect{
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
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius-10 startAngle:-M_PI_2 endAngle:M_PI * 2 * 0.5 - M_PI_2 clockwise:YES];
    CGContextSetLineWidth(ctx, 20);
    [[UIColor blueColor] set];
    //线条终点形状
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathStroke);
}
#pragma mark --- 图片剪切
- (void)drawImageSecond{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(20, 100, 280, 300));
    CGContextClip(context);
    UIImage * image = [UIImage imageNamed:@"键盘符号"];
    [image drawAtPoint:CGPointMake(50, 50)];
}
#pragma mark --- 绘制图像
- (void)drawImage{
    UIImage * image = [UIImage imageNamed:@"键盘符号"];
    //拉伸
    [image drawInRect:CGRectMake(20, 100, 280, 200)];
    //平铺
//    [image drawAsPatternInRect:CGRectMake(20, 50, image.size.width * 0.3, image.size.height * 0.5)];
}
#pragma mark --- 文本
- (void)drawText{
    NSString * str = @"好好学习，天天向上";
    
    //指定区域
    CGRect  rect = CGRectMake(20, 100, 200, 200);
    
    UIFont * font = [UIFont systemFontOfSize:20];
    UIColor * color = [UIColor blueColor];
    NSTextAlignment textAlignment = NSTextAlignmentCenter;
    //初始化段落样式
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    //段落样式
    style.alignment = textAlignment;
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
}
#pragma mark --- 圆形
/**
 *
 *CGContextAddArc(CGContextRef __nullable c, CGFloat x, CGFloat y,
 CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
 *
 */
- (void)drawCircle{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, 100, 100, 40, 0, 2 * M_PI, 1);
    CGContextSetLineWidth(context, 3);
    [[UIColor redColor] setFill];
    [[UIColor blueColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    
   // CGContextStrokePath(context);
   // CGContextFillPath(context);
}
#pragma mark --- 矩形
- (void)drawRectangle{
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(125, 100, 100, 100));
    CGContextSetLineWidth(context, 3);
    [[UIColor redColor] setStroke];
    [[UIColor blueColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}
#pragma mark --- 三角形(通过创建路径)
- (void)drawTriangle_path{
    //获取图形上下文对象
    CGContextRef  context = UIGraphicsGetCurrentContext();
    //创建路径对象
    CGMutablePathRef  path = CGPathCreateMutable();
    //设置路径起点
    CGPathMoveToPoint(path, nil, 200, 50);
    //接着画到200 200
    CGPathAddLineToPoint(path, nil, 200, 200);
    //设置路径终点
    CGPathAddLineToPoint(path, nil, 50, 200);
    //最后一点 200  50
    CGPathAddLineToPoint(path, nil, 200, 50);
    //将路径添加到图形上下文
    CGContextAddPath(context, path);
    
    //设置线条宽度
    CGContextSetLineWidth(context, 5);
    //边框颜色  默认黑色
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    //填充颜色  默认黑色
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    
    /**  绘制图形到指定图形上下文,切设置既有边框,又有填充型
    *   1、kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
    *   2、kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
    *   3、kCGPathStroke:只有边框
    *   4、kCGPathFillStroke：既有边框又有填充
    *   5、kCGPathEOFillStroke：奇偶填充并绘制边框
    */
    CGContextDrawPath(context, kCGPathStroke);
    
    //路径释放
    CGPathRelease(path);
}
#pragma mark --- 三角形(通过颜色路径)
- (void)drawTriangle_color{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 200, 50);
    CGContextAddLineToPoint(context, 200, 200);
    CGContextAddLineToPoint(context, 50, 200);
    CGContextAddLineToPoint(context, 200, 50);
    
    //设置线条宽度
    CGContextSetLineWidth(context, 3);
    //边框颜色
    [[UIColor blueColor] setStroke];
    //填充颜色
    [[UIColor redColor] setFill];
    
    //绘制图形到指定图形上下文，
    CGContextDrawPath(context, kCGPathStroke);
}
@end
