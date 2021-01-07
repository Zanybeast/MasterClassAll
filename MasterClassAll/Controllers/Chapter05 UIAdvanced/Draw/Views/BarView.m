//
//  BarView.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "BarView.h"

#define VIEW_HEIGHT rect.size.height
#define VIEW_WIDTH rect.size.width

#define kToLeftSpace 15
#define kToBottomSpace 15
#define kToRightSpace 10
#define kToTopSpace 10
#define kArrowWidth 5

@implementation BarView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSArray *data = [NSArray randomIntegerArrayWithRandomCapacity:15];
    int sum = 0;
    int maxValue = 0;
    for (int i = 0; i < data.count; i++) {
        int value = (int)[data[i] integerValue];
        if (value > maxValue) {
            maxValue = value;
        }
        sum += value;
    }
    #pragma mark - 画 x 轴
    UIBezierPath *pathX = [UIBezierPath bezierPath];
    [pathX moveToPoint:CGPointMake(kToLeftSpace, VIEW_HEIGHT - kToBottomSpace)];
    [pathX addLineToPoint:CGPointMake(VIEW_WIDTH - kToRightSpace, VIEW_HEIGHT - kToBottomSpace)];
    [pathX addLineToPoint:CGPointMake(VIEW_WIDTH - kToRightSpace - kArrowWidth, VIEW_HEIGHT - kToBottomSpace - kArrowWidth)];
    [pathX moveToPoint:CGPointMake(VIEW_WIDTH - kToRightSpace, VIEW_HEIGHT - kToBottomSpace)];
    [pathX addLineToPoint:CGPointMake(VIEW_WIDTH - kToRightSpace - kArrowWidth, VIEW_HEIGHT - kToBottomSpace + kArrowWidth)];
    
    [pathX setLineWidth:1];
    
    [pathX stroke];
    NSString *axisX = @"x";
    [axisX drawAtPoint:CGPointMake(VIEW_WIDTH - kToRightSpace - kArrowWidth, VIEW_HEIGHT - kToBottomSpace - 25) withAttributes:@{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16]
    }];
    #pragma mark - 画 y 轴
    UIBezierPath *pathY = [UIBezierPath bezierPath];
    [pathY moveToPoint:CGPointMake(kToLeftSpace, VIEW_HEIGHT - kToBottomSpace)];
    [pathY addLineToPoint:CGPointMake(kToLeftSpace, kToTopSpace)];
    [pathY addLineToPoint:CGPointMake(kToLeftSpace - kArrowWidth, kToTopSpace + kArrowWidth)];
    [pathY moveToPoint:CGPointMake(kToLeftSpace, kToTopSpace)];
    [pathY addLineToPoint:CGPointMake(kToLeftSpace + kArrowWidth, kToTopSpace + kArrowWidth)];
    
    [pathY setLineWidth:1];
    
    [pathY stroke];
    NSString *axisY = @"y";
    [axisY drawAtPoint:CGPointMake(kToLeftSpace + kArrowWidth + 10, kToTopSpace) withAttributes:@{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16]
    }];
    
    #pragma mark - 画条状图
    CGFloat standardHeight = (VIEW_HEIGHT - kToTopSpace - kToBottomSpace) * 0.8;
    CGFloat standardWidth = (VIEW_WIDTH - kToLeftSpace - kToRightSpace) * 0.9;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = standardWidth / data.count;
    CGFloat h = 0;
    
    
    for (int i = 0; i < data.count; i++) {
        x = w * i + kToLeftSpace;
        h = [data[i] floatValue] / maxValue * standardHeight;
        y = VIEW_HEIGHT - kToBottomSpace - h;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        [[UIColor randomColor] set];
        
        [path fill];
    }
}


@end
