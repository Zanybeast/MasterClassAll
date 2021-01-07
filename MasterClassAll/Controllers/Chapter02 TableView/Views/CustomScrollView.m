//
//  CustomScrollView.m
//  MasterClassAll
//
//  Created by carl on 2020/11/22.
//

#import "CustomScrollView.h"

@interface CustomScrollView () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CustomScrollView
 #pragma mark - 初始化调用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

#pragma mark - 构造函数
+ (instancetype)customScrollViewWith:(NSArray *)images {
    return [CustomScrollView customScrollViewWith:images selectedColor:[UIColor greenColor] deselectedColor:[UIColor lightGrayColor]];
}

+ (instancetype)customScrollViewWith:(NSArray *)images selectedColor:(UIColor *)selCol deselectedColor:(UIColor *)deselCol {
    CustomScrollView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    view.imagesArray = images;
    view.selectedColor = selCol;
    view.deselectedColor = deselCol;
    return view;
}

- (void)setup {
    self.scrollView.delegate = self;
    
    [self startTimer];
}


#pragma mark - ScrollView 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    int page = (int)(offset.x / self.scrollView.frame.size.width + 0.5);
    
    if (page == self.imagesArray.count - 1) {
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:NO];
    } else if (page == 0) {
        self.pageControl.currentPage = self.imagesArray.count - 1 - 2;
        [self.scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * (self.imagesArray.count - 2), 0) animated:NO];
    } else {
        self.pageControl.currentPage = page - 1;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

#pragma mark - 定时器开启滚动和取消滚动
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

//下一页
- (void)nextPage {
    //取出 pageControl 的页数,不是 scrollView 的子视图数目
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.imagesArray.count - 1) {
        page = 0;
    }
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = (page + 1) * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
    self.pageControl.currentPage = page;
}

//重新布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    
    unsigned long pagesCount = self.imagesArray.count;
    
    self.scrollView.contentSize = CGSizeMake(width * pagesCount, height);
    
    for (int i = 0; i < pagesCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(width * i, 0, width, height);
    }
    
    [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
}

//设置图片
- (void)setImagesArray:(NSArray *)imagesArray {

    
    NSString *lastImage = imagesArray.lastObject;
    NSString *firstImage = imagesArray.firstObject;
    
    NSMutableArray *finalArray = [NSMutableArray array];
    
    [finalArray addObject:lastImage];
    for (NSString *image in imagesArray) {
        [finalArray addObject:image];
    }
    [finalArray addObject:firstImage];
    
    _imagesArray = finalArray;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSString *image in finalArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = finalArray.count - 2;
}
//设置颜色
- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    self.pageControl.currentPageIndicatorTintColor = selectedColor;
}

- (void)setDeselectedColor:(UIColor *)deselectedColor {
    _deselectedColor = deselectedColor;
    self.pageControl.pageIndicatorTintColor = deselectedColor;
}


@end
