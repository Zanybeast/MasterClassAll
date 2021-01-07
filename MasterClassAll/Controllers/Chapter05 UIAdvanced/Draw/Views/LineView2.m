//
//  LineView2.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "LineView2.h"

@implementation LineView2

- (void)drawRect:(CGRect)rect {
    //第 1 根线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(200, 200)];
    
    [path setLineWidth:10];
    [[UIColor redColor] set];
    [path stroke];
    
    //第 2 根线
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, 0)];
    [path2 addLineToPoint:CGPointMake(30, 80)];
    
    [path2 setLineWidth:5];
    [[UIColor greenColor] set];
    [path2 stroke];
    
    //第三和第四根线
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, 40, 80);
    CGContextAddLineToPoint(ref, 250, 180);
    
    CGContextMoveToPoint(ref, 20, 130);
    CGContextAddLineToPoint(ref, 200, 130);
    
    [[UIColor blueColor] setStroke];
    
    CGContextSetLineWidth(ref, 8);
    
    CGContextSetLineJoin(ref, kCGLineJoinBevel);
    CGContextSetLineCap(ref, kCGLineCapRound);
    
    CGContextStrokePath(ref);
    
}

@end
