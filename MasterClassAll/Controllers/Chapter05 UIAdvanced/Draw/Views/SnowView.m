//
//  SnowView.m
//  MasterClassAll
//
//  Created by carl on 2020/12/7.
//

#import "SnowView.h"

@interface SnowView ()

@property (assign, nonatomic) BOOL isAddedToRunLoop;

@property (assign, nonatomic) CGFloat forwardX;
@property (assign, nonatomic) CGFloat downY;
@property (assign, nonatomic) CGFloat backX;
@property (assign, nonatomic) CGFloat upY;

@property (assign, nonatomic) CGFloat corX;
@property (assign, nonatomic) CGFloat corY;

@property (assign, nonatomic) CGFloat imageW;
@property (assign, nonatomic) CGFloat imageH;


@end

@implementation SnowView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self setNeedsDisplayInRect:rect];
    
    UIImage *image = [UIImage imageNamed:@"snow"];
    _imageW = image.size.width;
    _imageH = image.size.height;
    
    CGFloat wayH = rect.size.height - _imageH;
    CGFloat wayW = rect.size.width - _imageW;
    
    if (_downY < wayH) {
        _downY += 10;
        _corY = _downY + _upY;
    } else {
        _downY = wayH;
        _corY = _downY + _upY;
        if (_forwardX < wayW) {
            _forwardX += 10;
            _corX = _forwardX + _backX;
        } else {
            _forwardX = wayW;
            if (_upY > -wayH) {
                _upY -= 10;
                _corY = _downY + _upY;
            } else {
                _upY = -wayH;
                if (_backX > -wayW) {
                    _backX -= 10;
                    _corX = _backX + _forwardX;
                } else {
                    _backX = -wayW;
                    _downY = 0;
                    _forwardX = 0;
                    _backX = 0;
                    _upY = 0;
                }
            }
        }
    }
    
    [image drawAtPoint:CGPointMake(_corX, _corY)];
    
    if (!self.isAddedToRunLoop) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        self.isAddedToRunLoop = YES;
    }
    
}



@end
