//
//  UIBaseAndScrollViewVC.m
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import "BaseUIAndScrollViewVC.h"
#import "ScrollViewDemoVC.h"
#import "Shop.h"
#import "ShopView.h"


#define ColumnCount 3

@interface BaseUIAndScrollViewVC ()

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
//This container view frame is (240, 300)
@property (weak, nonatomic) IBOutlet UIView *shopContainerView;
@property (weak, nonatomic) IBOutlet UIButton *toScrollViewButton;

@property(nonatomic, strong) NSArray* shops;

@property (weak, nonatomic) IBOutlet UILabel *hub;

@end

@implementation BaseUIAndScrollViewVC

- (NSArray *)shops {
    if (_shops == nil) {
        NSArray* dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"]];
        NSMutableArray* shopArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            Shop* shop = [Shop shopWithDict:dict];
            [shopArray addObject:shop];
        }
        _shops = shopArray;
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray* imagesArray = [NSMutableArray array];
    for (int i = 1; i <= 5 ; i++) {
        [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"GTSrollView%i", i]]];
    }
    [self.toScrollViewButton.imageView setAnimationImages:[imagesArray copy]];
    [self.toScrollViewButton.imageView setAnimationDuration: 0.5];
    [self.toScrollViewButton.imageView startAnimating];
    
    self.removeButton.enabled = NO;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)toScrollViewDemo {
    ZLog(@"ToScrollViewAlready");
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (IBAction)addButtonClicked:(UIButton *)sender {
    
    [self add];
}

- (IBAction)removeButtonClicked:(UIButton *)sender {
    [self remove];
}

- (IBAction)toScrollViewButtonClicked:(UIButton *)sender {
    ScrollViewDemoVC *scrollViewDemoVC = [[ScrollViewDemoVC alloc] init];
    [self.navigationController pushViewController:scrollViewDemoVC animated:YES];
}

- (void)add {
    CGFloat shopViewWidth = 70;
    CGFloat shopViewHeight = 90;
    
    int column = ColumnCount;
    
    CGFloat columnSpacing = (self.shopContainerView.frame.size.width - column * shopViewWidth) / (column - 1);
    CGFloat rowSpaceing = 15;
    
    ShopView* shopView = [ShopView shopView];
    
    NSUInteger index = self.shopContainerView.subviews.count;
    
    shopView.shop = self.shops[index];
    
    CGFloat shopViewX = (index % column) * (shopViewWidth + columnSpacing);
    CGFloat shopViewY = (index / column) * (shopViewHeight + rowSpaceing);
    
    shopView.frame = CGRectMake(shopViewX, shopViewY, shopViewWidth, shopViewHeight);
    
    [self.shopContainerView addSubview:shopView];
    
    [self checkState];
}

- (void)remove {
    [[self.shopContainerView.subviews lastObject] removeFromSuperview];
    
    [self checkState];
}

- (void)checkState {
    self.removeButton.enabled = (self.shopContainerView.subviews.count > 0);
    self.addButton.enabled = (self.shopContainerView.subviews.count < self.shops.count);
    
    NSString* text = nil;
    if (self.removeButton.enabled == NO) {
        text = @"已经删除完毕";
    } else if (self.addButton.enabled == NO) {
        text = @"已经添加满了";
    }
    
    self.hub.text = text;
    //For delay disappear hub
//    self.hub.alpha = 1.0;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.hub.alpha = 0.0;
//    });
    
    [UIView transitionWithView:self.hub
                      duration:2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        self.hub.alpha = 1.0;
    }
                    completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.hub
                          duration:2
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
            self.hub.alpha = 0.0;
        }
                        completion:nil];
    });
    
}

@end
