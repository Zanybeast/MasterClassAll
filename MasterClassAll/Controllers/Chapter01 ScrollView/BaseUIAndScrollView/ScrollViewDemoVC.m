//
//  ScrollViewDemoVC.m
//  MasterClassAll
//
//  Created by carl on 2020/10/18.
//

#import "ScrollViewDemoVC.h"


@interface ScrollViewDemoVC () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ScrollViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Scroll View Demo";
    
    self.scrollView.delegate = self;
    
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.5;
    
    ZLog(@"scrollview content size width: %f, height: %f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
}

- (IBAction)toLeftMost:(UIButton *)sender {
    [self setOffSetX: 0 andY: self.scrollView.contentOffset.y];
}

- (IBAction)toTopMost:(UIButton *)sender {
    [self setOffSetX: self.scrollView.contentOffset.x andY: 0];
}

- (IBAction)toBottomMost:(UIButton *)sender {
    [UIView animateWithDuration: 1 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    } completion:nil];
}

- (IBAction)toRightMost:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.bounds.size.width, self.scrollView.contentOffset.x);
    } completion:^(BOOL finished) {
        ZLog(@"Animation finished!!!");
    }];
}

- (IBAction)setContentInset:(UIButton *)sender {
    self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
}

- (IBAction)resetContentInset:(UIButton *)sender {
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setOffSetX: (CGFloat)x andY: (CGFloat)y {
    CGPoint offSet = CGPointMake(x, y);
    [self.scrollView setContentOffset:offSet];
}


#pragma mark - DELEGATE FOR SCROLLVIEW
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    ZLog(@"scrollView content offset x: %f, y: %f",
          self.scrollView.contentOffset.x,
          self.scrollView.contentOffset.y);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    ZLog(@"Scroll View Did Zoom: %f", scrollView.zoomScale);
}

@end
