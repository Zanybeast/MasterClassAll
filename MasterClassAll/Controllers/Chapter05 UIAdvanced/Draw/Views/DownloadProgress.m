//
//  DownloadProgress.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "DownloadProgress.h"

@implementation DownloadProgress

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat radius = rect.size.width * 0.5;
    CGPoint center = CGPointMake(radius, radius);
    
    CGFloat endAngle = - M_PI_2 + self.progress * M_PI * 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius - 5 startAngle:-M_PI_2 endAngle:endAngle clockwise:YES];
    
    [path setLineWidth:5];
    [[UIColor blueColor] set];
    
    [path stroke];
    
    
    CGFloat labelW = 100;
    CGFloat labelH = 30;
    
    NSString *text = [NSString stringWithFormat:@"%.2f%%", self.progress * 100];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    
    [text drawInRect:CGRectMake((rect.size.width - labelW) / 2, (rect.size.height - labelH) / 2, labelW, labelH)
      withAttributes:@{
          NSParagraphStyleAttributeName: style,
          NSForegroundColorAttributeName: [UIColor labelColor],
          NSFontAttributeName: [UIFont boldSystemFontOfSize:20]
      }];
    
    
}



@end
