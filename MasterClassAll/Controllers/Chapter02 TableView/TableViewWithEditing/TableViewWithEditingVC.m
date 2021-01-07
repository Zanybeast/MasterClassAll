//
//  TableViewWithEditingVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/5.
//

#import "TableViewWithEditingVC.h"
#import "Deal.h"
#import "DealCell.h"


@interface TableViewWithEditingVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *deals;

@property (strong, nonatomic) NSMutableArray *originDeals;

@property (strong, nonatomic) NSMutableArray *imageNameArray;

@end

@implementation TableViewWithEditingVC

- (NSArray *)deals {
    if (_deals == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals" ofType:@"plist"];
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        self.originDeals = [NSMutableArray array];
        self.imageNameArray = [NSMutableArray array];
        NSMutableArray *dealsArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            if (dict[@"icon"]) {
                [self.imageNameArray addObject:dict[@"icon"]];
            }
            Deal *deal = [Deal dealWithDict:dict];
            [dealsArray addObject:[deal copy]];
            [self.originDeals addObject:deal];
        }
        _deals = dealsArray;
    }
    return _deals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellReuseIdentifier:@"DealCell"];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

- (IBAction)deleteClicked:(UIButton *)sender {
    
    if (self.deals.count > 0) {
        NSMutableArray *deletedDeals = [NSMutableArray array];
        for (Deal *deal in self.deals) {
            if (deal.isChecked) {
                [deletedDeals addObject:deal];
            }
        }
        if (deletedDeals.count > 0) {
            [self.deals removeObjectsInArray:deletedDeals];
        } else {
            [self.deals removeObjectAtIndex:0];
        }
        [self.tableView reloadData];
    }
}

- (IBAction)updatePriceClicked:(UIButton *)sender {
    if (self.deals.count > 0) {
        for (Deal *deal in self.deals) {
            NSString *originPrice = deal.price;
            NSString *priceStr = [originPrice substringFromIndex:1];
            int price = [priceStr intValue];
            price = price + (arc4random_uniform(20) - 10);
            deal.price = [NSString stringWithFormat:@"%d", price];
        }
        [self.tableView reloadData];
    }
}

- (IBAction)reset:(UIButton *)sender {
    [self.deals removeAllObjects];
    for (Deal *deal in self.originDeals) {
        [self.deals addObject:[deal copy]];
    }
    [self.tableView reloadData];
}
- (IBAction)customAddClicked:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入团购名字";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入团购价格";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        Deal *deal = [[Deal alloc] init];
        deal.title = alertController.textFields[0].text;
        deal.price = alertController.textFields[1].text;
        deal.buyCount = @"0";
        int imagesCount = (int)self.imageNameArray.count;
        deal.icon = self.imageNameArray[arc4random_uniform(imagesCount)];
        
        [self.deals insertObject:deal atIndex:0];
        [self.tableView reloadData];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)addClicked:(UIButton *)sender {
    Deal *deal = [[Deal alloc] init];
    deal.price = [NSString stringWithFormat: @"¥%d", 10 + arc4random_uniform(100)];
    deal.buyCount = [NSString stringWithFormat:@"%d", arc4random_uniform(1000)];
    deal.icon = @"5ee372ff039073317a49af5442748071";
    deal.title = [NSString stringWithFormat:@"%d 号饭店大打折 %d折", 1 + arc4random_uniform(999), arc4random_uniform(50)];
    
    [self.deals insertObject:deal atIndex:0];
    
    ZLog(@"originDeals count: %lu", (unsigned long)self.originDeals.count);
    
    [self.tableView reloadData];
}

- (IBAction)toEditModeClicked:(UIButton *)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
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
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Deal *deal = self.deals[indexPath.row];
    deal.checked = !deal.isChecked;
    
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.deals removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

@end
