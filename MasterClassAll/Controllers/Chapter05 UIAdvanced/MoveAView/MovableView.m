//
//  MovableView.m
//  MasterClassAll
//
//  Created by carl on 2020/11/28.
//

#import "MovableView.h"

@implementation MovableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZLog(@"%s", __func__);
    ZLog(@"touches count: %lu", touches.count);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZLog(@"%s", __func__);
    
    UITouch *touch = [touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    
    CGPoint preP = [touch previousLocationInView:self];
    
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZLog(@"%s", __func__);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZLog(@"%s", __func__);
}

@end
