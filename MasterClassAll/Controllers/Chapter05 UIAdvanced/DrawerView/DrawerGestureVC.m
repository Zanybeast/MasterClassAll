//
//  DrawerGestureVC.m
//  MasterClassAll
//
//  Created by carl on 2020/12/4.
//

#import "DrawerGestureVC.h"

@interface DrawerGestureVC ()

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;

@end

@implementation DrawerGestureVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChildrenView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self.view addGestureRecognizer:pan];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)pan: (UIPanGestureRecognizer *)pan {
    CGPoint transPoint = [pan translationInView:self.view];
    
    CGFloat offsetX = transPoint.x;
    
    self.mainView.frame = [self frameWithOffSetX: offsetX];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    [pan setTranslation:CGPointZero inView:self.view];
    
    //手势结束,定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat target = 0;
        
        //如果偏移超过了屏幕的一半
        if (self.mainView.frame.origin.x > (SCREEN_WIDTH * 0.5)) {
            target = 275;
        } else if (CGRectGetMaxX(self.mainView.frame) < (SCREEN_WIDTH * 0.5)) {
            target = -250;
        }
        
        CGFloat offSetx = target - self.mainView.frame.origin.x;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.mainView.frame = target == 0 ? self.view.bounds
            : [self frameWithOffSetX:offSetx];
        }];
    }
}

- (CGRect)frameWithOffSetX: (CGFloat)offSetX {
    //获取未平移前的 frame
    CGRect frame = self.mainView.frame;
    
    //获取屏幕宽高
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //根据平移偏移量计算 y 轴偏移量
    CGFloat offsetY = offSetX * 80 / screenW;
    
    //获取未平移前的宽和高
    CGFloat lastH = frame.size.height;
    CGFloat lastW = frame.size.width;
    
    //计算当前高度
    CGFloat curH = lastH - offsetY * 2; //此为往右移动, 高度为屏幕宽度减去 2 倍的偏移量, 上下对称
    if (frame.origin.x < 0) {
        curH = lastH + offsetY * 2; //往左平移时, 偏移量为负, 所以要加上偏移量
    }
    
    //计算尺寸缩放比例
    CGFloat scale = curH / lastH;
    //计算所需宽度
    CGFloat curW = lastW * scale;
    
    //计算 x 值
    frame.origin.x += offSetX;
    //计算 y 值
    CGFloat originY = (screenH - curH) / 2;
    
    //赋值到 frame
    frame.origin.y = originY;
    frame.size.width = curW;
    frame.size.height = curH;
    
    return frame;
}

#pragma mark - 观察属性变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    ZLog(@"%@", NSStringFromCGRect(self.mainView.frame));
    
    if (self.mainView.frame.origin.x > 0) {
        self.rightView.hidden = YES;
    } else if (self.mainView.frame.origin.x < 0) {
        self.rightView.hidden = NO;
    }
}


- (void)setChildrenView {
    UIView *left = [[UIView alloc] initWithFrame:
//                    [UIScreen mainScreen].bounds
                    self.view.bounds
                    ];
    left.backgroundColor = [UIColor greenColor];
    self.leftView = left;
    [self.view addSubview:self.leftView];
    
    UIView *right = [[UIView alloc] initWithFrame:
//                     [UIScreen mainScreen].bounds
                     self.view.bounds
                     ];
    right.backgroundColor = [UIColor blueColor];
    self.rightView = right;
    [self.view addSubview:self.rightView];
    
    UIView *mainV = [[UIView alloc] initWithFrame:
//                     [UIScreen mainScreen].bounds
                     self.view.bounds
                     ];
    mainV.backgroundColor = [UIColor redColor];
    self.mainView = mainV;
    [self.view addSubview:self.mainView];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(60, 120, 180, 80);
    [button setTitle:@"Back to previous" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor systemGray5Color]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
