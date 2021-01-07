//
//  HeaderFooterVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/22.
//

#import "HeaderFooterVC.h"
#import "DealCell.h"
#import "Deal.h"
#import "CustomScrollView.h"
#import "LoadMoreView.h"

#import "NSString+Extension.h"

@interface HeaderFooterVC () <UITableViewDelegate, UITableViewDataSource, LoadMoreViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *deals;

@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation HeaderFooterVC

- (NSArray *)deals {
    if (_deals == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *data = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            Deal *deal = [Deal dealWithDict:dict];
            
            [data addObject:deal];
        }
        
        _deals = data;
    }
    return _deals;
}

- (NSMutableArray *)images {
    if (_images == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *data = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            NSString *imageName = dict[@"icon"];
            
            [data addObject:imageName];
        }
        
        _images = data;
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellReuseIdentifier:@"DealCell"];
    
    #pragma mark - 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMoreData) name:@"loadMore" object:nil];
    LoadMoreView *footer = [LoadMoreView loadMoreView];
    footer.delegate = self;
    self.tableView.tableFooterView = footer;
    
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CustomScrollView *headerView = [CustomScrollView customScrollViewWith:self.images];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 200);
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 44);
}

#pragma mark - 通知触发操作
- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        int randomCount = 1 + arc4random() % 25;
        for (int i = 0; i < randomCount; i++) {
            unsigned long lowerBound = 0;
            unsigned long upperBound = self.images.count - 1;
            unsigned long randIndex = lowerBound + arc4random() % (upperBound - lowerBound);
            NSString *image = self.images[randIndex];
            
            Deal *deal = [[Deal alloc] init];
            deal.icon = image;
            deal.buyCount = [NSString stringWithFormat:@"%d", 1 + arc4random() % 150];
            deal.price = [NSString stringWithFormat:@"%d", 5 + arc4random() % 200];
            deal.title = [[NSString alloc] randomStringWithRandomLengthLessThan:15];
            
            [self.deals addObject:deal];
        }
        
        [self.tableView reloadData];
        
        LoadMoreView *footer = (LoadMoreView *)self.tableView.tableFooterView;
        [footer endLoading];
        
//        NSUInteger count = self.deals.count;
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count - 1 inSection:0];
//        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
    
}

- (void)loadMoreViewDidClickedLoadMoreButton:(LoadMoreView *)footer {
    ZLog(@"delegate called.");
}

#pragma mark - TABLEVIEW DELEGATE AND DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell" forIndexPath:indexPath];
    
    Deal *deal = self.deals[indexPath.row];
    
    cell.deal = deal;
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
//}

#pragma mark - DEALLOC CONTROLLER
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CustomScrollView *header = [CustomScrollView customScrollViewWith:self.images];
//
//    return header;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 120;
//}

@end
