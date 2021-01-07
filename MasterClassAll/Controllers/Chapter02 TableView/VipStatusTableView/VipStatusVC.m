//
//  VipStatusVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/5.
//

#import "VipStatusVC.h"
#import "Status.h"
#import "StatusContentCell.h"


@interface VipStatusVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray* statusArray;



@end

@implementation VipStatusVC

- (NSArray *)statusArray {
    if (_statusArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"statusArray" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *statusMutableArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            Status *status = [Status statusWithDict:dict];
            [statusMutableArray addObject:status];
        }
        
        _statusArray = statusMutableArray;
    }
    return _statusArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"StatusContentCell" bundle:nil] forCellReuseIdentifier:@"StatusContentCell"];
}

#pragma mark - TABLEVIEW DELEGATE AND DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StatusContentCell" forIndexPath:indexPath];
    
    Status *status = self.statusArray[indexPath.row];
    
    cell.status = status;
    
    return cell;
}

@end
