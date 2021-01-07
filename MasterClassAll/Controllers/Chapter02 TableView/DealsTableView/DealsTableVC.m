//
//  DealsTableVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "DealsTableVC.h"
#import "Deal.h"
#import "DealCell.h"

@interface DealsTableVC ()

@property (strong, nonatomic) NSArray *deals;

@end

@implementation DealsTableVC

- (NSArray *)deals {
    if (_deals == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals" ofType:@"plist"];
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *dealsArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            Deal *deal = [Deal dealWithDict:dict];
            [dealsArray addObject:deal];
        }
        _deals = dealsArray;
    }
    return _deals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellReuseIdentifier:@"DealCell"];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell" forIndexPath:indexPath];
    
    Deal *deal = self.deals[indexPath.row];
    
    cell.deal = deal;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
