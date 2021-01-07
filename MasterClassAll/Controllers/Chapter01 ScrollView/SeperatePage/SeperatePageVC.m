//
//  SeperatePageVC.m
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import "SeperatePageVC.h"
#import "ZZView.h"


@interface SeperatePageVC () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *imageNames;

@property (strong, nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (weak, nonatomic) IBOutlet ZZView *zzview;
@end

@implementation SeperatePageVC

- (NSArray *)imageNames {
    if (_imageNames == nil) {
        _imageNames = [NSMutableArray array];
        [_imageNames addObject:@"ch01_img_04"];
        for (int i = 0; i < 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"ch01_img_0%i", i];
            [_imageNames addObject:imageName];
        }
        [_imageNames addObject:@"ch01_img_00"];
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.pageControl.numberOfPages = self.imageNames.count - 2;
    
    self.pageControl.layer.cornerRadius = 5;
    self.pageControl.layer.masksToBounds = YES;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    
    NSUInteger count = self.imageNames.count;
    
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    self.scrollView.pagingEnabled = YES;
    
    [self.imageNames enumerateObjectsUsingBlock:^(NSString *item, NSUInteger index, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item]];
        imageView.frame = CGRectMake(width * index, 0, width, height);
        [self.scrollView addSubview:imageView];
    }];
    
    [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    
}

- (IBAction)scrollAuto:(UIButton *)sender {
    [self startTimer];
}

- (IBAction)notAutoScroll:(UIButton *)sender {
    [self stopTimer];
}

- (void)startTimer {
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    NSUInteger page = self.pageControl.currentPage + 1;
    if (page == self.imageNames.count - 1) {
        page = 0;
    }	
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = (page + 1) * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    ZLog(@"page: %i", page);
    if (page > 5) {
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:NO];
    } else if (page == 0) {
        self.pageControl.currentPage = 4;
        [self.scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * 5, 0) animated:NO];
    } else {
        self.pageControl.currentPage = page - 1;
    }
}
    
@end
