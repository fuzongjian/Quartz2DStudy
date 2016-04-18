//
//  DrawBoardView.m
//  Quartz2DStudy
//
//  Created by 陈舒澳 on 16/4/18.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "DrawBoardView.h"
@interface DrawBoardView ()
@property (nonatomic,strong) UIBezierPath * path;
@property (nonatomic,strong) NSMutableArray * paths;
@end
@implementation DrawBoardView
- (NSMutableArray *)paths{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}
- (void)drawRect:(CGRect)rect{
    for (UIBezierPath * path in self.paths) {
        [path stroke];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [_path addLineToPoint:point];
    [self setNeedsDisplay];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIBezierPath * path = [UIBezierPath bezierPath];
    _path = path;
    [self.paths addObject:path];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    [path moveToPoint:point];
    
}
@end
