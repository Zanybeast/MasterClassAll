//
//  PieView.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "PieView.h"

@implementation PieView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSArray *data = [NSArray randomIntegerArrayWithRandomCapacity:15];
    
    int sum = 0;
    for (int i = 0; i < data.count; i++) {
        sum += [data[i] integerValue];
    }
    CGFloat radius = rect.size.width * 0.45;
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    
    CGFloat startAngle = 0;
    CGFloat drawAngle = 0;
    CGFloat endAngle = 0;
    
    for (int i = 0; i < data.count; i++) {
        startAngle = endAngle;
        drawAngle = [data[i] doubleValue] / sum * M_PI * 2;
        endAngle = startAngle + drawAngle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        [path addLineToPoint:center];
        
        [[UIColor randomColor] set];
        
        [path fill];
    }
}


@end
