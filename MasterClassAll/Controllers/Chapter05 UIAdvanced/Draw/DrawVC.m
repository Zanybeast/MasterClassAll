//
//  DrawVC.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "DrawVC.h"
#import "ShapeView.h"
#import "LineView.h"
#import "LineView2.h"
#import "DownloadProgress.h"
#import "PieView.h"
#import "BarView.h"
#import "SnowView.h"

typedef void(^CreateViewBlock)(void);

@interface DrawVC ()

@property (assign, nonatomic) BOOL created;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) DownloadProgress *progressView;

@end

@implementation DrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)removeLastCreatedView {
    UIView *lastView = [[self.view subviews] lastObject];
    [lastView removeFromSuperview];
    lastView = nil;
    self.created = NO;
    if (self.progressView) {
        self.progressView = nil;
    }
}

#pragma mark - 按钮点击事件
- (IBAction)quaterView:(UIButton *)sender {
    [self buttonCreateViewWithView:[[ShapeView alloc] init]];
}

- (IBAction)drawLineView:(UIButton *)sender {
    [self buttonCreateViewWithView:[[LineView alloc] init]];
}

- (IBAction)drawBezierLine:(UIButton *)sender {
    [self buttonCreateViewWithView:[[LineView2 alloc] init]];
}

- (IBAction)drawProgressView:(UIButton *)sender {
    DownloadProgress *progressView = [[DownloadProgress alloc] init];
    [self buttonCreateViewWithView:progressView];
    self.progressView = progressView;
    self.progressView.progress = self.slider.value;
}

- (IBAction)drawRandomPieView:(UIButton *)sender {
    [self buttonCreateViewWithView:[[PieView alloc] init]];
}

- (IBAction)drawRandomBarView:(UIButton *)sender {
    [self buttonCreateViewWithView:[[BarView alloc] init]];
}

- (IBAction)drawSnowView:(UIButton *)sender {
    SnowView *snowView = [[SnowView alloc] init];
    [self buttonCreateViewWithView:snowView];
    snowView.backgroundColor = [UIColor blackColor];
}



- (void)buttonCreateViewWithView: (UIView *)view {
    if (self.created) {
        [self removeLastCreatedView];
    }
    
    [self createViewWith250p250:view];
}

#pragma mark - 其他控件
- (IBAction)sliderChange:(UISlider *)sender {
    if (self.progressView) {
        self.progressView.progress = sender.value;
    }
}

- (void)createViewWith250p250: (UIView *)view {
//    CGFloat barHeigth = self.navigationController.navigationBar.frame.size.height;
//    CGFloat statusHeight = self.view.window.windowScene.statusBarManager.statusBarFrame.size.height;
    view.frame = CGRectMake(self.view.frame.size.width / 2 - 125, NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT + 20, 250, 250);
    view.backgroundColor = [UIColor systemGray5Color];
    [self.view addSubview:view];
    self.created = YES;
}


@end
