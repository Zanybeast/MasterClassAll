//
//  PopupButton.m
//  MasterClassAll
//
//  Created by carl on 2020/11/28.
//

#import "PopupButton.h"

@implementation PopupButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint dialogueP = [self convertPoint:point toView:self.dialogueView];
    
    if ([self.dialogueView pointInside:dialogueP withEvent:event]) {
        return self.dialogueView;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

//拖动 View, 让其跟随手指移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint curp = [touch locationInView:self];
    CGPoint prevp = [touch previousLocationInView:self];
    
    CGFloat offsetX = curp.x - prevp.x;
    CGFloat offsetY = curp.y - prevp.y;
    
//    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    
    CGPoint center = self.center;
    center.x += offsetX;
    center.y += offsetY;
    
    self.center = center;
}

@end
