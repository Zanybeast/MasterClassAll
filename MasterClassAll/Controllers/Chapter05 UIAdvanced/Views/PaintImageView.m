//
//  PaintImageView.m
//  MasterClassAll
//
//  Created by carl on 2020/12/8.
//

#import "PaintImageView.h"

@interface PaintImageView () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation PaintImageView

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        imageView.userInteractionEnabled = YES;
        
        _imageView = imageView;
        
        [self addGestures];
        
        [self addSubview:imageView];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

#pragma mark - 添加手势
- (void)addGestures {
    // 添加拖动手势给ImageHandleView
    UIPanGestureRecognizer *panHandle = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle)];
    [self addGestureRecognizer:panHandle];
    
    // 平移
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
    
    // 旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:rotation];
    
    // 缩放
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self.imageView addGestureRecognizer:pinch];
    
    // 长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.imageView addGestureRecognizer:longPress];
}

#pragma mark - 手势处理
- (void)panHandle {
    PRINT_FUNCTION;
}

- (void)pan: (UIPanGestureRecognizer *)pan {
    CGPoint translationPoint = [pan translationInView:self.imageView];
    
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, translationPoint.x, translationPoint.y);
    
    [pan setTranslation:CGPointZero inView:self.imageView];
}

- (void)rotation: (UIRotationGestureRecognizer *)rotation {
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    
    rotation.rotation = 0;
}

- (void)pinch: (UIPinchGestureRecognizer *)pinch {
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    
    pinch.scale = 1;
}

- (void)longPress: (UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.imageView.alpha = 1;
            } completion:^(BOOL finished) {
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                
                CGContextRef ref = UIGraphicsGetCurrentContext();
                
                [self.layer renderInContext:ref];
                
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                
                UIGraphicsEndImageContext();
                
                if (self.ImageFinishedDrawToPaintBoard) {
                    self.ImageFinishedDrawToPaintBoard(image);
                }
                
                [self removeFromSuperview];
            }];
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}


@end
