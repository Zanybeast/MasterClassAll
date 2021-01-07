//
//  GesturesVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/28.
//

#import "GesturesVC.h"
#import "HintView.h"

@interface GesturesVC () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tappedLabel;

@end

@implementation GesturesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.clipsToBounds = YES;
    //点击
    [self addTap];
    //平移
    [self addPan];
    //捏合(缩放)
    [self addPinch];
    //旋转
    [self addRotate];
    //长按
    [self addLongPress];
}

#pragma mark - 允许多手势同时进行
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - TAP
- (void)addTap {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    gesture.delegate = self;
    
    [self.imageView addGestureRecognizer:gesture];
}

- (void)tapAction: (UITapGestureRecognizer *)tap {
    self.imageView.hidden = YES;
    self.tappedLabel.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.imageView.hidden = NO;
        self.tappedLabel.hidden = YES;
    });
    
    PRINT_FUNCTION;
}

#pragma mark - PAN
- (void)addPan {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];

    [self.imageView addGestureRecognizer:gesture];
}

- (void)panAction: (UIPanGestureRecognizer *)pan {
    CGPoint transP = [pan translationInView:self.imageView];
    
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, transP.x, transP.y);
    
    [pan setTranslation:CGPointZero inView:self.imageView];
}

#pragma mark - Pinch
- (void)addPinch {
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    gesture.delegate = self;
    [self.imageView addGestureRecognizer:gesture];
}

- (void)pinchAction: (UIPinchGestureRecognizer *)pinch {
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    
    pinch.scale = 1;
}

#pragma mark - Rotate
- (void)addRotate {
    UIRotationGestureRecognizer *gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateAction:)];
    gesture.delegate = self;
    [self.imageView addGestureRecognizer:gesture];
}

- (void)rotateAction: (UIRotationGestureRecognizer *)gesture {
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, gesture.rotation);
    
    gesture.rotation = 0;
}

#pragma mark - 长按
- (void)addLongPress {
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    gesture.delegate = self;
    gesture.minimumPressDuration = 1.0;
    [self.imageView addGestureRecognizer:gesture];
}

- (void)longPressAction: (UILongPressGestureRecognizer *)gesture {
    PRINT_FUNCTION;
    HintView *hintView = [HintView hintViewWithText:@"hello"];
    hintView.frame = CGRectMake(0, 0, 120, 120);
    hintView.center = CGPointMake(50, -20);
    
    [self.imageView addSubview:hintView];
    
}

#pragma mark - 复原
- (IBAction)setToDefault:(UIButton *)sender {
    self.imageView.transform = CGAffineTransformIdentity;
}


@end
